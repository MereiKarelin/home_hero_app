// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  String? name;
  String number;
  String? location;
  String? address;
  String? imageId;
  String? birthDate;
  String? email;
  String? description;
  String? url;
  int id;

  UserInfoModel({
    required this.name,
    required this.number,
    required this.location,
    required this.address,
    required this.imageId,
    required this.id,
    this.birthDate,
    this.email,
    this.description,
    this.url,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        name: json["name"],
        number: json["number"],
        location: json["location"],
        address: json["address"],
        imageId: json["image_id"],
        birthDate: json["birth_date"],
        email: json["email"],
        description: json["description"],
        url: json["url"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
        "location": location,
        "address": address,
        "image_id": imageId,
        "birth_date": birthDate,
        "email": email,
        "description": description,
        "url": url,
        "id": id,
      };
}
