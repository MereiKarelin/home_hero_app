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

      await TestUtils.clickKey(
        driver,
        'сheckbox1',
      );

      await TestUtils.clickKey(
        driver,
        'сheckbox2',
      );

      await TestUtils.clickName(
        driver,
        'Авторизоваться',
      );
    });

    test('Login', () async {
      await Future.delayed(const Duration(seconds: 4), () {});

      await TestUtils.clickName(
        driver,
        'Выберите регион*',
      );

      await TestUtils.clickName(
        driver,
        'Казахстан',
      );

      await TestUtils.clickKey(
        driver,
        'сheckbox2',
      );

      await TestUtils.clickName(
        driver,
        'Далее',
      );
    });

    test('Login', () async {
      await Future.delayed(const Duration(seconds: 4), () {});

      await TestUtils.clickName(
        driver,
        'Worker',
      );

      await TestUtils.clickName(
        driver,
        'Далее',
      );

      await TestUtils.enterText(driver, TType.byKey, 'number', '0000000000');

      await TestUtils.clickName(
        driver,
        'Далее',
      );

      await TestUtils.clickName(
        driver,
        'Получить код',
      );

      await TestUtils.enterText(driver, TType.byKey, 'code', '112233');
    });
  });
}
