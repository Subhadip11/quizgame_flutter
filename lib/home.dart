import 'package:flutter/material.dart';
import 'package:quizgame/answer.dart';
import 'package:quizgame/result.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [
  ];
  int _questionIndex = 0;
  int totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionanswerd(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if the answer is correct
      if(answerScore) {
        totalScore++;
        correctAnswerSelected = true;
      }
      // adding scoreTracker to the top
      _scoreTracker.add(
        answerScore ? Icon(Icons.check_circle,color: Colors.green,) : Icon(Icons.clear,color: Colors.red,)
      );
      // when the quiz ends
      if(_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // end of quiz
    if (_questionIndex>= _questions.length) {
      result(marks: totalScore);
      _resetQuiz();
    }
  }
  void _resetQuiz() {
    setState(() {
      _questionIndex =0;
      totalScore =0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Game',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if(_scoreTracker.length == 0)
                  SizedBox(
                    height: 30.0,
                  ),
                if(_scoreTracker.length > 0)
                  ..._scoreTracker
              ],
            ),
            Container(
              width: double.infinity,
              height: 130.0,
              margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0,),
            ...(_questions[_questionIndex]['answers'] as List<Map<String,Object>>).map((answer) => Answer(
              answerText: answer['answerText'].toString(),
              answerColor: answerWasSelected ? answer['score'] as bool ? Colors.green : Colors.red : Colors.white,
              answerTap: () {
                if(answerWasSelected) {
                  return;
                }
                _questionanswerd(answer['score'] as bool);
              } ,
            ),
            ),
            SizedBox(height: 30.0,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.minPositive, 50.0),
              ),
                onPressed: () {
                if(!answerWasSelected){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Select your answer first!!"),)
                  );
                  return;
                }
                _nextQuestion();
                },
                child: Text(
                    endOfQuiz == true? "Restart Quiz" : "Next Question",
                ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '${totalScore.toString()}/${_questions.length}',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if(answerWasSelected && !endOfQuiz)
              Container(
                height: 100.0,
                width: double.infinity,
                color: correctAnswerSelected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    correctAnswerSelected ? "Well Done :)": "Wrong :/",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if(endOfQuiz)
              Container(
                height: 100.0,

                width: double.infinity,
                color: Colors.black26,
                child: Center(
                  child: Text(
                    totalScore > 4 ? "Congrats, You scored awesome" : "You need to work more",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: totalScore > 4 ? Colors.green : Colors.red,
                    ),
                  )
                ),
              ),
          ],
        ),
      ),
    );
  }
}

final _questions = const [
  {
    'question': 'What is the Capital of India?',
    'answers': [
      {'answerText': 'New Delhi', 'score': true},
      {'answerText': 'Kolkata', 'score': false},
      {'answerText': 'Mumbai', 'score': false},
    ],
  },
  {
    'question':
    'Who is Naruto"s father?',
    'answers': [
      {'answerText': 'Iruka', 'score': false},
      {'answerText': 'Kakashi', 'score': false},
      {'answerText': 'Minato', 'score': true},
    ],
  },
  {
    'question': 'Which Missile System India recently purchsed?',
    'answers': [
      {'answerText': 'IronDome', 'score': false},
      {'answerText': 'S-500', 'score': false},
      {'answerText': 'S-400', 'score': true},
    ],
  },
  {
    'question': 'Who is President of Japan?',
    'answers': [
      {'answerText': 'Shinzo Abe', 'score': false},
      {'answerText': 'Fumio Kishida', 'score': true},
      {'answerText': 'Matsuhida Suga', 'score': false},
    ],
  },
  {
    'question':
    'Real name of Eddie Brock is?',
    'answers': [
      {'answerText': 'Tom Hardy', 'score': true},
      {'answerText': 'Tom Holland', 'score': false},
      {'answerText': 'Tom Hanks', 'score': false},
    ],
  },
  {
    'question': 'What is Russia Famous for?',
    'answers': [
      {'answerText': 'Ak-47', 'score': true},
      {'answerText': 'Vodka', 'score': false},
      {'answerText': 'Spies', 'score': false},
    ],
  },
  {
    'question': 'From which country do French fries originate?',
    'answers': [
      {'answerText': 'Belgium', 'score': true},
      {'answerText': 'France (duh)', 'score': false},
      {'answerText': 'Switzerland', 'score': false},
    ],
  },
  {
    'question': 'Which sea creature has three hearts?',
    'answers': [
      {'answerText': 'Great White Sharks', 'score': false},
      {'answerText': 'Killer Whales', 'score': false},
      {'answerText': 'The Octopus', 'score': true},
    ],
  },
  {
    'question': 'Which European country eats the most chocolate per capita?',
    'answers': [
      {'answerText': 'Belgium', 'score': false},
      {'answerText': 'The Netherlands', 'score': false},
      {'answerText': 'Switzerland', 'score': true},
    ],
  },
];
