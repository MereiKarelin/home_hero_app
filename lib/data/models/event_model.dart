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
  final DateTime endDate;
  final String address;
  final String eventType;

  EventModel({
    required this.id,
    required this.leaderUserId,
    required this.followingUserId,
    required this.title,
    required this.description,
    required this.assignedDate,
    required this.executionDate,
    required this.endDate,
    required this.address,
    required this.eventType,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        leaderUserId: json["leaderUserId"],
        followingUserId: json["followingUserId"],
        title: json["title"],
        description: json["description"],
        assignedDate: DateTime.parse(json["assignedDate"]),
        executionDate: DateTime.parse(json["executionDate"]),
        endDate: DateTime.parse(json["endDate"]),
        address: json["address"],
        eventType: json["eventType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leaderUserId": leaderUserId,
        "followingUserId": followingUserId,
        "title": title,
        "description": description,
        "assignedDate": assignedDate.toIso8601String(),
        "executionDate": executionDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "address": address,
        "eventType": eventType,
      };
}
