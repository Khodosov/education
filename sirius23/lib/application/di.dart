import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sirius23/application/logger.dart';

import '../firebase_options.dart';
import 'messenger.dart';

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

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      );
      return true;
    };

    Logger.log('Firebase initialized!');

    /// Register dependencies
    Logger.log('Dependencies initializing...');
    _locator.registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
    );
    _locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
    _locator.registerLazySingleton<Messenger>(
      () => Messenger(
        firebaseFirestore,
        firebaseAuth,
      ),
    );
    messenger.init();
    Logger.log('Dependencies initialized!');
  }

  static void dispose() {
    messenger.dispose();
  }

  static FirebaseAuth get firebaseAuth => _locator<FirebaseAuth>();

  static FirebaseFirestore get firebaseFirestore =>
      _locator<FirebaseFirestore>();

  static Messenger get messenger => _locator<Messenger>();
}
