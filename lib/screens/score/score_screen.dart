import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komodo_trivia/constants.dart';
import 'package:komodo_trivia/controllers/question_controller.dart';
import 'package:komodo_trivia/provider/dataProvider.dart';
import 'package:komodo_trivia/screens/welcome/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

class ScoreScreen extends StatefulWidget {
  ScoreScreen({Key? key}) : super(key: key);

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController(context));
    var data_provider = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              const Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: kSecondaryColor),
              ),
              const Spacer(),
              Text(
                "${data_provider.questions.score}/${_qnController.questions.questions.length}",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: kSecondaryColor),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: FloatingActionButton.small(
                  onPressed: () => {
                    _qnController.dispose(),
                    Get.delete<QuestionController>(),
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()))
                  },
                  child: const Icon(Icons.restore),
                  tooltip: "Return to Home",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
