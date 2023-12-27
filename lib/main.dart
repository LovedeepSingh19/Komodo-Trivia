import 'package:flutter/material.dart';
import 'package:komodo_trivia/provider/dataProvider.dart';
import 'package:komodo_trivia/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(child: MyApp(), providers: [
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
    ),
  ]));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}
