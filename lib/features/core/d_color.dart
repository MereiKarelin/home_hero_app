import 'package:flutter/material.dart';

class DColor {
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
