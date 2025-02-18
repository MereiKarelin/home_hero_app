import 'dart:async';

import 'package:homehero/utils/injectable/configurator.config.dart';
import 'package:homehero/utils/shared_db.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;
SharedDb sharedDb = SharedDb();

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.init();
  sharedDb = getIt.get<SharedDb>();
  await sharedDb.init();
}
