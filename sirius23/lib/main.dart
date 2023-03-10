import 'package:flutter/material.dart';
import 'package:sirius23/application/api.dart';
import 'package:sirius23/presentation/login_page.dart';

import 'application/di.dart';

void main() async {
  await Locator.initApp(ApiImpl());
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    Locator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        brightness: Brightness.dark,
      ),
      home: const LoginPage(),
    );
  }
}
