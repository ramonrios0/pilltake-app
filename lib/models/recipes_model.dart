// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

RecipeResponse recipeResponseFromJson(String str) =>
    RecipeResponse.fromJson(json.decode(str));

String recipeResponseToJson(RecipeResponse data) => json.encode(data.toJson());

class RecipeResponse {
  RecipeResponse({
    required this.recipe,
  });

  List<Recipe> recipe;

  factory RecipeResponse.fromJson(Map<String, dynamic> json) => RecipeResponse(
        recipe:
            List<Recipe>.from(json["recipe"].map((x) => Recipe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recipe": List<dynamic>.from(recipe.map((x) => x.toJson())),
      };
}

class Recipe {
  Recipe({
    required this.id,
    required this.patient,
    required this.medicine1,
    this.medicine2,
    this.medicine3,
    this.medicine4,
    required this.time1,
    this.time2,
    this.time3,
    this.time4,
    required this.quant1,
    this.quant2,
    this.quant3,
    this.quant4,
    required this.start,
    required this.end,
  });

  String id;
  String patient;
  String medicine1;
  dynamic medicine2;
  dynamic medicine3;
  dynamic medicine4;
  String time1;
  dynamic time2;
  dynamic time3;
  dynamic time4;
  String quant1;
  dynamic quant2;
  dynamic quant3;
  dynamic quant4;
  DateTime start;
  DateTime end;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        patient: json["patient"],
        medicine1: json["medicine1"],
        medicine2: json["medicine2"],
        medicine3: json["medicine3"],
        medicine4: json["medicine4"],
        time1: json["time1"],
        time2: json["time2"],
        time3: json["time3"],
        time4: json["time4"],
        quant1: json["quant1"],
        quant2: json["quant2"],
        quant3: json["quant3"],
        quant4: json["quant4"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patient": patient,
        "medicine1": medicine1,
        "medicine2": medicine2,
        "medicine3": medicine3,
        "medicine4": medicine4,
        "time1": time1,
        "time2": time2,
        "time3": time3,
        "time4": time4,
        "quant1": quant1,
        "quant2": quant2,
        "quant3": quant3,
        "quant4": quant4,
        "start":
            "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
        "end":
            "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
      };
}
