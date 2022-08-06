// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:crowdpoint/models/comments_model.dart';
import 'package:crowdpoint/models/complaint_list_model.dart';
import 'package:crowdpoint/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ComplaintModel {
  int upVotes;
  int downVotes;
  DateTime dateTime;
  UserModel user;
  String description;
  LatLng latlng;
  String id;
  List<String> photoUrls;
  CommentListModel? comments;
  bool completed;
  ComplaintModel({
    this.upVotes = 0,
    this.downVotes = 0,
    required this.dateTime,
    required this.user,
    required this.description,
    required this.latlng,
    required this.id,
    required this.photoUrls,
    this.comments,
    this.completed = false,
  });

  ComplaintModel copyWith({
    int? upVotes,
    int? downVotes,
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
      upVotes: upVotes ?? this.upVotes,
      downVotes: downVotes ?? this.downVotes,
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
      'upVotes': upVotes,
      'downVotes': downVotes,
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
      upVotes: map['upVotes'] as int,
      downVotes: map['downVotes'] as int,
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
    return 'ComplaintModel(upVotes: $upVotes, downVotes: $downVotes, dateTime: $dateTime, user: $user, description: $description, latlng: $latlng, id: $id, photoUrls: $photoUrls, comments: $comments, completed: $completed)';
  }

  @override
  bool operator ==(covariant ComplaintModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.upVotes == upVotes &&
        other.downVotes == downVotes &&
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
    return upVotes.hashCode ^
        downVotes.hashCode ^
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
