// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String name;
  String email;
  String dpurl;
  String? aadharNo;
  String? messagingToken;
  UserModel({
    required this.name,
    required this.email,
    required this.dpurl,
    this.aadharNo,
    this.messagingToken,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? dpurl,
    String? aadharNo,
    String? messagingToken,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      dpurl: dpurl ?? this.dpurl,
      aadharNo: aadharNo ?? this.aadharNo,
      messagingToken: messagingToken ?? this.messagingToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'dpurl': dpurl,
      'aadharNo': aadharNo,
      'messagingToken': messagingToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      dpurl: map['dpurl'] as String,
      aadharNo: map['aadharNo'] != null ? map['aadharNo'] as String : null,
      messagingToken: map['messagingToken'] != null
          ? map['messagingToken'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, dpurl: $dpurl, aadharNo: $aadharNo, messagingToken: $messagingToken)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.dpurl == dpurl &&
        other.aadharNo == aadharNo &&
        other.messagingToken == messagingToken;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        dpurl.hashCode ^
        aadharNo.hashCode ^
        messagingToken.hashCode;
  }
}
