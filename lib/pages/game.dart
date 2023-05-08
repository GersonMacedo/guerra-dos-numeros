import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/utils.dart';

//TODO: Adicionar mais questões
//TODO: Pegar as questões de um arquivo separado
List<String> addQuestions = ["Mariazinha tinha | reais guardado, no seu aniversário ela ganhou mais | reais do seu pai. Quantos reais ela tem hoje?\n!"];
List<String> subQuestions = [];
List<String> mulQuestions = [];
List<String> divQuestions = [];

class Game extends StatefulWidget {
  const Game({super.key, required this.operation, required this.questionNumber, required this.number1, required this.number2, required this.changePage, required this.vertical});
  final void Function(Widget?) changePage;
  final bool vertical;

  final String operation;
  final int questionNumber;
  final int number1;
  final int number2;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game>{
  int stage = 0;
  int total = 10;
  String question = "Qual operação você precisa fazer nessa questão?";
  List<String> questions = ["+", "-", "x", "/"];
  bool responded = false;
  int correct = 0;
  int timeLeft = 15;
  int totalTime = 15;
  int frame = 0;
  List<int> numbers1 = [];
  List<int> numbers2 = [];
  int maxSize = 0;
  String levelQuestion = "";
  int carry = 0;

  firstFrame(){
    print("Call!!!");
    Future.delayed(Duration(seconds: 1), (){
      _runTimer();
    });

    for(int i = widget.number1; i != 0; i ~/= 10){
      numbers1.add(i % 10);
    }

    for(int i = widget.number2; i != 0; i ~/= 10){
      numbers2.add(i % 10);
    }

    maxSize = max(numbers1.length, numbers2.length);

    List<String> questionPieces = [];
    if(widget.operation == "+"){
      questionPieces = addQuestions[widget.questionNumber].split("|");
      total = 2 * maxSize + 2;
    }else{
      questionPieces = ["Operação '${widget.operation}' não definida ainda, numeros:", " e ", ""];
    }
    levelQuestion = "${questionPieces[0]}${widget.number1}${questionPieces[1]}${widget.number2}${questionPieces[2]}";
  }

  @override
  void _respond(bool right){
    setState(() {
      responded = true;
      if (right) {
        question = "Resposta correta!";
      } else if (timeLeft == 0){
        question = "Acabou o tempo!";
      }else{
        question = "Resposta errada!";
      }
    });

    Future.delayed(Duration(seconds: 2), (){
      setState((){
        if(stage + 1 == total){
          question = "Parabéns! Você terminou o calculo";
          questions = [];
          stage++;
          return;
        }

        responded = false;
        if(stage % 2 == 0){
          if(stage == 0){
            questions = [widget.number1.toString(), widget.number2.toString()];
          }else{
            int a = numbers1[stage ~/ 2 - 1] + numbers2[stage ~/ 2 - 1] + carry;
            print(a);
            if(a > 10){
              carry = a ~/ 10;
              questions = [(carry).toString(), (a % 10).toString()];
            }else{
              carry = 0;
              questions = [(a % 10).toString()];
            }
          }
          question = "Mova os numeros para a posição correta";
        }else{
          question = "Quanto é ${numbers1[stage ~/ 2]} + ${numbers2[stage ~/ 2]}";
          if(carry != 0){
            question += " + ${carry}";
          }
          question += " ?";
          questions = [];
          for(int i = 0; i < 6; i++){
            questions.add((numbers1[stage ~/ 2] + numbers2[stage ~/ 2] + carry + i).toString());
          }
          correct = 0;
        }
        stage++;
        timeLeft = totalTime;
        _runTimer();
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
    if(frame++ == 0){
      firstFrame();
    }

    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: const Color(0xFF828DF4),
                height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 145 : 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 30,
                        height: 30,
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: (){widget.changePage(null);},
                          child: const Icon(Icons.close, size: 15),
                        )
                    ),
                    const SizedBox(height: 5),
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color(0xFF54436B),
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: Text(levelQuestion, style: const TextStyle(fontSize: 20, color: Colors.white))
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
              stage % 2 == 0 ? buildQuestion(context) : buildDrag(context),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: buildBottom(context),
              )

            ]
        )
    );
  }

  Widget buildBottom(BuildContext context){
    if(MediaQuery.of(context).size.width > MediaQuery.of(context).size.height){
      return Row(
        children: [
          Column(
            children: [
              buildFight(context),
              SizedBox(height: 15),
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
        SizedBox(height: 15),
        buildFight(context),
        SizedBox(height: 15),
        buildTimer(context)
      ],
    );
  }

  Widget buildQuestion(BuildContext context){
    double buttonsWidth = 140;
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
        height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 115 : 175,
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

  Widget buildDrag(BuildContext context){

    var dragWidget = Row(
      mainAxisAlignment: questions[0].length > 1 ? MainAxisAlignment.spaceEvenly: MainAxisAlignment.center,
      children: questions.map((e) => Text(e, style: TextStyle(fontSize: 20, color: Colors.yellow))).toList(),
    );

    return Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 115 : 175,
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
            dragWidget,
          ],
        )
    );
  }

  Widget buildNumbers(BuildContext context){
    List<Widget> smallNumbers = [], bigNumbers = [];
    for(int i = 0; i < 20; i++){
      smallNumbers.add(SizedBox(height: 10, width: 5, child: Container(color: Colors.yellow, child: Text('4', style: TextStyle(fontSize: 10, color: Colors.black),),)));
      smallNumbers.add(SizedBox(height: 10, width: 5, child: Container(color: Colors.red, child: Text('4', style: TextStyle(fontSize: 10, color: Colors.black),),)));
      bigNumbers.add(SizedBox(height: 20, width: 10, child: Container(color: Colors.green, child: Text('4', style: TextStyle(fontSize: 16, color: Colors.black),),)));
    }
    Widget grid = Column(
      children: [
        Row(children: smallNumbers),
        Row(children: bigNumbers),
        Row(children: bigNumbers),
        Divider(
            height: 5,
            color: Colors.black
        ),
        Row(children: smallNumbers),
        Row(children: bigNumbers),
        Row(children: bigNumbers),
        Row(children: bigNumbers),
        Row(children: bigNumbers),
        Divider(
            height: 5,
            color: Colors.black
        ),
        Row(children: bigNumbers),
      ],
    );
    return SizedBox(
        height: 260,
        width: 510,
        child: FittedBox(
          child: grid,
        )
    );
  }

  Widget buildFight(BuildContext context){
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 195 : 235,
      width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 410 : 510,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))
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
