import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questions = [
    Question("Is pink the most common colour of toilet paper in France?", true),
    Question("the five rings on the Olympic flag are interlocking?", true),
    Question("Mount Kilimanjaro is the highest mountain in the world?", false),
    Question("a group of swans is known as a bevy?", true),
    Question("Sydney is the capital of Australia?", false),
    Question("a heptagon has eight sides?", false),
    Question("the star sign Capricorn is represented by a goat?", true),
    Question("fish cannot blink?", true),
    Question("seahorses have no teeth or stomach?", true),
    Question(
        "Nepal is the only country in the world which does not have a rectangular flag?",
        true),
    Question(
        "only one film has ever won all five of the main Oscars (film, director, actor, actress and screenplay)?",
        false),
    Question(
        "Switzerland shares land borders with four other countries?", false),
    Question(
        "Last Christmas by Wham! reached number one during the 1984 festive season?",
        false),
    Question(
        "the knight is the only piece in chess which can only move diagonally?",
        false)
  ];

  bool isFinished() {
    return (_questions.length == (_questionNumber + 1));
  }

  void reset() {
    _questionNumber = 0;
  }

  void nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() => _questions[_questionNumber].question;

  bool getQuestionAnswer() => _questions[_questionNumber].answer;
}
