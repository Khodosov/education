import 'package:get_it/get_it.dart';
import 'package:sirius23/application/logger.dart';

import 'api.dart';
import 'messenger.dart';

class Locator {
  const Locator._();

  static final GetIt _locator = GetIt.instance;

  static initApp(Api api) async {
    /// Register dependencies
    Logger.log('Dependencies initializing...');

    _locator.registerLazySingleton<Api>(
      () => api,
    );

    _locator.registerLazySingleton<Messenger>(
      () => Messenger(),
    );

    await api.init(messenger);

    Logger.log('Dependencies initialized!');
  }

  static void dispose() {
    _locator.reset(dispose: true);
    api.dispose();
  }

  static Api get api => _locator<Api>();

  static Messenger get messenger => _locator<Messenger>();
}
