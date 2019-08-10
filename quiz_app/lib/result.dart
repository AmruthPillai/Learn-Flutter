import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final Function retakeQuiz;

  const Result(this.totalScore, this.retakeQuiz);

  String get resultText {
    String resultText;

    if (totalScore <= 8) {
      resultText = 'You are innocent!';
    } else if (totalScore <= 16) {
      resultText = 'You are pretty likeable!';
    } else if (totalScore <= 24) {
      resultText = 'You are ... strange?!';
    } else {
      resultText = 'You are so bad!';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            resultText,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          FlatButton(
            child: Text(
              'Retake Quiz',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            onPressed: retakeQuiz,
          )
        ],
      ),
    );
  }
}
