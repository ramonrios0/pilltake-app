// To parse this JSON data, do
//
//     final medicines = medicinesFromJson(jsonString);

import 'dart:convert';

Medicines medicinesFromJson(String str) => Medicines.fromJson(json.decode(str));

String medicinesToJson(Medicines data) => json.encode(data.toJson());

class Medicines {
  Medicines({
    required this.medicines,
  });

  List<Medicine> medicines;

  factory Medicines.fromJson(Map<String, dynamic> json) => Medicines(
        medicines: List<Medicine>.from(
            json["medicines"].map((x) => Medicine.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "medicines": List<dynamic>.from(medicines.map((x) => x.toJson())),
      };
}

class Medicine {
  Medicine({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
