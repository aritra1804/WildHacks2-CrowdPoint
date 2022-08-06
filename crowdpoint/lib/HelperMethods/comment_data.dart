import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowdpoint/models/comments_model.dart';
import 'package:crowdpoint/models/complaint_list_model.dart';

class CommentData {
  static addComment(String complaintId, CommentModel comment) async {
    CollectionReference commentRef = FirebaseFirestore.instance
        .collection("complaints")
        .doc(complaintId)
        .collection("comments");
    return commentRef
        .doc(comment.dateTime.toString())
        .set(comment.toMap())
        .then((value) {
      print(comment.toMap());
      print("Comment Added");
    }).catchError((error) => print("Failed to add comment: $error"));
  }
}
