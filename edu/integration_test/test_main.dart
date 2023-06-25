import 'package:flutter/cupertino.dart';
import 'package:sirius23/application/api.dart';
import 'package:sirius23/application/di.dart';
import 'package:sirius23/main.dart';

void main() async {
  await Locator.initApp(ApiImpl());
  runApp(const App());
}
