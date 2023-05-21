import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';
import 'package:guerra_dos_numeros/pages/game/frames/congratulationsFrame.dart';
import 'package:guerra_dos_numeros/pages/game/frames/dragQuestionFrame.dart';
import 'package:guerra_dos_numeros/pages/game/frames/fightFrame.dart';
import 'package:guerra_dos_numeros/pages/game/frames/mathQuestionFrame.dart';
import 'package:guerra_dos_numeros/pages/game/frames/numbersGridFrame.dart';
import 'package:guerra_dos_numeros/pages/game/frames/topFrame.dart';

//TODO: Tela de fim do jogo
//TODO: Melhorar design
//TODO: Mecânica de perder o jogo
//TODO: Pilha de estado que controla a operação atual
//  Possibilitará reutilizar código de soma e subtração para multiplicação e divisão, além de tornar expressões possiveis
//TODO: Extrair toda logica relacionada a soma para outro arquivo
//TODO: operações de vezes, subtração e multiplicação
//TODO: Modo de resolver expressões

class Game extends StatefulWidget {
  const Game(this.operation, this.question, this.numbers, this.changePage, this.time, {super.key});

  final void Function(Widget?) changePage;
  final String operation;
  final String question;
  final List<int> numbers;
  final int time;

  @override
  State<Game> createState() => GameState();
}

class GameState extends State<Game>{
  int stage = 0;
  int total = 10;
  bool responded = false;
  int timeLeft = 90;
  List<int> numbers1 = [];
  List<int> numbers2 = [];
  int maxSize = 0;
  int carry = 0;
  int result = 0;
  int frame = 0;
  int fps = 10;
  int wrongAnswers = 0;
  int nextStage = -100;
  ImagesLoader images = ImagesLoader(false, true);
  late TopGameFrame topGameFrame;
  late FightFrame fightFrame;
  late NumbersGridFrame numbersGridFrame;
  late MathQuestionFrame mathQuestionFrame;
  late DragQuestionFrame dragQuestionFrame;
  CongratulationsFrame congratulationsFrame = const CongratulationsFrame();
  late Timer _timer;

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  GameState(){
    _timer = Timer.periodic(
      Duration(microseconds: 1000000 ~/ fps),
      (timer) {
      setState(() {
          frame++;
          fightFrame.state.updateFrame(frame);
          if(frame % fps == 0){
            if(timeLeft != 0 && !responded){
              timeLeft--;
              if(timeLeft == 0){
                respond(false);
              }
            }
          }

          if(frame == nextStage){
            updateStage();
          }
        });
      }
    );
  }

  @override
  void initState() {
    String mainQuestion = widget.question == "" ? "Quanto é | ${widget.operation} | ?" : widget.question;
    topGameFrame = TopGameFrame(TopGameState(), mainQuestion, widget.numbers, widget.question == "" ? 1 : 0, total, widget.changePage, key: const ValueKey("TopGameFrame"));
    fightFrame = FightFrame(FightState(), images);
    numbersGridFrame = NumbersGridFrame(NumbersGridState(), successDrag, total, key: const ValueKey("NumberGridFrame"));
    mathQuestionFrame = MathQuestionFrame(MathQuestionState(), respond);
    dragQuestionFrame = DragQuestionFrame(DragQuestionState());

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

    numbersGridFrame.state.grid = [
      gridLine.sublist(0),
      gridLine.sublist(0),
      gridLine.sublist(0),
      gridLine.sublist(0)
    ];
    numbersGridFrame.state.acceptDrag = [
      acceptList.sublist(0),
      acceptList.sublist(0),
      acceptList.sublist(0),
      acceptList.sublist(0)
    ];

    for(int i = 1; i <= maxSize; i++){
      numbersGridFrame.state.acceptDrag[1][i] = 3;
      numbersGridFrame.state.acceptDrag[2][i] = 3;
    }

    if(widget.question == ""){
      dragQuestionFrame.state.update(widget.numbers.map((e) => e.toString()).toList());
      stage = 1;
      numbersGridFrame.state.grid[2][0] = widget.operation;
    }else{
      mathQuestionFrame.state.buildOperationQuestion(widget.operation);
    }

    if(widget.operation == "+"){
      total = 2 * maxSize + 2;
    }

    super.initState();
  }

  @override
  void didChangeDependencies(){
    images.cacheImages(context);

    super.didChangeDependencies();
  }

  void updateStage(){
    setState((){
      responded = false;
      timeLeft = widget.time;
      if(stage % 2 == 0){
        dragQuestionFrame.state.dragElement = [true, true];
        timeLeft = max(timeLeft, 10);

        if(stage == 0){
          numbersGridFrame.state.grid[2][0] = widget.operation;
          dragQuestionFrame.state.update(widget.numbers.map((e) => e.toString()).toList());
        }else{
          if(result >= 10){
            carry = result ~/ 10;
            dragQuestionFrame.state.update([(carry).toString(), (result % 10).toString()]);
            numbersGridFrame.state.acceptDrag[stage + 2 < total ? 0 : 3][maxSize - stage ~/ 2] = 1;
            numbersGridFrame.state.acceptDrag[3][maxSize - stage ~/ 2 + 1] = 2;
          }else{
            carry = 0;
            dragQuestionFrame.state.update([(result % 10).toString()]);
            numbersGridFrame.state.acceptDrag[3][maxSize - stage ~/ 2 + 1] = 1;
          }
        }
      }else{
        if(stage != 1){
          if(carry != 0){
            numbersGridFrame.state.grid[stage + 1 < total ? 0 : 3][maxSize - (stage ~/ 2)] = carry.toString();
          }
          numbersGridFrame.state.grid[3][maxSize - (stage ~/ 2) + 1] = (result % 10).toString();
        }

        if(stage + 1 == total){
          stage++;
          topGameFrame.state.updateStage(stage);
          responded = true;
          return;
        }

        String question = "Quanto é ${numbers1[stage ~/ 2]} + ${numbers2[stage ~/ 2]}";
        if(carry != 0){
          question += " + ${carry}";
        }
        question += " ?";
        result = numbers1[stage ~/ 2] + numbers2[stage ~/ 2] + carry;
        mathQuestionFrame.state.buildMathQuestion(question, result);
      }
      stage++;
      topGameFrame.state.updateStage(stage);
      numbersGridFrame.state.updateGrid(stage);
    });
  }

  void respond(bool right){
    if(responded){
      return;
    }

    setState(() {
      responded = true;
      if (right) {
        fightFrame.state.setHamburgerAttack(frame + 10 - frame % 10);
        nextStage = frame + 30 - frame % 10;
        mathQuestionFrame.state.respond("Resposta correta!");
      } else if (timeLeft == 0){
        wrongAnswers++;
        fightFrame.state.setRobotAttack(frame);
        nextStage = frame + 20;
        mathQuestionFrame.state.respond("Acabou o tempo!");
        if(stage == 1){
          for(int i = 0; i < maxSize; i++){
            numbersGridFrame.state.grid[1][maxSize - i] = numbers1[i].toString();
            numbersGridFrame.state.grid[2][maxSize - i] = numbers2[i].toString();
          }
          numbersGridFrame.state.clearDrag();
        }else if(stage % 2 == 1){
          if(carry != 0){
            numbersGridFrame.state.grid[stage + 1 < total ? 0 : 3][maxSize - (stage ~/ 2)] = carry.toString();
          }
          numbersGridFrame.state.grid[3][maxSize - (stage ~/ 2) + 1] = (result % 10).toString();
          numbersGridFrame.state.clearDrag();
        }
        dragQuestionFrame.state.dragElement = [false, false];
        numbersGridFrame.state.updateGrid(stage);
      }else{
        fightFrame.state.setRobotAttack(frame + 10 - frame % 10);
        nextStage = frame + 30 - frame % 10;
        wrongAnswers++;
        mathQuestionFrame.state.respond("Resposta errada!");
      }
    });
  }

  void successDrag(int i, int j, int element){
    setState(() {
      dragQuestionFrame.state.dragElement[element] = false;
      if(stage == 1){
        for(int k = 1; k <= maxSize; k++){
          numbersGridFrame.state.acceptDrag[i][k] = 0;
          if(k - 1 < dragQuestionFrame.state.questions[element].length){
            numbersGridFrame.state.grid[i][k] = dragQuestionFrame.state.questions[element][k - 1];
          }
        }
      }else{
        numbersGridFrame.state.acceptDrag[i][j] = 0;
        numbersGridFrame.state.grid[i][j] = dragQuestionFrame.state.questions[element];
      }
      if(dragQuestionFrame.state.dragElement[0] == false && (dragQuestionFrame.state.questions.length == 1 || dragQuestionFrame.state.dragElement[1] == false)){
        respond(true);
      }
      numbersGridFrame.state.updateGrid(stage);
      dragQuestionFrame.state.setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          topGameFrame,
          IndexedStack(
            index: stage == total ? 2 : (stage % 2 == 0 ? 0 : 1),
            children: [
              mathQuestionFrame,
              dragQuestionFrame,
              congratulationsFrame
            ],
          ),
          const SizedBox(height: 5),
          buildBottom(context),
        ]
      )
    );
  }

  Widget buildBottom(BuildContext context){
    return Flexible(
      child: Flex(
        direction: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? Axis.horizontal : Axis.vertical,
        verticalDirection: VerticalDirection.up,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                fightFrame,
                buildTimer(context)
              ]
            )
          ),
          numbersGridFrame
        ]
      )
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
}
