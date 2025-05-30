import 'package:bilgi_testi/soru.dart';

class TestVeri {
  int _questionIndex = 0;

  List<Question> _questionBank = [
    Question(
      questionText: '1.Titanic gelmiş geçmiş en büyük gemidir',
      answer: false,
    ),
    Question(
      questionText: '2.Dünyadaki tavuk sayısı insan sayısından fazladır',
      answer: true,
    ),
    Question(questionText: '3.Kelebeklerin ömrü bir gündür', answer: false),
    Question(questionText: '4.Dünya düzdür', answer: false),
    Question(
      questionText: '5.Kaju fıstığı aslında bir meyvenin sapıdır',
      answer: true,
    ),
    Question(
      questionText: '6.Fatih Sultan Mehmet hiç patates yememiştir',
      answer: true,
    ),
  ];

  String getQuestion() {
    return _questionBank[_questionIndex].questionText;
  }

  bool getAnswer() {
    return _questionBank[_questionIndex].answer;
  }

  void nextQuestion() {
    if (_questionIndex + 1 < _questionBank.length) {
      _questionIndex++;
    }
  }

  bool isTestOver() {
    if (_questionIndex + 1 >= _questionBank.length) {
      return true;
    } else {return false;
    }
  }

void resetTest(){
  _questionIndex=0;
}

}
