import 'package:flutter/material.dart';

import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz(
      {Key key,
      @required this.questions,
      @required this.questionIndex,
      @required this.answerQuestion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Question(questions[questionIndex]['text']),
          ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) => Answer(
                    answer['text'],
                    () => answerQuestion(answer['score']),
                  ))
              .toList(),
        ],
      ),
    );
  }
}
