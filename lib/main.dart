import 'package:flutter/material.dart';
import 'package:quiz_app/question.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Quiz(),
        ),
      ),
    );
  }
}

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<Icon> scoreKeeper = [];
  List<Question> questionsWithAnswers;
  int questionNumber;
  Question currentQuestion;
  bool quizRunning;

  _QuizState() {
    questionsWithAnswers = buildQuestions();
    currentQuestion = questionsWithAnswers.first;
    questionNumber = 0;
    quizRunning = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildQuestionSection(),
        trueOption(),
        falseOption(),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }

  Expanded buildQuestionSection() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            currentQuestion.question ??= "Quiz finished!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }

  Expanded falseOption() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Visibility(
          visible: quizRunning,
          child: FlatButton(
            color: Colors.red,
            child: Text(
              'False',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              setState(() {
                checkAnswer(false);
              });
            },
          ),
        ),
      ),
    );
  }

  Expanded trueOption() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Visibility(
          visible: quizRunning,
          child: FlatButton(
            color: Colors.green,
            child: Text(
              'True',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              setState(() {
                checkAnswer(true);
              });
            },
          ),
        ),
      ),
    );
  }

  Icon buildWrongAnswerIcon() {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Icon buildCorrectAnswerIcon() {
    return Icon(
      Icons.close,
      color: Colors.red,
    );
  }

  void checkAnswer(bool answer) {
    if (currentQuestion.answer == answer) {
      scoreKeeper.add(buildCorrectAnswerIcon());
    } else {
      scoreKeeper.add(buildWrongAnswerIcon());
    }

    selectNextQuestion();
  }

  void selectNextQuestion() {
    if (questionNumber < questionsWithAnswers.length - 1) {
      questionNumber++;
      currentQuestion = questionsWithAnswers[questionNumber];
    } else {
      currentQuestion.question = null;
      quizRunning = false;
    }
  }

  List<Question> buildQuestions() {
    List<Question> questions = [
      Question("Is pink the most common colour of toilet paper in France?",
          answer: true),
      Question("the five rings on the Olympic flag are interlocking?",
          answer: true),
      Question("Mount Kilimanjaro is the highest mountain in the world?",
          answer: false),
      Question("Strictly Come Dancing first aired in the UK in 2005?",
          answer: false),
      Question("a group of swans is known as a bevy?", answer: true),
      Question("Sydney is the capital of Australia?", answer: false),
    ];

    return questions;
  }
}
