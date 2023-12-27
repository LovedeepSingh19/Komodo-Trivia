import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komodo_trivia/controllers/question_controller.dart';
import 'package:komodo_trivia/models/Questions.dart';
import 'package:komodo_trivia/provider/dataProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController(context));
    var data_provider = Provider.of<DataProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: kBlackColor),
          ),
          SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            question.options.length,
            (index) => Option(
                index: index,
                options: question.options,
                text: question.options[index],
                press: () => {
                      if (question.options[index] == question.correct_answer)
                        {
                          print(data_provider.questions.score + 1),
                          data_provider
                              .updateScore(data_provider.questions.score + 1),
                          _controller.numOfCorrectAns += 1
                        },
                      _controller.checkAns(question, question.options[index]),
                    }),
          ),
        ],
      ),
    );
  }
}
