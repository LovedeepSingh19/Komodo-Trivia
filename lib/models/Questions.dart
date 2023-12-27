import 'dart:convert';

class Question {
  final String type, difficulty, category;
  final String question;
  final List<dynamic> options;
  final List<dynamic> incorrect_answers;
  final String correct_answer;

  Question(
      {required this.type,
      required this.question,
      required this.options,
      required this.correct_answer,
      required this.incorrect_answers,
      required this.category,
      required this.difficulty});

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "question": question,
      "incorrect_answers": incorrect_answers,
      "correct_answer": correct_answer,
      "difficulty": difficulty,
      "category": category,
      "options": List<String>.from(incorrect_answers) + [correct_answer],
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        type: map['type'] ?? '',
        question: map['question'] ?? '',
        options: List<dynamic>.from(
            map['incorrect_answers'] + [map['correct_answer']]),
        correct_answer: map['correct_answer'] ?? '',
        incorrect_answers: map['incorrect_answers'] ?? [''],
        category: map['category'] ?? '',
        difficulty: map['difficulty'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));
}

class Questions {
  String? name;
  String amount;
  String? difficulty;
  String? type;
  String? category;
  final List<Question> questions;

  int score;

  Questions({
    required this.questions,
    required this.score,
    required this.amount,
    this.name,
    this.difficulty,
    this.type,
    this.category,
  });

  void setQuestions(List<Question> newQuestions) {
    questions.clear();
    questions.addAll(newQuestions);
  }
}
