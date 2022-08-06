// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:crowdpoint/models/user_model.dart';

class CommentModel {
  String comment;
  DateTime dateTime;
  UserModel user;
  CommentModel({
    required this.comment,
    required this.dateTime,
    required this.user,
  });

  CommentModel copyWith({
    String? comment,
    DateTime? dateTime,
    UserModel? user,
  }) {
    return CommentModel(
      comment: comment ?? this.comment,
      dateTime: dateTime ?? this.dateTime,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'user': user.toMap(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: map['comment'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CommentModel(comment: $comment, dateTime: $dateTime, user: $user)';

  @override
  bool operator ==(covariant CommentModel other) {
    if (identical(this, other)) return true;

    return other.comment == comment &&
        other.dateTime == dateTime &&
        other.user == user;
  }

  @override
  int get hashCode => comment.hashCode ^ dateTime.hashCode ^ user.hashCode;
}
