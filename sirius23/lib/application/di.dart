import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sirius23/application/logger.dart';

import '../firebase_options.dart';

class Locator {
  const Locator._();

  static final GetIt _locator = GetIt.instance;

  static initApp() async {
    /// Initialize Firebase
    Logger.log('Firebase initializing...');
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Logger.log('Firebase initialized!');

    /// Register dependencies
    Logger.log('Dependencies initializing...');
    _locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    Logger.log('Dependencies initialized!');
  }

  static FirebaseAuth get firebaseAuth => _locator<FirebaseAuth>();
}
