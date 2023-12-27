import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komodo_trivia/controllers/question_controller.dart';
import 'package:komodo_trivia/screens/welcome/welcome_screen.dart';
import 'components/body.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController(context));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
        ),
        elevation: 0,
        actions: [
          FloatingActionButton.small(
              onPressed: _controller.nextQuestion,
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
      body: Body(),
    );
  }
}
