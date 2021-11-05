import 'dart:convert';

class MarketPost {
  static String title = '';
  static String description = '';
  static String? category = '';
  static String price = '';
  static String? city = '';
  static List images = [];
  static String imgLength = '';
  static String posting_person_phone = '';
  static String posting_person_name = '';
  static String posting_person_image = '';
}

// To parse required this JSON data, do
//
//     final ads = adsFromJson(jsonString);

List<Ads> adsFromJson(String str) =>
    List<Ads>.from(json.decode(str).map((x) => Ads.fromJson(x)));

String adsToJson(List<Ads> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ads {
  Ads({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.city,
    required this.imgLength,
    required this.images,
    required this.person,
    required this.photo,
    required this.phone,
  });

  String id;
  String title;
  String price;
  String category;
  String description;
  String city;
  String imgLength;
  String images;
  String person;
  String photo;
  String phone;

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        id: json["_id"],
        title: json["title"],
        price: json["price"],
        category: json["category"],
        description: json["description"],
        city: json["city"],
        imgLength: json["imgLength"],
        images: json["images"],
        person: json["person"],
        photo: json["photo"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "price": price,
        "category": category,
        "description": description,
        "city": city,
        "imgLength": imgLength,
        "images": images,
        "person": person,
        "photo": photo,
        "phone": phone,
      };
}
