import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  group('Main test', () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('Login', () async {
      await Future.delayed(const Duration(seconds: 4), () {});

      await TestUtils.clickName(
        driver,
        'Авторизоваться',
      );
    });

    test('Login', () async {
      await Future.delayed(const Duration(seconds: 4), () {});

      await TestUtils.clickName(
        driver,
        'Авторизоваться',
      );
    });
  });
}
