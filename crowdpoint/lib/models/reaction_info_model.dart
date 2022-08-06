// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:crowdpoint/enums.dart';
import 'package:crowdpoint/models/user_model.dart';

class ReactionInfoModel {
  React react;
  UserModel user;
  DateTime dateTime;
  ReactionInfoModel({
    required this.react,
    required this.user,
    required this.dateTime,
  });

  ReactionInfoModel copyWith({
    React? react,
    UserModel? user,
    DateTime? dateTime,
  }) {
    return ReactionInfoModel(
      react: react ?? this.react,
      user: user ?? this.user,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'react': react.index,
      'user': user.toMap(),
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  factory ReactionInfoModel.fromJson(String source) =>
      ReactionInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReactionInfoModel(react: $react, user: $user, dateTime: $dateTime)';

  @override
  bool operator ==(covariant ReactionInfoModel other) {
    if (identical(this, other)) return true;

    return other.react == react &&
        other.user == user &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode => react.hashCode ^ user.hashCode ^ dateTime.hashCode;

  factory ReactionInfoModel.fromMap(map) {
    return ReactionInfoModel(
      react: React.values[map['react']],
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }
}
