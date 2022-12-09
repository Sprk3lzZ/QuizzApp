import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'package:quizz_app/models/question.dart';





class PageQuizz extends StatefulWidget {

  @override
  _PageQuizzState createState() => new _PageQuizzState();


}


class _PageQuizzState extends State<PageQuizz> {



  Question question;

  List<Question> listeQuestion = [
    new Question('La devise de la Belgique est l\'union fait la force', true, '', 'belgique.JPG'),
    new Question('Le soleil tourne autour de la lune.', false, 'C\'est la lune qui tourne autour du Soeil', 'lune.jpg'),
    new Question('La Russie est plus grande en superficie que Pluton', true, 'C\'est une aptitude à voir dans le noir', 'russie.jpg'),
    new Question('Nyctalope est une race naine d\'antilope', false, 'C\'est juste la capacité de voir dans le noir', 'nyctalope.jpg'),
    new Question('Mon mac est moins puissant que celui de PAPA', false, 'Non le miens est plus puissant ^', 'commodore.jpg'),
    new Question('Le nom du drapeau des pirates est le BlackSkull', false, 'Il est appelé le JolyRoger', 'pirate.png'),
    new Question('Haddock est le nom du vhien de Tintin', false, 'Son nom c\'est Milou', 'tintin.jpg'),
    new Question('La barbe des pharaons était fausse', true, '', 'pharaon.jpg'),
    new Question('Charcoal veut dire charbon de bois en anglais', true, '', 'buche.jpg'),
    new Question('Le module lunaire Eagle possèderait 4Ko de RAM ', true, '', 'eagle.jpg'),
  ];

  Map locales = {
    'en_US': {'questionnumber': 'Question number', 'score': 'Score', 'true':'True', 'false': 'False', 'yourscore': 'Your Score', 'finish': 'Quizz finished','next': 'Next Question','won': 'Good Awnser', 'loose': 'Bad Awnser ...'},
    'fr_FR': {'questionnumber': 'Question numéro', 'score': 'Score', 'true':'Vrai', 'false': 'Faux','yourscore': 'Votre Score', 'finish': 'Quizz Terminé','next': 'Question Suivante','won': 'Bonne réponse !', 'loose': 'Mauvaise Réponse...'},
    'es_ES': {'questionnumber': 'Número de pregunta', 'score': 'Puntuación', 'true':'Real', 'false': 'Falso','yourscore': 'Tu puntuación', 'finish': 'Prueba completada','next': 'Next Question','next': 'Próxima pregunta','won': 'Buena respuesta', 'loose': 'Mala respuesta...'},
    'ar_DZ': {'questionnumber': 'رقم السؤال', 'score': 'أحرز هدفا', 'true':'صحيح', 'false': 'خاطئة','yourscore': 'درجاتك', 'finish': 'اكتمل الاختبار','next': 'السؤال التالي','won': 'إجابة جيدة', 'loose': 'اجابة خاطئة...'},
    'pt_BR': {'questionnumber': 'Número da pergunta', 'score': 'Ponto', 'true':'Verdadeiro', 'false': 'Falso','yourscore': 'Sua pontuação', 'finish': 'Questionário concluído','netxt': 'Próxima questão','won': 'Resposta correta', 'loose': 'Resposta errada...'},
  };

  String i18n (String slug) {
    String locale = 'fr_FR';
    String trad = locales[locale][slug];

    return trad;
  }
  int index = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    question = listeQuestion[index];
  }

  @override
  Widget build(BuildContext context) {
    double taille = MediaQuery.of(context).size.width * 0.75;
    return new Scaffold(
      appBar: new AppBar(
        title: new CustomText('ChiktaQuizz'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new CustomText("${i18n('questionnumber')} ${index+1}", color: Colors.grey[900], factor: 1.5),
            new CustomText("${i18n('score')} : $score / $index", color: Colors.grey[900], factor: 1.25),
            new Card(
              elevation: 20.0,
              child: new Container(
                height: taille,
                width: taille,
                child: new Image.asset(
                  "quizz assets/${question.imagePath}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new CustomText(question.question, color: Colors.grey[900], factor: 1.3),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                boutonBool(true),
                boutonBool(false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  RaisedButton boutonBool ( bool b) {
    return new RaisedButton(
      elevation: 20.0,
      onPressed: (() => dialogue(b)),
      color: Colors.blue,
      child: new CustomText((b) ? "${i18n('true')}" : "${i18n('false')}", factor: 1.25,),
    );
  }

  Future<Null> dialogue(bool b) async {
    bool bonneReponse = (b == question.reponse);
    String vrai = "quizz assets/vrai.jpg";
    String faux = "quizz assets/faux.jpg";
    if (bonneReponse) {
      score++;
    }

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: new CustomText((bonneReponse) ? "${i18n('won')}" : "${i18n('loose')}", factor: 1.4, color: (bonneReponse) ? Colors.green : Colors.red),
            contentPadding: EdgeInsets.all(20.0),
            children: <Widget>[
              new Image.asset((bonneReponse) ? vrai: faux, fit: BoxFit.cover,),
              new Container(height: 25.0,),
              new CustomText(question.explication, factor: 1.25, color: Colors.grey[900],),
              new Container(height: 25.0),
              new RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  questionSuivante();
                },
                child: new CustomText('${i18n('next')}', factor: 1.25,),
                color: Colors.blue,
              ),
            ],
          );
        }
    );
  }

  Future<Null> alerte() async {
    return showDialog(context: context,
    barrierDismissible: false,
    builder: (BuildContext buildcContext) {
      return new AlertDialog(
        title: new CustomText('${i18n('finish')}', color: Colors.blue, factor: 1.25),
        contentPadding: EdgeInsets.all(10.0),
        content: new CustomText('${i18n('yourscore')} : $score / $index', color: Colors.grey[900],),
        actions: <Widget>[
          new Image.asset('quizz assets/won.jpg'),
          new FlatButton(
              onPressed: () {
                Navigator.pop(buildcContext);
                Navigator.pop(context);
              },
              child: new CustomText('OK', factor: 1.25, color: Colors.blue,),
          ),
        ],
      );
    }
    );
  }

  void questionSuivante() {
    if (index < listeQuestion.length - 1 ) {
      index++;
      setState(() {
        question = listeQuestion[index];
      });
    }else {
      alerte();
    }
  }

}