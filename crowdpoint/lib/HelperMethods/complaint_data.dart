import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowdpoint/models/complaint_model.dart';
import 'package:crowdpoint/models/user_model.dart';

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
    Stream<QuerySnapshot> complaintRefStream =
        FirebaseFirestore.instance.collection("complaints").snapshots();

    List<ComplaintModel> complaintList = [];
    return complaintRefStream.map((qshot) {
      return qshot.docs.map((doc) {
        print(doc.data());

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
    CollectionReference complaintRef =
        FirebaseFirestore.instance.collection("complaints");
    complaintRef
        .doc(complaint.id)
        .update({"upVotes": complaint.upVotes + 1})
        .then((value) => print("Upvoted Complaint"))
        .catchError((error) => print("Failed to Upvote Complaint: $error"));
  }

  static downVoteComplaint(ComplaintModel complaint) async {
    CollectionReference complaintRef =
        FirebaseFirestore.instance.collection("complaints");
    complaintRef
        .doc(complaint.id)
        .update({"downVotes": complaint.downVotes + 1})
        .then((value) => print("Downvoted Complaint"))
        .catchError((error) => print("Failed to Downvote Complaint: $error"));
  }
}
