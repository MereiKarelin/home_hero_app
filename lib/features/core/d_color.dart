import 'package:flutter/material.dart';

class DColor {
  static const MaterialColor primaryGreen = MaterialColor(
    0xFF09A9FF,
    <int, Color>{
      50: Color(0xFFE6F9FF),
      100: Color(0xFFC0F1FF),
      200: Color(0xFF99E7FF),
      300: Color(0xFF4DD5FF),
      400: Color(0xFF26C9FF),
      500: Color(0xFF09A9FF), // base
      600: Color(0xFF0797E6),
      700: Color(0xFF0587CC),
      800: Color(0xFF0473B3),
      900: Color(0xFF035080),
    },
  );

  // Акцентный оранжевый
  static const MaterialColor accentOrange = MaterialColor(
    0xFFFFCF7D,
    <int, Color>{
      50: Color(0xFFFFFAF1),
      100: Color(0xFFFFF1D9),
      200: Color(0xFFFFE6B1),
      300: Color(0xFFFFDB89),
      400: Color(0xFFFFD26D),
      500: Color(0xFFFFCF7D),
      600: Color(0xFFE6B56F),
      700: Color(0xFFCC9961),
      800: Color(0xFFB38053),
      900: Color(0xFF805235),
    },
  );

  static const Gradient primaryGreenGradient = LinearGradient(
    colors: [
      Color.fromRGBO(0, 123, 255, 1), // яркий синий
      Color.fromRGBO(0, 105, 217, 1),
      Color.fromRGBO(0, 90, 198, 1),
    ],
  );

  static const Gradient primaryGreenUnselectedGradient = LinearGradient(
    colors: [
      Color.fromRGBO(0, 123, 255, 0.7),
      Color.fromRGBO(0, 105, 217, 0.7),
      Color.fromRGBO(0, 90, 198, 0.7),
    ],
  );

  static const Color whiteColor = Colors.white;
  static const Color whiteTextColor = Colors.white;
  static const Color blackTextColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color greyColor = Color.fromRGBO(131, 130, 131, 1);
  static const Color greyUnselectedColor = Color.fromRGBO(131, 130, 131, 0.7);
  static const Color unselectedColor = Color.fromRGBO(243, 246, 243, 1);

  // Оставляем синие цвета без изменений
  static const Color blueColor = Color.fromRGBO(0, 90, 198, 1);
  static const Color blueUnselectedColor = Color.fromRGBO(177, 193, 254, 0.69);

  // Заменены зелёные оттенки на синие, хотя имена переменных остаются прежними
  static const Color greenUnselectedColor = Color.fromRGBO(215, 245, 255, 1);
  static const Color greenSecondColor = Color.fromRGBO(211, 237, 255, 1);

  static const Color greyPrymaryColor = Color.fromRGBO(68, 65, 68, 1);
  static const Color textFieldColor = Color.fromRGBO(243, 243, 243, 1);
  static const Color redColor = Color.fromRGBO(240, 8, 29, 1);
  static const Color redUnselectedColor = Color.fromRGBO(240, 235, 235, 1);

  // Заменены зелёные оттенки на синие
  static const Color greenColor = Color.fromRGBO(9, 169, 255, 1);
  static const Color boldGreenColor = Color.fromRGBO(26, 117, 255, 1);

  static const Color orangeColor = Color.fromRGBO(255, 207, 125, 1);
  static const Color orangeUnselectedColor = Color.fromRGBO(254, 255, 243, 1);
}
