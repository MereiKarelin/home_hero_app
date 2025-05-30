// lib/data/models/subscription_model.dart

enum SubscriptionTypeModel { BASIC, STANDARD, PREMIUM }

class SubscriptionModel {
  final int id;
  final int userId;
  final SubscriptionTypeModel type;
  final DateTime startDate;
  final DateTime endDate;

  SubscriptionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.startDate,
    required this.endDate,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      type: SubscriptionTypeModel.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.toString().split('.').last,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}
