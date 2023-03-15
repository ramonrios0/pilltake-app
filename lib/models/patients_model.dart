// To parse this JSON data, do
//
//     final patientResponse = patientResponseFromJson(jsonString);

import 'dart:convert';

PatientResponse patientResponseFromJson(String str) =>
    PatientResponse.fromJson(json.decode(str));

String patientResponseToJson(PatientResponse data) =>
    json.encode(data.toJson());

class PatientResponse {
  PatientResponse({
    required this.patients,
  });

  List<Patient> patients;

  factory PatientResponse.fromJson(Map<String, dynamic> json) =>
      PatientResponse(
        patients: List<Patient>.from(
            json["patients"].map((x) => Patient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "patients": List<dynamic>.from(patients.map((x) => x.toJson())),
      };
}

class Patient {
  Patient({
    required this.id,
    required this.name,
    this.start,
    this.end,
  });

  String id;
  String name;
  DateTime? start;
  DateTime? end;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        name: json["name"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start":
            "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "end":
            "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
      };
}
