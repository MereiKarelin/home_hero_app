import 'package:homehero/features/core/auth_utils.dart';

abstract class AuthRepo {
  Future<bool> checkNumber(String number);
  Future<void> confirmCode(String number, String code, AuthType authType);
  Future<void> login(
    String number,
  );
  Future<void> registration(
    String number,
    String name,
  );
}
