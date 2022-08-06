import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowdpoint/enums.dart';
import 'package:crowdpoint/models/complaint_model.dart';
import 'package:crowdpoint/models/reaction_info_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ComplaintData {
  static Future<List<ComplaintModel>> getComplaints() async {
    CollectionReference complaintRef =
        FirebaseFirestore.instance.collection("complaints");
    var snapshot = await complaintRef.get();
    List<ComplaintModel> complaintList = [];
    for (var data in snapshot.docs) {
      ComplaintModel complaint = ComplaintModel.fromMap(data);
      complaintList.add(complaint);
    }

    return complaintList;
  }

  static Stream<List<ComplaintModel>> getComplaintsStream() {
    Stream<QuerySnapshot> complaintRefStream = FirebaseFirestore.instance
        .collection("complaints")
        .orderBy('dateTime', descending: true)
        .snapshots();

    List<ComplaintModel> complaintList = [];
    return complaintRefStream.map((qshot) {
      return qshot.docs.map((doc) {
        // print(doc.data());

        return ComplaintModel.fromMap(doc);
      }).toList();
    });
  }

  static uploadComplaint(ComplaintModel complaint) async {
    CollectionReference complaintRef =
        FirebaseFirestore.instance.collection("complaints");
    return complaintRef
        .doc(complaint.id)
        .set(complaint.toMap())
        .then((value) => print("Complaint Added"))
        .catchError((error) => print("Failed to add complaint: $error"));
  }

  static upvoteComplaint(ComplaintModel complaint) async {
    ReactionInfoModel reactionInfoModel = ReactionInfoModel(
        react: React.NO_REACTION,
        user: complaint.user,
        dateTime: DateTime.now());
    var complaintRef = FirebaseFirestore.instance
        .collection("complaints")
        .doc(complaint.id)
        .collection('reactions')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    complaintRef.get().then((value) {
      // print(value.data());
      if (value.data() != null) {
        reactionInfoModel = ReactionInfoModel.fromMap(value.data());
      }
    });

    switch (reactionInfoModel.react) {
      case React.NO_REACTION:
        {
          ReactionInfoModel reaction = ReactionInfoModel(
              react: React.UPVOTE,
              user: complaint.user,
              dateTime: DateTime.now());
          complaintRef.set(reaction.toMap());
          break;
        }
      case React.UPVOTE:
        {
          break;
        }
      case React.DOWNVOTE:
        {
          complaintRef.update({"react": React.UPVOTE.index});
          break;
        }
    }
  }

  static downVoteComplaint(ComplaintModel complaint) async {
    ReactionInfoModel reactionInfoModel = ReactionInfoModel(
        react: React.NO_REACTION,
        user: complaint.user,
        dateTime: DateTime.now());
    var complaintRef = FirebaseFirestore.instance
        .collection("complaints")
        .doc(complaint.id)
        .collection('reactions')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    complaintRef.get().then((value) {
      if (value.data() != null) {
        reactionInfoModel = ReactionInfoModel.fromMap(value.data());
      }
    });

    switch (reactionInfoModel.react) {
      case React.NO_REACTION:
        {
          complaintRef.update({"react": React.DOWNVOTE.index});
          break;
        }
      case React.UPVOTE:
        {
          complaintRef.update({"react": React.DOWNVOTE.index});
          break;
        }
      case React.DOWNVOTE:
        {
          break;
        }
      default:
        {
          complaintRef.update({"react": React.DOWNVOTE.index});
          break;
        }
    }
  }

  static Stream<List<ReactionInfoModel>> getVotescount(
      ComplaintModel complaint) {
    int upvotes = 0;
    int downvotes = 0;
    List<ReactionInfoModel> reactionList = [];
    ReactionInfoModel? reactionInfoModel;
    var complaintRefStream = FirebaseFirestore.instance
        .collection("complaints")
        .doc(complaint.id)
        .collection('reactions')
        .snapshots();
    return complaintRefStream.map((qshot) {
      return qshot.docs.map((doc) {
        // print(doc.data());

        return ReactionInfoModel.fromMap(doc.data());
      }).toList();
    });
    //  .get().then((value) {
    //   for (var data in value.docs){
    //     reactionInfoModel = ReactionInfoModel.fromMap(data.data());
    //     reactionList.add(reactionInfoModel!);
    //   }

    //  });

    //      for (var data in list){
    //       if(data.react==React.UPVOTE){
    //         upvotes++;
    //       }
    //       else if(data.react==React.DOWNVOTE){
    //         downvotes++;
    //       }
    //      }
    //  Map map ={
    //   "upvotes":upvotes,
    //   "downvotes":downvotes,
    //  };
  }
}
