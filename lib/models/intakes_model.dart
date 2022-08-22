// To parse this JSON data, do
//
//     final intakesResponse = intakesResponseFromJson(jsonString);

import 'dart:convert';

IntakesResponse intakesResponseFromJson(String str) =>
    IntakesResponse.fromJson(json.decode(str));

String intakesResponseToJson(IntakesResponse data) =>
    json.encode(data.toJson());

class IntakesResponse {
  IntakesResponse({
    required this.intakes,
  });

  List<Intake> intakes;

  factory IntakesResponse.fromJson(Map<String, dynamic> json) =>
      IntakesResponse(
        intakes:
            List<Intake>.from(json["intakes"].map((x) => Intake.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "intakes": List<dynamic>.from(intakes.map((x) => x.toJson())),
      };
}

class Intake {
  Intake({
    required this.id,
    required this.medicine,
    required this.taken,
    required this.patient,
    required this.time,
    this.intakeTime,
  });

  int id;
  String medicine;
  int taken;
  int patient;
  DateTime time;
  String? intakeTime;

  factory Intake.fromJson(Map<String, dynamic> json) => Intake(
        id: int.parse(json["id"]),
        medicine: json["medicine"],
        taken: int.parse(json["taken"]),
        patient: int.parse(json["patient"]),
        time: DateTime.parse(json["time"]),
        intakeTime: json["intakeTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "medicine": medicine,
        "taken": taken,
        "patient": patient,
        "time": time.toIso8601String(),
        "intakeTime": intakeTime,
      };
}
