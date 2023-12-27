import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:komodo_trivia/models/Questions.dart';
import 'package:komodo_trivia/provider/dataProvider.dart';
import 'package:komodo_trivia/screens/score/score_screen.dart';
import 'package:provider/provider.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  late PageController _pageController;
  PageController get pageController => this._pageController;

  Questions _questions = Questions(questions: [], score: 0, amount: "1");
  Questions get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late String _correctAns;
  String get correctAns => this._correctAns;

  late String _selectedAns;
  String get selectedAns => this._selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => this._numOfCorrectAns;

  late BuildContext _context;

  QuestionController(BuildContext context) {
    _context = context;
  }
  set numOfCorrectAns(int value) {
    _numOfCorrectAns = value;
    update();
  }

  void resetController() {
    _selectedAns = '';
    _numOfCorrectAns = 0;
    _questionNumber.value = 1;
    update();
  }

  @override
  void onInit() {
    var dataProvider = Provider.of<DataProvider>(_context, listen: false);
    _questions = dataProvider.questions;
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, String selected) {
    _isAnswered = true;
    _correctAns = question.correct_answer;
    _selectedAns = selected;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    _animationController.stop();
    update();

    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      resetController();
      Navigator.pushReplacement(
          _context, MaterialPageRoute(builder: (context) => ScoreScreen()));
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
