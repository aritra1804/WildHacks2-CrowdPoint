// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:crowdpoint/enums.dart';
import 'package:crowdpoint/models/comment_list_model.dart';
import 'package:crowdpoint/models/comments_model.dart';
import 'package:crowdpoint/models/reaction_info_model.dart';
import 'package:crowdpoint/models/reaction_list_model.dart';
import 'package:crowdpoint/models/user_model.dart';

class ComplaintModel {
  ReactionListModel? reaction;
  DateTime dateTime;
  UserModel user;
  String description;
  LatLng latlng;
  String id;
  List<String> photoUrls;
  CommentListModel? comments;
  bool completed;
  ComplaintModel({
    this.reaction,
    required this.dateTime,
    required this.user,
    required this.description,
    required this.latlng,
    required this.id,
    required this.photoUrls,
    this.comments,
    required this.completed,
  });

  ComplaintModel copyWith({
    ReactionListModel? reaction,
    DateTime? dateTime,
    UserModel? user,
    String? description,
    LatLng? latlng,
    String? id,
    List<String>? photoUrls,
    CommentListModel? comments,
    bool? completed,
  }) {
    return ComplaintModel(
      reaction: reaction ?? this.reaction,
      dateTime: dateTime ?? this.dateTime,
      user: user ?? this.user,
      description: description ?? this.description,
      latlng: latlng ?? this.latlng,
      id: id ?? this.id,
      photoUrls: photoUrls ?? this.photoUrls,
      comments: comments ?? this.comments,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reaction': reaction?.toMap(),
      'dateTime': dateTime.millisecondsSinceEpoch,
      'user': user.toMap(),
      'description': description,
      'latlng': latlng.toJson(),
      'id': id,
      'photoUrls': photoUrls,
      'comments': comments?.toMap(),
      'completed': completed,
    };
  }

  factory ComplaintModel.fromMap(map1) {
    var map = map1.data();
    return ComplaintModel(
      reaction: ReactionListModel.getReactions(map1.id),
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      description: map['description'] as String,
      latlng: LatLng.fromJson(map['latlng'] as Map<String, dynamic>),
      id: map['id'] as String,
      photoUrls: List<String>.from((map['photoUrls'])),
      comments: CommentListModel.getComplaints(map1.id),
      completed: map['completed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplaintModel.fromJson(String source) =>
      ComplaintModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ComplaintModel(reaction: $reaction, dateTime: $dateTime, user: $user, description: $description, latlng: $latlng, id: $id, photoUrls: $photoUrls, comments: $comments, completed: $completed)';
  }

  @override
  bool operator ==(covariant ComplaintModel other) {
    if (identical(this, other)) return true;

    return other.reaction == reaction &&
        other.dateTime == dateTime &&
        other.user == user &&
        other.description == description &&
        other.latlng == latlng &&
        other.id == id &&
        listEquals(other.photoUrls, photoUrls) &&
        other.comments == comments &&
        other.completed == completed;
  }

  @override
  int get hashCode {
    return reaction.hashCode ^
        dateTime.hashCode ^
        user.hashCode ^
        description.hashCode ^
        latlng.hashCode ^
        id.hashCode ^
        photoUrls.hashCode ^
        comments.hashCode ^
        completed.hashCode;
  }
}
