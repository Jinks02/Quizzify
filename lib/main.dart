import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrainObj = QuizBrain(); // these are objects of different classes

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Quizzy'),
          backgroundColor: Colors.brown[700],
          titleTextStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        backgroundColor: Colors.brown[200],
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [
    // const Icon(
    //   Icons.check,
    //   color: Colors.green,
    // ),
    // const Icon(
    //   Icons.close,
    //   color: Colors.red,
    // )
  ]; // list or array of icons

  void checkAnsAndDisplayIcon(bool buttonBoolValue) {
    bool correctAnswer = quizBrainObj.getCorrectAnswer();
    setState(() {
      if (correctAnswer == buttonBoolValue) {
        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    });
  }

  void increaseQuestionNumber() {
    setState(() {
      quizBrainObj.nextQuestion();
    });
  }

  void resetAndAlert() {
    Alert(
            context: context,
            title: 'Questions Over!',
            desc: 'You have reached at the end of the Quiz.')
        .show();
    scoreKeeper.clear();
    quizBrainObj.resetQuesToZero();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrainObj.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {
                setState(() {
                  if (quizBrainObj.isFinished()) {
                    resetAndAlert();
                  } else {
                    checkAnsAndDisplayIcon(true);

                    increaseQuestionNumber();
                  }
                });

                // setState(() {
                //   scoreKeeper.add(
                //     const Icon(
                //       Icons.check,
                //       color: Colors.green,
                //     ),
                //   );
                // });
              },
              child: const Text(
                'true',
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                setState(() {
                  if (quizBrainObj.isFinished()) {
                    resetAndAlert();
                  } else {
                    checkAnsAndDisplayIcon(false);
                    increaseQuestionNumber();
                  }
                });
              },
              child: const Text(
                'false',
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
