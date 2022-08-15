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
    required this.patient,
  });

  List<Patient> patient;

  factory PatientResponse.fromJson(Map<String, dynamic> json) =>
      PatientResponse(
        patient: List<Patient>.from(
            json["patients"].map((x) => Patient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "patients": List<dynamic>.from(patient.map((x) => x.toJson())),
      };
}

class Patient {
  Patient({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
  });

  int id;
  String name;
  DateTime start;
  DateTime end;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: int.parse(json["id"]),
        name: json["name"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start":
            "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
        "end":
            "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
      };
}
