import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/utils.dart';

class Game extends StatefulWidget {
  const Game({super.key, required this.operation, required this.questionNumber, required this.question, required this.numbers, required this.changePage, required this.time});
  final void Function(Widget?) changePage;

  final int operation;
  final int questionNumber;
  final String question;
  final List<int> numbers;
  final int time;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game>{
  int stage = 0;
  int total = 10;
  String question = "Qual operação você precisa fazer?";
  List<String> questions = ["+", "-", "x", "/"];
  bool responded = false;
  int correct = 0;
  int timeLeft = 90;
  List<int> numbers1 = [];
  List<int> numbers2 = [];
  int maxSize = 0;
  String levelQuestion = "";
  int carry = 0;
  int result = 0;
  List<List<String>> grid = [];
  List<List<int>> acceptDrag = [];
  List<bool> dragElement = [true, true];
  String operation = "";
  int frame = 0;
  int fps = 10;
  int startFrame = 0;
  int wrongAnswers = 0;
  late Timer _timer;

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  _GameState(){
    _timer = Timer.periodic(
      Duration(microseconds: 1000000 ~/ fps),
      (timer) {
      setState(() {
          frame++;
          if(frame % fps == 0){
            if(timeLeft != 0 && !responded){
              timeLeft--;
              if(timeLeft == 0){
                _respond(false);
              }
            }
          }
        });
      }
    );
  }

  void clearDrag(){
    for(int i = 0; i < acceptDrag.length; i++){
      for(int j = 0; j < acceptDrag[i].length; j++){
        acceptDrag[i][j] = 0;
      }
    }
  }

  firstFrame(){
    operation = ["+", "-", "x", "/"][widget.operation];

    for(int i = max(widget.numbers[0], widget.numbers[1]); i != 0; i ~/= 10){
      numbers1.add(i % 10);
    }

    for(int i = min(widget.numbers[0], widget.numbers[1]); i != 0; i ~/= 10){
      numbers2.add(i % 10);
    }

    maxSize = max(numbers1.length, numbers2.length);
    List<String> gridLine = [];
    List<int> acceptList = [];
    for(int i = 0; i <= maxSize; i++){
      gridLine.add("");
      acceptList.add(0);
    }

    grid = [
      gridLine.sublist(0),
      gridLine.sublist(0),
      gridLine.sublist(0),
      gridLine.sublist(0)
    ];
    acceptDrag = [
      acceptList.sublist(0),
      acceptList.sublist(0),
      acceptList.sublist(0),
      acceptList.sublist(0)
    ];

    for(int i = 1; i <= maxSize; i++){
      acceptDrag[1][i] = 3;
      acceptDrag[2][i] = 3;
    }

    List<String> questionPieces = [];
    if(widget.question == ""){
      levelQuestion = "Quanto é ${widget.numbers[0]} ${operation} ${widget.numbers[1]} ?";
      question = "Mova os numeros para a posição correta";
      questions = widget.numbers.map((e) => e.toString()).toList();
      stage = 1;
      grid[2][0] = operation;
    }else{
      questionPieces = widget.question.split("|");
      levelQuestion = "${questionPieces[0]}${widget.numbers[0]}${questionPieces[1]}${widget.numbers[1]}${questionPieces[2]}";
    }

    if(operation == "+"){
      total = 2 * maxSize + 2;
    }
  }

  @override
  void _respond(bool right){
    setState(() {
      responded = true;
      if (right) {
        question = "Resposta correta!";
      } else if (timeLeft == 0){
        wrongAnswers++;
        question = "Acabou o tempo!";
        if(stage == 1){
          for(int i = 0; i < maxSize; i++){
            grid[1][maxSize - i] = numbers1[i].toString();
            grid[2][maxSize - i] = numbers2[i].toString();
          }
          clearDrag();
        }else if(stage % 2 == 1){
          if(carry != 0){
            grid[stage + 1 < total ? 0 : 3][maxSize - (stage ~/ 2)] = carry.toString();
          }
          grid[3][maxSize - (stage ~/ 2) + 1] = (result % 10).toString();
          clearDrag();
        }
        dragElement = [false, false];
      }else{
        wrongAnswers++;
        question = "Resposta errada!";
      }
    });

    Future.delayed(Duration(seconds: 2), (){
      setState((){
        responded = false;
        dragElement = [true, true];
        if(stage % 2 == 0){
          if(stage == 0){
            grid[2][0] = operation;
            questions = widget.numbers.map((e) => e.toString()).toList();
          }else{
            print(result);
            if(result >= 10){
              carry = result ~/ 10;
              questions = [(carry).toString(), (result % 10).toString()];
              acceptDrag[stage + 2 < total ? 0 : 3][maxSize - stage ~/ 2] = 1;
              acceptDrag[3][maxSize - stage ~/ 2 + 1] = 2;
            }else{
              carry = 0;
              questions = [(result % 10).toString()];
              acceptDrag[3][maxSize - stage ~/ 2 + 1] = 1;
            }
          }
          question = "Mova os numeros para a posição correta";
        }else{
          if(stage != 1){
            if(carry != 0){
              grid[stage + 1 < total ? 0 : 3][maxSize - (stage ~/ 2)] = carry.toString();
            }
            grid[3][maxSize - (stage ~/ 2) + 1] = (result % 10).toString();
          }

          if(stage + 1 == total){
            question = "Fim do calculo! ";
            questions = [];
            stage++;
            responded = true;
            if(wrongAnswers == 0){
              question += "Você terminou sem errar nada, parabéns!";
            }else{
              question += "você errou $wrongAnswers das $total questões (${(wrongAnswers * 1000 ~/ total) / 10}%)";
            }
            return;
          }

          question = "Quanto é ${numbers1[stage ~/ 2]} + ${numbers2[stage ~/ 2]}";
          if(carry != 0){
            question += " + ${carry}";
          }
          question += " ?";

          result = numbers1[stage ~/ 2] + numbers2[stage ~/ 2] + carry;
          Random random = Random();
          correct = random.nextInt(min(result + 1, 6));
          questions = [];
          for(int i = 0; i < 6; i++){
            questions.add((numbers1[stage ~/ 2] + numbers2[stage ~/ 2] + carry + i - correct).toString());
          }
        }
        stage++;
        timeLeft = widget.time;
        startFrame = frame;
      });
    });
  }

  void successDrag(int i, int j, int element){
    setState(() {
      print("Success ${i}, ${j}, ${element}");
      dragElement[element] = false;
      if(stage == 1){
        for(int k = 1; k <= maxSize; k++){
          acceptDrag[i][k] = 0;
          if(k - 1 < questions[element].length){
            grid[i][k] = questions[element][k - 1];
          }
        }
      }else{
        acceptDrag[i][j] = 0;
        grid[i][j] = questions[element];
      }
      if(dragElement[0] == false && (questions.length == 1 || dragElement[1] == false)){
        _respond(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool vertical = onVertical(context);
    if(frame == 0){
      firstFrame();
    }

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color(0xFF828DF4),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            width: double.infinity,
                            child: SizedBox(
                                width: 30,
                                height: 30,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.red,
                                  onPressed: (){widget.changePage(null);},
                                  child: const Icon(Icons.close, size: 15),
                                )
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
                        ]
                    )
                ),
                SizedBox(
                    height: 10,
                    child: Row(
                        children: [
                          Expanded(
                              flex: stage,
                              child: Container(color: Colors.green)
                          ),
                          Expanded(
                              flex: total - stage,
                              child: Container(color: Colors.white)
                          )
                        ]
                    )
                )
              ],
            ),
            stage % 2 == 0 ? buildQuestion(context) : buildDrag(context)
          ] + buildBottom(context)
      )
    );
  }

  List<Widget> buildBottom(BuildContext context){
    if(MediaQuery.of(context).size.width > MediaQuery.of(context).size.height){
      return [
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildFight(context),
                  buildTimer(context)
                ],
              ),
              const SizedBox(width: 10),
              buildNumbers(context),
              const SizedBox(width: 10)
            ]
          ),
        )
      ];
    }

    return [
      buildNumbers(context),
      const SizedBox(height: 10),
      buildFight(context),
      const SizedBox(height: 10),
      buildTimer(context)
    ];
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
              child: Text(question, style: const TextStyle(fontSize: 20,color: Colors.black)),
            ),

            const SizedBox(height: 10),
            buttonsWidget
          ],
        )
    );
  }

  Widget buildDrag(BuildContext context){
    List<Widget> row = [];

    for(int i = 0; i < questions.length; i++){
      Widget yellowText = Text(" ${questions[i]} ", style: const TextStyle(fontSize: 30, color: Colors.yellow));
      Widget hidedText = Text(" ${questions[i]} ", style: const TextStyle(fontSize: 30, color: Color(0xFF54436B)));
      if(!dragElement[i]){
        row.add(hidedText);
        continue;
      }

      row.add(
        Draggable<int>(
          data: i,
          feedback: yellowText,
          childWhenDragging: hidedText,
          child: yellowText
        )
      );
    }

    var dragWidget = Row(
      mainAxisAlignment: questions[0].length > 1 ? MainAxisAlignment.spaceEvenly: MainAxisAlignment.center,
      children: row
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
          ]
        )
    );
  }

  Widget buildNumbers(BuildContext context){
    List<Widget> gridWidget = [];
    List<Widget> lineWidget = [];

    for(int j = 0; j <= maxSize; j++){
      Widget container = Container(
          height: 10,
          width: 5,
          color: 0 == j % 2 ? const Color(0xFF54436B + 0x00060606) : const Color(0xFF54436B - 0x00060606),
          child: Text(grid[0][j], style: TextStyle(fontSize: 10, color: stage % 2 == 0 && stage != total && maxSize - j == (stage ~/ 2 - 1) ? Colors.blue : Colors.black))
      );

      lineWidget.add(DragTarget<int>(
        builder: (context, data, rejectedData){
          return container;
        },
        onAccept: (data){
          if((acceptDrag[0][j] & (1 << data)) != 0){
            successDrag(0, j, data);
          }
        },
      ));

      if(j != maxSize){
        lineWidget.add(const SizedBox(height: 10, width: 5));
      }
    }

    gridWidget.add(Row(mainAxisAlignment: MainAxisAlignment.start, children: lineWidget));

    for(int i = 1; i < 4; i++){
      lineWidget = [];
      for(int j = 0; j <= maxSize; j++){
        Widget container = Container(
            height: 20,
            width: 10,
            color: i % 2 == j % 2 ? const Color(0xFF54436B + 0x00060606) : const Color(0xFF54436B - 0x00060606),
            child: Text(grid[i][j], style: TextStyle(fontSize: 16, color: stage % 2 == 0 && stage != total && maxSize - j == (stage ~/ 2 - 1) ? Colors.blue : Colors.black))
        );

        lineWidget.add(DragTarget<int>(
          builder: (context, data, rejectedData){
            return container;
          },
          onAccept: (data){
            if((acceptDrag[i][j] & (1 << data)) != 0) {
              successDrag(i, j, data);
            }
          },
        ));
      }

      gridWidget.add(Row(mainAxisAlignment: MainAxisAlignment.start, children: lineWidget));

      if(i == 2){
        gridWidget.add(Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 10),
            SizedBox(
                width: 10.0 * maxSize,
                child: const Divider(
                    height: 5,
                    color: Colors.black
                )
            ),
          ],
        ));
      }
    }
    return Expanded(
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: gridWidget
        ),
      )
    );
  }

  Widget buildFight(BuildContext context){
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 410 : 510,
      padding: const EdgeInsets.all(10),
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
        child: Text(text, style: const TextStyle(fontSize: 30))
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
        child: Text(text, style: const TextStyle(fontSize: 30))
      ),
    );
  }
}
