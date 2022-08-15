// To parse this JSON data, do
//
//     final intakesNamedResponse = intakesNamedResponseFromJson(jsonString);

import 'dart:convert';

IntakesNamedResponse intakesNamedResponseFromJson(String str) =>
    IntakesNamedResponse.fromJson(json.decode(str));

String intakesNamedResponseToJson(IntakesNamedResponse data) =>
    json.encode(data.toJson());

class IntakesNamedResponse {
  IntakesNamedResponse({
    required this.intakes,
    required this.remaining,
  });

  List<Intake> intakes;
  List<Intake> remaining;

  factory IntakesNamedResponse.fromJson(Map<String, dynamic> json) =>
      IntakesNamedResponse(
        intakes:
            List<Intake>.from(json["intakes"].map((x) => Intake.fromJson(x))),
        remaining:
            List<Intake>.from(json["remaining"].map((x) => Intake.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "intakes": List<dynamic>.from(intakes.map((x) => x.toJson())),
        "remaining": List<dynamic>.from(remaining.map((x) => x.toJson())),
      };
}

class Intake {
  Intake({
    required this.name,
    required this.medicine,
    required this.taken,
    required this.time,
  });

  String name;
  String medicine;
  int taken;
  DateTime time;

  factory Intake.fromJson(Map<String, dynamic> json) => Intake(
        name: json["name"],
        medicine: json["medicine"],
        taken: int.parse(json["taken"]),
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "medicine": medicine,
        "taken": taken,
        "time": time.toIso8601String(),
      };
}
