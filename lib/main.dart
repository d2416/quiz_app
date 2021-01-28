import 'package:flutter/material.dart';
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
  List<Icon> scoreKeeper = [];
  String currentQuestion;
  bool quizRunning;

  _QuizState() {
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
          // TODO allow space from the beginning
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

  Expanded falseOption() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
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
    );
  }

  Expanded trueOption() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
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

  void checkAnswer(bool userAnswer) {
    if (quizBrain.isFinished()) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Quiz finish!",
        desc: "No more questions. The quiz will reset.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();

      quizBrain.reset();
      scoreKeeper.clear();
    } else {
      if (quizBrain.getQuestionAnswer() == userAnswer) {
        scoreKeeper.add(buildCorrectAnswerIcon());
      } else {
        scoreKeeper.add(buildWrongAnswerIcon());
      }

      quizBrain.nextQuestion();
    }
  }
}
