import 'package:flutter/material.dart';
import 'package:sirius23/presentation/login_page.dart';

import 'application/di.dart';

void main() async {
  await Locator.initApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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
