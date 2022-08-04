// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.manager,
    required this.medic,
  });

  List<Manager> manager;
  List<Manager> medic;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        manager:
            List<Manager>.from(json["manager"].map((x) => Manager.fromJson(x))),
        medic:
            List<Manager>.from(json["medic"].map((x) => Manager.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "manager": List<dynamic>.from(manager.map((x) => x.toJson())),
        "medic": List<dynamic>.from(medic.map((x) => x.toJson())),
      };
}

class Manager {
  Manager({
    required this.name,
    required this.email,
    required this.contact,
  });

  String name;
  String email;
  String contact;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "contact": contact,
      };
}
