import 'package:bilgi_testi/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(BilgiTesti());

class BilgiTesti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo[700],
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
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Widget> secimler = [];

  List<Soru> soruBankasi = [
    Soru(
      soruMetni: '1.Titanic gelmiş geçmiş en büyük gemidir',
      soruYaniti: false,
    ),
    Soru(
      soruMetni: '2.Dünyadaki tavuk sayısı insan sayısından fazladır',
      soruYaniti: true,
    ),
    Soru(soruMetni: '3.Kelebeklerin ömrü bir gündür', soruYaniti: false),
    Soru(soruMetni: '4.Dünya düzdür', soruYaniti: false),
    Soru(
      soruMetni: '5.Kaju fıstığı aslında bir meyvenin sapıdır',
      soruYaniti: true,
    ),
    Soru(
      soruMetni: '6.Fatih Sultan Mehmet hiç patates yememiştir',
      soruYaniti: true,
    ),
  ];

  Soru soru_1 = Soru(
    soruMetni: '1.Titanic gelmiş geçmiş en büyük gemidir',
    soruYaniti: false,
  );

  int soruIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                soruBankasi[soruIndex].soruMetni,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, color: Colors.white),
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
                        setState(() {
                          soruBankasi[soruIndex].soruYaniti == false
                              ? secimler.add(kDogruIconu)
                              : secimler.add(kYanlisIconu);
                          soruIndex++;
                        });
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
                        setState(() {
                          soruBankasi[soruIndex].soruYaniti == true
                              ? secimler.add(kDogruIconu)
                              : secimler.add(kYanlisIconu);
                          soruIndex++;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Soru {
  String soruMetni;
  bool soruYaniti;

  Soru({required this.soruMetni, required this.soruYaniti});
}
