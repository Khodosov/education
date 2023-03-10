import '../models/message.dart';

class Messenger {
  Messenger();

  Message parseMessage(Map<String, dynamic> data) {
    return Message(
      author: data['author'] as String,
      message: data['message'] as String,
    );
  }
}
