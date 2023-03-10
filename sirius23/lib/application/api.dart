import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../firebase_options.dart';
import '../models/message.dart';
import 'logger.dart';
import 'messenger.dart';

///
/// All network related logic
///

abstract class Api {
  Future<void> init(Messenger messenger);

  void dispose();

  Stream<User?> get currentUserStream;

  User? get currentUser;

  Future<void> signOut();

  Stream<List<Message>> get messages;

  void post(String message);
}

class ApiImpl implements Api {
  late final FirebaseAuth firebaseAuth;

  late final FirebaseFirestore firestore;

  late final StreamSubscription _messageSubscription;

  final StreamController<List<Message>> _messages =
      StreamController.broadcast();

  late final Messenger _messenger;

  @override
  Future<void> init(Messenger messenger) async {
    _messenger = messenger;

    /// Initialize Firebase
    Logger.log('Firebase initializing...');
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // FlutterError.onError = (errorDetails) {
    //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    // };
    //
    // PlatformDispatcher.instance.onError = (error, stack) {
    //   FirebaseCrashlytics.instance.recordError(
    //     error,
    //     stack,
    //     fatal: true,
    //   );
    //   return true;
    // };

    firestore = FirebaseFirestore.instance;

    firebaseAuth = FirebaseAuth.instance;

    Logger.log('Firebase initialized!');

    _messageSubscription = firestore
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
      final messages = <Message>[];
      for (final document in snapshot.docs) {
        messages.add(_messenger.parseMessage(document.data()));
      }
      _messages.add(messages);
    });
  }

  @override
  void dispose() {
    _messageSubscription.cancel();
    _messages.close();
  }

  @override
  Stream<User?> get currentUserStream => firebaseAuth.authStateChanges();

  @override
  User? get currentUser => firebaseAuth.currentUser;

  @override
  Future<void> signOut() async => await firebaseAuth.signOut();

  @override
  Stream<List<Message>> get messages => _messages.stream;

  @override
  void post(String message) {
    firestore.collection('messages').add(<String, dynamic>{
      'author': firebaseAuth.currentUser?.email ?? 'unknown',
      'message': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
