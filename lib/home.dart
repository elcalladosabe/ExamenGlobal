import 'package:examglob/quiz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:examglob/scoreStorage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScoreStorage score = ScoreStorage();
  @override
  void initState() {
    super.initState();



    shouldTakeQuiz();
    score.availability().then((bool val) {
      setState(() {
        _scoreInFile = val;
      });
    });
    score.readScore().then((int value) {
      setState(() {
        _score = value;
      });
    });
  }

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _ageController = TextEditingController();
  int _score = 0;
  bool _scoreInFile = false;
  bool _takeQuiz = false;

  shouldTakeQuiz() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool present = prefs.containsKey('fname');
    this._takeQuiz = present;
  }

  final _formKey = GlobalKey<FormState>();


  _navigateAndDisplayScore(BuildContext context) async {
    int returnedScore = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Quiz(),
        ));
    setState(() {
      if (returnedScore != null) {
        _score = returnedScore;
        score.writeScore(_score);
        this._scoreInFile = true;
      } else {
        _score = 0;
        score.writeScore(_score);
        this._scoreInFile = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [

              TextSpan(
                  text: " QUESTIONARIO!",
                  style:
                  TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF607D8B),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 15.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [






                    SizedBox(
                      height: 35.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Builder(builder: (BuildContext context) {
                          return RaisedButton(
                            onPressed: () {

                              _navigateAndDisplayScore(context);

                            },
                            textColor: Colors.white,
                            color: Color(0xFF607D8B),
                            child: Text(
                              "COMENZAR QUIZ",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            padding: EdgeInsets.all(50.0),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              _scoreInFile
                  ? Text(
                'PUNTAJE: $_score',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
