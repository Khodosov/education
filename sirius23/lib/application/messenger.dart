import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sirius23/application/logger.dart';

import '../models/message.dart';

class Messenger {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  Messenger(
    this.firestore,
    this.auth,
  );

  late final StreamSubscription _messageSubscription;

  final StreamController<List<Message>> _messages = StreamController.broadcast();

  void init() {
    _messageSubscription = firestore
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      final messages = <Message>[];
      for (final document in snapshot.docs) {
        messages.add(
          Message(
            author: document.data()['author'] as String,
            message: document.data()['message'] as String,
          ),
        );
      }
      _messages.add(messages);
    });
  }

  void dispose() {
    _messageSubscription.cancel();
    _messages.close();
  }

  void post(String message) {
    firestore.collection('messages').add(<String, dynamic>{
      'author': auth.currentUser?.email ?? 'unknown',
      'message': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Stream<List<Message>> get messages => _messages.stream;
}
