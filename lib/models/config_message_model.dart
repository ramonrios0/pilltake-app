// To parse this JSON data, do
//
//     final configmessage = configmessageFromJson(jsonString);

import 'dart:convert';

ConfigMessage configmessageFromJson(String str) =>
    ConfigMessage.fromJson(json.decode(str));

String configmessageToJson(ConfigMessage data) => json.encode(data.toJson());

class ConfigMessage {
  ConfigMessage({
    required this.result,
  });

  List<Result> result;

  factory ConfigMessage.fromJson(Map<String, dynamic> json) => ConfigMessage(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.message,
  });

  String message;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
