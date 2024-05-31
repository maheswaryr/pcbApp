// To parse this JSON data, do
//
//     final autoCompModel = autoCompModelFromJson(jsonString);

import 'dart:convert';

AutoCompModel autoCompModelFromJson(String str) =>
    AutoCompModel.fromJson(json.decode(str));

String autoCompModelToJson(AutoCompModel data) => json.encode(data.toJson());

class AutoCompModel {
  AutoCompModel({
    this.searchQuery,
  });

  String? searchQuery;

  factory AutoCompModel.fromJson(Map<String, dynamic> json) => AutoCompModel(
        searchQuery: json["searchQuery"],
      );

  Map<String, dynamic> toJson() => {
        "searchQuery": searchQuery,
      };
}
