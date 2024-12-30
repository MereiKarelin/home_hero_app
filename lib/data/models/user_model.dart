import 'package:flutter/material.dart';

@immutable
class User {
  final int? id;
  final String? number;
  final String? password;
  final String? userType;
  final int? followingSlots;
  final String? name;
  final bool? subscriptionActive;
  final String? confirmationCode;
  final bool? confirmed;

  const User({
    this.id,
    this.number,
    this.password,
    this.userType,
    this.followingSlots,
    this.name,
    this.subscriptionActive,
    this.confirmationCode,
    this.confirmed,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      number: json['number'] as String?,
      password: json['password'] as String?,
      userType: json['userType'] as String?,
      followingSlots: json['followingSlots'] as int?,
      name: json['name'] as String?,
      subscriptionActive: json['subscriptionActive'] as bool?,
      confirmationCode: json['confirmationCode'] as String?,
      confirmed: json['confirmed'] as bool?,
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'password': password,
      'userType': userType?.toString().split('.').last,
      'followingSlots': followingSlots,
      'name': name,
      'subscriptionActive': subscriptionActive,
      'confirmationCode': confirmationCode,
      'confirmed': confirmed,
    };
  }
}
