import 'package:bilgi_testi/constants.dart';
import 'package:bilgi_testi/test_information.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';


void main() => runApp(QuestionAnswer());

class QuestionAnswer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[700],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuestionPage(),
          ),
        ),
      ),
    );
  }
}

class QuestionPage extends StatefulWidget {

late ConfettiController _confettiController;



  @override
  _QuestionPageState createState() => _QuestionPageState();
}



class _QuestionPageState extends State<QuestionPage> {
  List<Widget> chosen = [];
  TestVeri test_1 = TestVeri();
  final AudioPlayer player = AudioPlayer();

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 20));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void playSound(String filePath) {
    player.play(AssetSource(filePath));
  }

  bool checkAnswer(bool selectedButton) {
    return test_1.getAnswer() == selectedButton;
  }

  void buttonFunction(bool selectedButton) {
    if (test_1.isTestOver()) {
      // Konfeti animasyonunu başlat
      _confettiController.play();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          
          return AlertDialog(
            title: Text("Bravo Testi Bitirdiniz"),
            actions: [
              TextButton(
                child: Text("Başa Dön"),
                onPressed: () {
                  setState(() {
                    _confettiController.stop();
                    test_1.resetTest();
                    chosen = [];
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      
    } else {
      setState(() {
        checkAnswer(selectedButton)
            ? chosen.add(kTrueIcon)
            : chosen.add(kFalseIcon);
        checkAnswer(selectedButton)
            ? playSound('sounds/true.wav')
            : playSound('sounds/false.mp3');
        test_1.nextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    test_1.getQuestion(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Wrap(runSpacing: 5, spacing: 5, children: chosen),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            padding: EdgeInsets.all(12),
                          ),
                          child: Icon(
                            Icons.thumb_down,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            buttonFunction(false);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green[400],
                            padding: EdgeInsets.all(12),
                          ),
                          child: Icon(
                            Icons.thumb_up,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            buttonFunction(true);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
            colors: const [Colors.red, Colors.green, Colors.blue, Colors.yellow],
          ),
        ),
      ],
    );
  }
}

