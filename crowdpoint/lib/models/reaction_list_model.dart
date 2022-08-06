// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:crowdpoint/models/reaction_info_model.dart';

class ReactionListModel {
  List<ReactionInfoModel> reactionList = [];
  ReactionListModel({
    required this.reactionList,
  });

  ReactionListModel.getReactions(docId) {
    FirebaseFirestore.instance
        .collection("complaints")
        .doc(docId)
        .collection("reactions")
        .get()
        .then((value) {
      for (var data in value.docs) {
        if (data != null) {
          reactionList.add(ReactionInfoModel.fromMap(data.data()));
        }
      }
    });
  }

  ReactionListModel copyWith({
    List<ReactionInfoModel>? reactionList,
  }) {
    return ReactionListModel(
      reactionList: reactionList ?? this.reactionList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reactionList': reactionList.map((x) => x.toMap()).toList(),
    };
  }

  factory ReactionListModel.fromMap(Map<String, dynamic> map) {
    return ReactionListModel(
      reactionList: List<ReactionInfoModel>.from(
        (map['reactionList'] as List<int>).map<ReactionInfoModel>(
          (x) => ReactionInfoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReactionListModel.fromJson(String source) =>
      ReactionListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReactionListModel(reactionList: $reactionList)';

  @override
  bool operator ==(covariant ReactionListModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.reactionList, reactionList);
  }

  @override
  int get hashCode => reactionList.hashCode;
}
