import 'package:datex/features/core/d_color.dart';
import 'package:flutter/material.dart';

class DTextStyle {
  static const primaryWhiteText = TextStyle(fontWeight: FontWeight.w600, color: DColor.whiteTextColor);
  static const boldBlackText = TextStyle(fontWeight: FontWeight.bold, color: DColor.blackTextColor);
  static const urlText = TextStyle(
    fontSize: 18,
    color: DColor.blueColor,
    decoration: TextDecoration.underline,
  );
}
