// test/d_custom_button_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homehero/features/core/d_custom_button.dart'; // Убедитесь, что путь совпадает с расположением файла DCustomButton

void main() {
  testWidgets('DCustomButton отображает текст и реагирует на нажатие', (WidgetTester tester) async {
    bool wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DCustomButton(
            text: 'Press me',
            color: Colors.red,
            onTap: () {
              wasTapped = true;
            },
          ),
        ),
      ),
    );

    // Текст должен присутствовать
    expect(find.text('Press me'), findsOneWidget);

    // Нажимаем на кнопку
    await tester.tap(find.byType(DCustomButton));
    await tester.pumpAndSettle();

    // Коллбэк должен был выполниться
    expect(wasTapped, isTrue);
  });

  testWidgets('DCustomButton поддерживает градиент и цвет', (WidgetTester tester) async {
    final gradient = LinearGradient(
      colors: [Colors.blue, Colors.green],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DCustomButton(
            text: 'Gradient',
            gradient: gradient,
            onTap: () {},
          ),
        ),
      ),
    );

    // Текст должен присутствовать
    expect(find.text('Gradient'), findsOneWidget);

    // Ищем AnimatedContainer внутри DCustomButton и проверяем его decoration
    final animatedContainer = tester.widget<AnimatedContainer>(
      find.descendant(
        of: find.byType(DCustomButton),
        matching: find.byType(AnimatedContainer),
      ),
    );

    final decoration = animatedContainer.decoration as BoxDecoration;
    expect(decoration.gradient, equals(gradient));
  });
}
