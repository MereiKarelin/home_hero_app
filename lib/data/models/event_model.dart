// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  final int id;
  final int leaderUserId;
  final int followingUserId;
  final String title;
  final String description;
  final DateTime assignedDate;
  final DateTime executionDate;
  final DateTime? endDate; // делаем nullable, вдруг на бэке endDate = null
  final String address;
  final String eventType;

  // Новые поля
  final String repeatPeriod; // "ONCE", "MONTHLY", "QUARTERLY", "SEMIANNUALLY", "ANNUALLY"
  final List<String> imageIds; // Список ID изображений (может быть пустой)
  final String? leadingStatus; // "PROGRESS", "DONE", "PENDING" или null
  final String? followingStatus; // то же самое
  final String? progressInfo; // доп. информация
  final String? comment; // комментарий
  final bool? confirmed; // подтверждено ли

  EventModel({
    required this.id,
    required this.leaderUserId,
    required this.followingUserId,
    required this.title,
    required this.description,
    required this.assignedDate,
    required this.executionDate,
    this.endDate,
    required this.address,
    required this.eventType,

    // Новые поля
    required this.repeatPeriod,
    required this.imageIds,
    this.leadingStatus,
    this.followingStatus,
    this.progressInfo,
    this.comment,
    this.confirmed,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"],
      leaderUserId: json["leaderUserId"],
      followingUserId: json["followingUserId"],
      title: json["title"],
      description: json["description"],
      assignedDate: DateTime.parse(json["assignedDate"]),
      executionDate: DateTime.parse(json["executionDate"]),
      endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      address: json["address"],
      eventType: json["eventType"] ?? "REGULAR", // на случай, если поле не придёт

      // Новые поля
      repeatPeriod: json["repeatPeriod"] ?? "ONCE", // по умолчанию ONCE
      imageIds: json["imageIds"] == null ? [] : List<String>.from(json["imageIds"].map((x) => x)),
      leadingStatus: json["leadingStatus"], // может быть null
      followingStatus: json["followingStatus"], // может быть null
      progressInfo: json["progressInfo"], // может быть null
      comment: json["comment"], // может быть null
      confirmed: json["confirmed"], // может быть bool или null
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "leaderUserId": leaderUserId,
        "followingUserId": followingUserId,
        "title": title,
        "description": description,
        "assignedDate": assignedDate.toIso8601String(),
        "executionDate": executionDate.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "address": address,
        "eventType": eventType,

        // Новые поля
        "repeatPeriod": repeatPeriod,
        "imageIds": List<dynamic>.from(imageIds.map((x) => x)),
        "leadingStatus": leadingStatus,
        "followingStatus": followingStatus,
        "progressInfo": progressInfo,
        "comment": comment,
        "confirmed": confirmed,
      };
}
