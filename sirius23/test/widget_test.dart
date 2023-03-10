import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sirius23/application/api.dart';
import 'package:sirius23/application/di.dart';

import 'package:sirius23/presentation/messages_page.dart';

import 'test_doubles/api_test.mocks.dart';
import 'test_doubles/user_mock.dart';

void main() {
  late Api api;
  late User user;
  const testName = 'TEST VALUE';

  ///
  /// Arrange
  ///
  setUp(() async {
    api = MockApi();
    user = UserMock(testName);
    when(api.currentUserStream).thenAnswer((_) => const Stream.empty());
    when(api.messages).thenAnswer((_) => const Stream.empty());
    when(api.currentUser).thenAnswer((_) => user);
    await Locator.initApp(api);
  });

  tearDown(() {
    Locator.dispose();
  });

  // Аналогично можно было вызвать setUpAll, который вызывается единожды и
  // готовит окружение для всех тестов


  testWidgets('Navigate to profile page', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MessagesPage(),
        ),
      ),
    );

    ///
    /// Act
    ///
    await tester.tap(find.byIcon(Icons.person));
    //
    // pump нам не хватит ведь одна итерация UI не переведет на новый экран
    // await tester.pump();
    await tester.pumpAndSettle();

    ///
    /// Assert
    ///
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('Test fields display', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MessagesPage(),
        ),
      ),
    );

    ///
    /// Act
    ///
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    ///
    /// Assert
    ///
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.text('User name $testName'), findsOneWidget);
    expect(find.text(user.email!), findsOneWidget);
  });
}
