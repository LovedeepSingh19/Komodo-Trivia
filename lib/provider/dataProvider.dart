import 'package:flutter/material.dart';
import 'package:komodo_trivia/models/Questions.dart';

class DataProvider extends ChangeNotifier {
  Questions _questions = Questions(questions: [
    Question(
      type: '',
      question: '',
      options: [],
      correct_answer: '',
      category: '',
      difficulty: '',
      incorrect_answers: [],
    )
  ], score: 0, amount: "1");

  Questions get questions => _questions;

  void setData(List<dynamic> questions) {
    List<Question> questionList = questions.map((question) {
      return Question.fromMap(question);
    }).toList();

    _questions = Questions(questions: [], score: 0, amount: "1");

    _questions = Questions(questions: questionList, score: 0, amount: "1");
    notifyListeners();
  }

  void updateScore(int newScore) {
    _questions.score = newScore;
    notifyListeners();
  }

  void setAPIData(String amount, String? name, String? type, String? difficulty,
      String? category) {
    _questions.amount = amount;
    _questions.name = name;
    _questions.type = type;
    _questions.difficulty = difficulty;
    _questions.category = category;

    notifyListeners();
  }
}
