// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:crowdpoint/HelperMethods/complaint_data.dart';
import 'package:crowdpoint/models/comments_model.dart';
import 'package:crowdpoint/models/complaint_model.dart';

class CommentListModel {
  List<CommentModel> commentList = [];

  CommentListModel({
    required this.commentList,
  });

  CommentListModel.getComplaints(docId) {
    FirebaseFirestore.instance
        .collection("complaints")
        .doc(docId)
        .collection("comments")
        .get()
        .then((value) {
      for (var data in value.docs) {
        if (data != null) {
          commentList.add(CommentModel.fromMap(data.data()));
        }
      }
    });
  }

  CommentListModel copyWith({
    List<CommentModel>? commentList,
  }) {
    return CommentListModel(
      commentList: commentList ?? this.commentList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentList': commentList.map((x) => x.toMap()).toList(),
    };
  }

  factory CommentListModel.fromMap(Map<String, dynamic> map) {
    return CommentListModel(
      commentList: List<CommentModel>.from(
        (map['commentList'] as List<int>).map<CommentModel>(
          (x) => CommentModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentListModel.fromJson(String source) =>
      CommentListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CommentListModel(commentList: $commentList)';

  @override
  bool operator ==(covariant CommentListModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.commentList, commentList);
  }

  @override
  int get hashCode => commentList.hashCode;
}
