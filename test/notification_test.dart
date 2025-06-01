// test/notification_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:homehero/data/models/app_notifiction_model.dart';

void main() {
  group('NotificationModel.fromJson', () {
    test('правильно парсит все поля из JSON', () {
      // Пример JSON-данных для одиночного уведомления
      final Map<String, dynamic> json = {
        'id': 42,
        'description': 'Тестовое описание',
        'markRead': true,
        'notificationType': 'INFO',
        'userId': 7,
      };

      final model = NotificationModel.fromJson(json);

      expect(model.id, equals(42));
      expect(model.description, equals('Тестовое описание'));
      expect(model.markRead, isTrue);
      expect(model.notificationType, equals('INFO'));
      expect(model.userId, equals(7));
    });

    test('бросает ошибку при отсутствии обязательного поля', () {
      // Если в JSON нет какого-либо поля, приведённый код упадёт
      // с ошибкой типа TypeError. Проверим это:
      final Map<String, dynamic> incompleteJson = {
        'id': 1,
        'description': 'Нет поля markRead',
        // 'markRead': false,
        'notificationType': 'WARN',
        'userId': 2,
      };

      expect(
        () => NotificationModel.fromJson(incompleteJson),
        throwsA(isA<TypeError>()),
      );
    });
  });

  group('NotificationsPageModel.fromJson', () {
    test('правильно парсит страницу уведомлений с несколькими элементами', () {
      // Пример JSON для страницы уведомлений
      final Map<String, dynamic> pageJson = {
        'content': [
          {
            'id': 1,
            'description': 'Первое уведомление',
            'markRead': false,
            'notificationType': 'ALERT',
            'userId': 10,
          },
          {
            'id': 2,
            'description': 'Второе уведомление',
            'markRead': true,
            'notificationType': 'INFO',
            'userId': 10,
          },
        ],
        'totalPages': 3,
        'totalElements': 6,
        'number': 0,
        'size': 2,
      };

      final pageModel = NotificationsPageModel.fromJson(pageJson);

      // Проверяем количество элементов в списке
      expect(pageModel.content, hasLength(2));

      // Первый элемент
      final first = pageModel.content[0];
      expect(first.id, equals(1));
      expect(first.description, equals('Первое уведомление'));
      expect(first.markRead, isFalse);
      expect(first.notificationType, equals('ALERT'));
      expect(first.userId, equals(10));

      // Второй элемент
      final second = pageModel.content[1];
      expect(second.id, equals(2));
      expect(second.description, equals('Второе уведомление'));
      expect(second.markRead, isTrue);
      expect(second.notificationType, equals('INFO'));
      expect(second.userId, equals(10));

      // Проверяем поля страницы
      expect(pageModel.totalPages, equals(3));
      expect(pageModel.totalElements, equals(6));
      expect(pageModel.number, equals(0));
      expect(pageModel.size, equals(2));
    });

    test('бросает ошибку, если content не список', () {
      final Map<String, dynamic> badJson = {
        'content': 'не список',
        'totalPages': 1,
        'totalElements': 1,
        'number': 0,
        'size': 1,
      };

      expect(
        () => NotificationsPageModel.fromJson(badJson),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
