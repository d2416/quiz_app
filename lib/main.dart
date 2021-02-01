import 'package:flutter/material.dart';
import 'package:quiz_app/score_keeper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quiz_app/quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

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
  ScoreKeeper scoreKeeper = ScoreKeeper();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        questionSection(),
        optionButton(Colors.green, 'True', true),
        optionButton(Colors.red, 'False', false),
        scoreKeeperSection(),
      ],
    );
  }

  Container scoreKeeperSection() {
    return Container(
      height: 20.0,
      child: Row(
        children: scoreKeeper.getScore(),
      ),
    );
  }

  Expanded questionSection() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            quizBrain.getQuestionText(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }

  Expanded optionButton(Color color, String text, bool option) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FlatButton(
          color: color,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            setState(() {
              checkAnswer(option);
            });
          },
        ),
      ),
    );
  }

  void checkAnswer(bool userAnswer) {
    if (quizBrain.isFinished()) {
      resetQuiz();
    } else {
      if (quizBrain.getQuestionAnswer() == userAnswer) {
        scoreKeeper.addAnswer(true);
      } else {
        scoreKeeper.addAnswer(false);
      }

      quizBrain.nextQuestion();
    }
  }

  void resetQuiz() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Finished!",
      desc:
          "Thank you for participating in our quiz. You got ${scoreKeeper.getCorrectAnswers()} correct answers.",
      buttons: [
        DialogButton(
          child: Text(
            "Reset",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();

    quizBrain.reset();
    scoreKeeper.clearScore();
  }
}
