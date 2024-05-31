// To parse this JSON data, do
//
//     final autoCompModelRes = autoCompModelResFromJson(jsonString);

import 'dart:convert';

List<String> autoCompModelResFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String autoCompModelResToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));
