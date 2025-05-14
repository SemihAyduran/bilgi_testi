import 'package:bilgi_testi/constants.dart';
import 'package:bilgi_testi/test_veri.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';


void main() => runApp(BilgiTesti());

class BilgiTesti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[700],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: SoruSayfasi(),
          ),
        ),
      ),
    );
  }
}

class SoruSayfasi extends StatefulWidget {

late ConfettiController _confettiController;



  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}



class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Widget> secimler = [];
  TestVeri test_1 = TestVeri();
  final AudioPlayer oynatici = AudioPlayer();

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void playSound(String filePath) {
    oynatici.play(AssetSource(filePath));
  }

  bool checkAnswer(bool secilenButon) {
    return test_1.getSoruYaniti() == secilenButon;
  }

  void butonFonksiyonu(bool secilenButon) {
    if (test_1.testBittiMi()) {
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
                    test_1.testiSifirla();
                    secimler = [];
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
        checkAnswer(secilenButon)
            ? secimler.add(kDogruIconu)
            : secimler.add(kYanlisIconu);
        checkAnswer(secilenButon)
            ? playSound('sounds/true.wav')
            : playSound('sounds/false.mp3');
        test_1.sonrakiSoru();
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
                    test_1.getSoruMetni(),
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
            Wrap(runSpacing: 5, spacing: 5, children: secimler),
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
                            butonFonksiyonu(false);
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
                            butonFonksiyonu(true);
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
        // Konfeti animasyonu widget'ı
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

