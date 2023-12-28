// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:komodo_trivia/main.dart';
import 'package:komodo_trivia/provider/dataProvider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(child: MyApp(), providers: [
      ChangeNotifierProvider(
        create: (context) => DataProvider(),
      ),
    ]));
  });
}
