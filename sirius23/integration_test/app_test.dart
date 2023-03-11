import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sirius23/application/logger.dart';
import 'package:sirius23/main.dart';
import 'test_main.dart' as test_app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => Logger.log('Next test is running...'));

  // Метод тулкита
  // await loadAppFonts();

  testWidgets('App launch test', (WidgetTester tester) async {
    test_app.main();
    await tester.pumpAndSettle();
    expect(find.text('Sign in'), findsWidgets);
  });

  testWidgets('Login and logout test', (WidgetTester tester) async {
    test_app.main();
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'a@mail.ru');
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).last, '123456');
    await tester.pumpAndSettle();

    // Расставлю задержки для крастоты
    await Future.delayed(const Duration(seconds: 2));

    await tester.tap(find.text('Sign in').last);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);

    // Logout
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await tester.tap(find.byIcon(Icons.logout_rounded));
    await tester.pumpAndSettle();
  });

  testWidgets('Send and display message', (WidgetTester tester) async {
    // Следите, чтобы во вех тестах мы запускали main!
    test_app.main();
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'a@mail.ru');
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).last, '123456');
    await tester.pumpAndSettle();

    // Расставлю задержки для крастоты
    await Future.delayed(const Duration(seconds: 2));

    await tester.tap(find.text('Sign in').last);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Hello auto test!');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Hello another auto test!');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));

    expect(find.text('Hello auto test!'), findsWidgets);
    expect(find.text('Hello another auto test!'), findsWidgets);

    // Logout
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.logout_rounded));
    await tester.pumpAndSettle();
  });

  testWidgets('Scroll', (WidgetTester tester) async {
    // Следите, чтобы во вех тестах мы запускали main!
    test_app.main();
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'a@mail.ru');
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).last, '123456');
    await tester.pumpAndSettle();

    // Расставлю задержки для крастоты
    await Future.delayed(const Duration(seconds: 2));

    await tester.tap(find.text('Sign in').last);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Another message');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('TextForm')), 'Goodbye auto test!');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    expect(find.text('Another message').first, findsWidgets);

    await tester.dragUntilVisible(
      find.text('Goodbye auto test!'),
      find.byType(ListView),
      const Offset(0, -100),
    );
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    // Logout
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.logout_rounded));
    await tester.pumpAndSettle();
  });
}
