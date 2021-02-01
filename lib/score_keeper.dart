import 'package:flutter/material.dart';

class ScoreKeeper {
  List<Icon> _icons = [];
  int _correctAnswers = 0;
  int _wrongAnswers = 0;

  double getFinalScore() {
    int answers = _correctAnswers + _wrongAnswers;
    double total = (_correctAnswers * 100) / answers;
    return total;
  }

  List<Icon> getScore() => _icons;

  void addAnswer(bool answer) {
    if (answer == true) {
      _icons.add(_buildCorrectAnswerIcon());
      _correctAnswers++;
    } else {
      _icons.add(_buildWrongAnswerIcon());
      _wrongAnswers++;
    }
  }

  int getCorrectAnswers() => _correctAnswers;

  void clearScore() {
    _icons.clear();
    _correctAnswers = 0;
    _wrongAnswers = 0;
  }

  Icon _buildCorrectAnswerIcon() {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Icon _buildWrongAnswerIcon() {
    return Icon(
      Icons.close,
      color: Colors.red,
    );
  }
}