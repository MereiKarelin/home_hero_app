import 'package:datex/features/core/d_color.dart';
import 'package:flutter/material.dart';

class DTextStyle {
  static const primaryWhiteText = TextStyle(fontWeight: FontWeight.w600, color: DColor.whiteTextColor, fontSize: 21, fontFamily: 'inter');
  static const primaryText = TextStyle(fontWeight: FontWeight.w400, color: DColor.blackTextColor, fontSize: 12, fontFamily: 'inter');
  static const boldBlackText = TextStyle(fontWeight: FontWeight.bold, color: DColor.blackTextColor, fontFamily: 'inter');
  static const urlText = TextStyle(
    fontSize: 18,
    color: DColor.blueColor,
    fontFamily: 'inter',
    decoration: TextDecoration.underline,
  );
  static const blueText = TextStyle(
    fontSize: 18,
    color: DColor.blueColor,
    fontFamily: 'inter',
  );
}
