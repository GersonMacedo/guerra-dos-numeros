import 'dart:math';
import 'package:flutter/material.dart';

//TODO: Adicionar mais questões
//TODO: Pegar as questões de um arquivo separado
List<String> addQuestions = ["Mariazinha tinha | reais guardado, no seu aniversário ela ganhou mais | reais do seu pai. Quantos reais ela tem hoje?"];
List<String> subQuestions = [];
List<String> mulQuestions = [];
List<String> divQuestions = [];

Widget defaultPage(BuildContext context, Widget content, double padding){
  if(MediaQuery.of(context).size.width > MediaQuery.of(context).size.height){
    return Container(
      color: Colors.white,
      child: FittedBox(
        alignment: Alignment.topCenter,
        child: SizedBox(
            width: 960,
            height: 540,
            child: Container(
              padding: EdgeInsets.all(padding),
              decoration: const BoxDecoration(
                  color: Color(0xFF54436B),
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child: content,
            )
        ),
      ),
    );
  }

  return Container(
    color: Colors.white,
    child: FittedBox(
      alignment: Alignment.topCenter,
      child: SizedBox(
          width: 540,
          height: 960,
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: const BoxDecoration(
                color: Color(0xFF54436B),
                borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
            child: content,
          )
      ),
    ),
  );
}

Widget customIconButton(BuildContext context, Color buttonColor, Icon icon, String text, double textSize, Color textColor, double w, double h, Function() pressed){
  return SizedBox(
    width: w,
    height: h,
    child: ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
        child: Row(
          children: [
            icon,
            Text(text, style: TextStyle(fontSize: textSize, color: textColor))
          ],
        )
    ),
  );
}

Widget backButton(BuildContext context){
  return customIconButton(context, Colors.white, Icon(Icons.arrow_back, color: Colors.black), " Voltar", 20, Colors.black, 120, 50, (){Navigator.pop(context);});
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget  {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultPage(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Guerra dos números, Robôs e coisas matemáticas",
            style: TextStyle(fontSize: 40, color: Colors.white)
          ),
          Image.asset('assets/images/main.png'),
          MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? horizontal(context) : vertical(context)
        ],
      ),
      10.0
    );
  }

  Widget horizontal(BuildContext context){
    const double buttonsWidth = 220;
    const double buttonsHeiht = 50;
    const double fontSize = 22;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        customIconButton(context, Colors.green, Icon(Icons.play_circle), " Jogar", fontSize, Colors.white, buttonsWidth, buttonsHeiht,
                (){Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayPage()));}),
        customIconButton(context, Colors.green, Icon(Icons.emoji_events), " Configurações", fontSize, Colors.white, buttonsWidth, buttonsHeiht,
                (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));}),
        customIconButton(context, Colors.green, Icon(Icons.settings), " Conquistas", fontSize, Colors.white, buttonsWidth, buttonsHeiht,
                (){Navigator.push(context, MaterialPageRoute(builder: (context) => const AchievementsPage()));}),
        customIconButton(context, Colors.green, Icon(Icons.info_outline), " Sobre", fontSize, Colors.white, buttonsWidth, buttonsHeiht,
                (){Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));})
      ],
    );
  }

  Widget vertical(BuildContext context){
    const double buttonsWidth = 300;
    const double buttonsHeight = 70;
    const double fontSize = 30;

    return SizedBox(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          customIconButton(context, Colors.green, Icon(Icons.play_circle), " Jogar", fontSize, Colors.white, buttonsWidth, buttonsHeight,
                  (){Navigator.push(context, MaterialPageRoute(builder: (context) => const PlayPage()));}),
          customIconButton(context, Colors.green, Icon(Icons.emoji_events), " Configurações", fontSize, Colors.white, buttonsWidth, buttonsHeight,
                  (){Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));}),
          customIconButton(context, Colors.green, Icon(Icons.settings), " Conquistas", fontSize, Colors.white, buttonsWidth, buttonsHeight,
                  (){Navigator.push(context, MaterialPageRoute(builder: (context) => const AchievementsPage()));}),
          customIconButton(context, Colors.green, Icon(Icons.info_outline), " Sobre", fontSize, Colors.white, buttonsWidth, buttonsHeight,
                  (){Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));})
        ],
      )
    );
  }
}

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedOperation = "Soma";
    return defaultPage(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          backButton(context),
          const SizedBox(height: 15),
          //TODO: Deixar o usuario escolher a questão e os numeros, colocar uma opção aleatório também
          const Text("Operação: Soma", style: TextStyle(fontSize: 22, color: Colors.black)),
          const SizedBox(height: 15),
          const Text("Numero 1: 13", style: TextStyle(fontSize: 22, color: Colors.black)),
          const SizedBox(height: 15),
          const Text("Numero 2: 35", style: TextStyle(fontSize: 22, color: Colors.black)),
          const SizedBox(height: 15),
          customIconButton(context, Colors.green, Icon(Icons.play_circle), " Jogar", 22, Colors.white, 120, 50,
                  (){Navigator.push(context, MaterialPageRoute(builder: (context) => const GamePage(operation: "+", questionNumber: 0, number1: 13, number2: 35)));}),
        ],
      ),
      10.0
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultPage(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          backButton(context),
          const SizedBox(height: 15),
          const Text("TODO: tela de configurações")
        ],
      ),
      10.0
    );
  }
}

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultPage(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          backButton(context),
          const SizedBox(height: 15),
          const Text("TODO: tela de conquistas")
        ],
      ),
      10.0
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultPage(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          backButton(context),
          const SizedBox(height: 15),
          const Text("TODO: tela de sobre")
        ],
      ),
      10.0
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage(
      {super.key, required this.operation, required this.questionNumber, required this.number1, required this.number2});

  final String operation;
  final int questionNumber;
  final int number1;
  final int number2;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage>{
  int stage = 0;
  int total = 10;
  String question = "Qual operação você precisa fazer nessa questão?";
  List<String> questions = ["+", "-", "x", "/"];
  bool responded = false;
  int correct = 0;
  int timeLeft = 15;
  int totalTime = 15;
  int frame = 0;

  @override
  void _respond(bool correct){
    setState(() {
      responded = true;
      if (correct) {
        question = "Resposta correta!";
      } else if (timeLeft == 0){
        question = "Acabou o tempo!";
      }else{
        question = "Resposta errada!";
      }
    });

    Future.delayed(Duration(seconds: 5), (){
      setState((){
        responded = false;
        if(stage == 0){
          questions = [];
          question = "Mova os numeros para a posição correta";
          stage++;
          timeLeft = totalTime;
          _runTimer();
        }
      });
    });
  }

  void _runTimer(){
    if(responded){
      return;
    }

    if(timeLeft > 0){
      setState((){
        timeLeft--;
        if(timeLeft == 0){
          _respond(false);
          return;
        }
      });
    }

    Future.delayed(Duration(seconds: 1), (){
      _runTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    if(frame == 0){
      Future.delayed(Duration(seconds: 1), (){
        _runTimer();
      });
    }
    frame++;

    List<String> questionPieces = [];
    if(widget.operation == "+"){
      questionPieces = addQuestions[widget.questionNumber].split("|");
    }else{
      questionPieces = ["Operação '${widget.operation}' não definida ainda, numeros:", " e ", ""];
    }
    String question = "${questionPieces[0]}${widget.number1}${questionPieces[1]}${widget.number2}${questionPieces[2]}";

    return defaultPage(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFF828DF4),
            height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 200 : 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: 50,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red
                      ),
                      onPressed: (){Navigator.pop(context);},
                      child: const Icon(Icons.close),
                    )
                ),
                const SizedBox(height: 5),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Color(0xFF54436B),
                        borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: Text(question, style: const TextStyle(fontSize: 25, color: Colors.white))
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
            child: Row(
              children: [
                Container(
                  color: Colors.green,
                  width: (stage / total) * (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540),
                ),
                Container(
                  color: Colors.white,
                  width: ((total - stage) / total) * (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540),
                )
              ],
            ),
          ),
          buildQuestion(context),
          Container(
            padding: const EdgeInsets.all(15),
            child: buildBottom(context),
          )

        ]
      ),
      0.0
    );
  }

  Widget buildBottom(BuildContext context){
    if(MediaQuery.of(context).size.width > MediaQuery.of(context).size.height){
      return Row(
        children: [
          Column(
            children: [
              buildFight(context),
              buildTimer(context)
            ],
          ),
          SizedBox(width: 10),
          buildNumbers(context)
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildNumbers(context),
        SizedBox(height: 20),
        buildFight(context),
        SizedBox(height: 20),
        buildTimer(context)
      ],
    );
  }

  Widget buildQuestion(BuildContext context){
    double buttonsWidth = 150;
    double buttonsHeight = 50;
    List<Widget> buttons = [];
    for(int i = 0; i < questions.length; i++){
      if(i == correct){
        buttons.add(buildCorrectButton(context, questions[i], buttonsWidth, buttonsHeight));
      }else{
        buttons.add(buildWrongButton(context, questions[i], buttonsWidth, buttonsHeight));
      }

      if(i + 1 != questions.length){
        buttons.add(const SizedBox(width: 10));
      }
    }
    
    Widget buttonsWidget = Container();
    if(MediaQuery.of(context).size.width > MediaQuery.of(context).size.height && buttons.isNotEmpty){
      buttonsWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons
      );
    }else if(buttons.isNotEmpty){
      buttonsWidget = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttons.sublist(0, buttons.length ~/ 2)
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttons.sublist(buttons.length ~/ 2 + 1)
          )
        ],
      );
    }
    
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 120 : 250,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color(0xFF828DF4),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Text(question, style: TextStyle(fontSize: 20,color: Colors.black)),
          ),

          const SizedBox(height: 10),
          buttonsWidget
        ],
      )
    );
  }

  Widget buildNumbers(BuildContext context){
    return Container(
      alignment: Alignment.center,
      height: 180,
      width: 510,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Color(0xFF503967),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: const Text("Calculo", style: TextStyle(color: Colors.black, fontSize: 30)),
    );
  }

  Widget buildFight(BuildContext context){
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 130 : 160,
      width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 410 : 510,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Image.asset('assets/images/sampleFight.png'),
    );
  }

  Widget buildTimer(BuildContext context){
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 410,
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${timeLeft ~/ 60}:${(timeLeft % 60).toString().padLeft(2, "0")} ", style: TextStyle(fontSize: 25, color: timeLeft > 5 ? Colors.white : Colors.red)),
          Icon(Icons.punch_clock, color: timeLeft > 5 ? Colors.white : Colors.red)
        ],
      ),
    );
  }

  Widget buildCorrectButton(BuildContext context, String text, double width, double height){
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: responded ? Colors.green : const Color(0xFF828DF4)),
        onPressed: (){
          if(!responded){
            _respond(true);
          }
        },
        child: Text(text),
      ),
    );
  }

  Widget buildWrongButton(BuildContext context, String text, double width, double height){
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF828DF4)),
        onPressed: (){
          if(!responded) {
            _respond(false);
          }
        },
        child: Text(text),
      ),
    );
  }
}