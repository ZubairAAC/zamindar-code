// To parse this JSON data, do
//
//     final info = infoFromJson(jsonString);

import 'dart:convert';

List<Info> infoFromJson(String str) =>
    List<Info>.from(json.decode(str).map((x) => Info.fromJson(x)));

String infoToJson(List<Info> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Info {
  Info({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  String id;
  String title;
  String description;
  String image;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "image": image,
      };
}
