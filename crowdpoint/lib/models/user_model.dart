// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String name;
  String email;
  String dpurl;
  String aadharNo;
  UserModel({
    required this.name,
    required this.email,
    required this.dpurl,
    required this.aadharNo,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? dpurl,
    String? aadharNo,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      dpurl: dpurl ?? this.dpurl,
      aadharNo: aadharNo ?? this.aadharNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'dpurl': dpurl,
      'aadharNo': aadharNo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      dpurl: map['dpurl'] as String,
      aadharNo: map['aadharNo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, dpurl: $dpurl, aadharNo: $aadharNo)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.dpurl == dpurl &&
        other.aadharNo == aadharNo;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ dpurl.hashCode ^ aadharNo.hashCode;
  }
}
