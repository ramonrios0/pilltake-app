// To parse this JSON data, do
//
//     final deviceMedicines = deviceMedicinesFromJson(jsonString);

import 'dart:convert';

DeviceMedicines deviceMedicinesFromJson(String str) =>
    DeviceMedicines.fromJson(json.decode(str));

String deviceMedicinesToJson(DeviceMedicines data) =>
    json.encode(data.toJson());

class DeviceMedicines {
  DeviceMedicines({
    required this.result,
  });

  List<Result> result;

  factory DeviceMedicines.fromJson(Map<String, dynamic> json) =>
      DeviceMedicines(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.medicine1,
    required this.medicine2,
    required this.medicine3,
    required this.medicine4,
  });

  String medicine1;
  String medicine2;
  String medicine3;
  String medicine4;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        medicine1: json["medicine1"],
        medicine2: json["medicine2"],
        medicine3: json["medicine3"],
        medicine4: json["medicine4"],
      );

  Map<String, dynamic> toJson() => {
        "medicine1": medicine1,
        "medicine2": medicine2,
        "medicine3": medicine3,
        "medicine4": medicine4,
      };
}
