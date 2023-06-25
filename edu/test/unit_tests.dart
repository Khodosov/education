import 'package:flutter_test/flutter_test.dart';
import 'package:sirius23/application/logger.dart';
import 'package:sirius23/application/messenger.dart';
import 'package:sirius23/models/message.dart';

import 'data/messages.dart';

void main() {
  ///
  /// Single unit tests
  ///
  test('Message parsing test: first quote', () {
    ///
    /// Arrange
    ///
    final messenger = Messenger();

    ///
    /// Act
    ///
    final parsedMessage = messenger.parseMessage(mockMessages[0]);
    Logger.log(parsedMessage.toString());

    ///
    /// Assert
    ///
    expect(
      parsedMessage,
      Message(
        author: 'Obi-Wan Kenobi',
        message: 'Hello there!',
      ),
    );

    ///
    /// Matcher
    ///
    expect(
      parsedMessage.message,
      equalsIgnoringCase('hello THERE!'),
    );
  });

  test('Message parsing test: second quote', () {
    final messenger = Messenger();

    final parsedMessage = messenger.parseMessage(mockMessages[1]);
    Logger.log(parsedMessage.toString());
    expect(
      parsedMessage,
      Message(
        author: 'General Grievos',
        message: 'General Kenobi!',
      ),
    );
  });

  ///
  /// Groups
  ///
  group('Full dialog', () {
    final messenger = Messenger();

    test('group 1', () {
      Logger.log(messenger.parseMessage(mockMessages[2]).toString());
      expect(
        messenger.parseMessage(mockMessages[2]),
        Message(
          author: 'Obi-Wan Kenobi',
          message:
              'You have allowed this dark lord to twist your mind, until now, until now you\'ve become the very thing you swore to destroy.',
        ),
      );
    });
    test('group 2', () {
      Logger.log(messenger.parseMessage(mockMessages[3]).toString());
      expect(
        messenger.parseMessage(mockMessages[3]),
        Message(
          author: 'Anakin Skywalker',
          message:
              'Don\'t lecture me, Obi-Wan! I see through the lies of the Jedi. I do not fear the dark side as you do. I have brought peace, freedom, justice, and security to my new Empire.',
        ),
      );
    });

    test('group 3', () {
      Logger.log(messenger.parseMessage(mockMessages[4]).toString());
      expect(
        messenger.parseMessage(mockMessages[4]),
        Message(
          author: 'Obi-Wan Kenobi',
          message: 'Your new Empire?',
        ),
      );
    });

    test('group 4', () {
      Logger.log(messenger.parseMessage(mockMessages[5]).toString());
      expect(
        messenger.parseMessage(mockMessages[5]),
        Message(
          author: 'Anakin Skywalker',
          message: 'Don\'t make me kill you.',
        ),
      );
    });

    test('group 5', () {
      Logger.log(messenger.parseMessage(mockMessages[6]).toString());
      expect(
        messenger.parseMessage(mockMessages[6]),
        Message(
          author: 'Obi-Wan Kenobi',
          message: 'Anakin, my allegiance is to the Republic, to democracy!',
        ),
      );
    });

    test('group 6', () {
      Logger.log(messenger.parseMessage(mockMessages[7]).toString());
      expect(
        messenger.parseMessage(mockMessages[7]),
        Message(
          author: 'Anakin Skywalker',
          message: 'If you\'re not with me, then you\'re my enemy.',
        ),
      );
    });

    test('group 7', () {
      Logger.log(messenger.parseMessage(mockMessages[8]).toString());
      expect(
        messenger.parseMessage(mockMessages[8]),
        Message(
          author: 'Obi-Wan Kenobi',
          message: 'Only a Sith deals in absolutes.',
        ),
      );
    });

    test('group 8', () {
      Logger.log(messenger.parseMessage(mockMessages[9]).toString());
      expect(
        messenger.parseMessage(mockMessages[9]),
        Message(
          author: 'Obi-Wan Kenobi',
          message: 'I will do what I must.',
        ),
      );
    });

    test('group 9', () {
      Logger.log(messenger.parseMessage(mockMessages[10]).toString());
      expect(
        messenger.parseMessage(mockMessages[10]),
        Message(
          author: 'Anakin Skywalker',
          message: 'You will try.',
        ),
      );
    });
  });
}
