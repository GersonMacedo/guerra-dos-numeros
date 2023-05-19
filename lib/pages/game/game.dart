import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';
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
  int carry = 0;
  int result = 0;
  List<List<String>> grid = [];
  List<List<int>> acceptDrag = [];
  List<bool> dragElement = [true, true];
  int frame = 0;
  int fps = 10;
  int startFrame = 0;
  int wrongAnswers = 0;
  int nextStage = -100;
  int hamburgerAttack = -100;
  int robotAttack = -100;
  int attackType = 0;
  ImagesLoader images = ImagesLoader(false, true);
  late Timer _timer;

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  _GameState(){
    print("@!");
    _timer = Timer.periodic(
      Duration(microseconds: 1000000 ~/ fps),
      (timer) {
      setState(() {
          frame++;
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
  void didChangeDependencies(){
    images.cacheImages(context);

    super.didChangeDependencies();
  }

  void updateStage(){
    setState((){
      responded = false;
      dragElement = [true, true];
      timeLeft = widget.time;
      if(stage % 2 == 0){
        timeLeft = max(timeLeft, 10);

        if(stage == 0){
          grid[2][0] = widget.operation;
          questions = widget.numbers.map((e) => e.toString()).toList();
        }else{
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
      startFrame = frame;
    });
  }

  void clearDrag(){
    for(int i = 0; i < acceptDrag.length; i++){
      for(int j = 0; j < acceptDrag[i].length; j++){
        acceptDrag[i][j] = 0;
      }
    }
  }

  firstFrame(){
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

    if(widget.question == ""){
      question = "Mova os numeros para a posição correta";
      questions = widget.numbers.map((e) => e.toString()).toList();
      stage = 1;
      grid[2][0] = widget.operation;
    }

    if(widget.operation == "+"){
      total = 2 * maxSize + 2;
    }
  }

  @override
  void respond(bool right){
    setState(() {
      responded = true;
      if (right) {
        hamburgerAttack = frame + 10 - frame % 10;
        nextStage = frame + 30 - frame % 10;
        attackType = frame % images.attackPath.length;
        question = "Resposta correta!";
      } else if (timeLeft == 0){
        wrongAnswers++;
        robotAttack = frame;
        nextStage = frame + 20;
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
        robotAttack = frame + 10 - frame % 10;
        nextStage = frame + 30 - frame % 10;
        wrongAnswers++;
        question = "Resposta errada!";
      }
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
        respond(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(frame == 0){
      firstFrame();
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TopGameFrame(changePage: widget.changePage, question: widget.question, numbers: widget.numbers, operation: widget.operation, stage: stage, total: total),
          stage % 2 == 0 ?
            MathQuestionFrame(question: question, correct: correct, questions: questions, respond: respond, responded: responded) :
            DragQuestionFrame(question: question, questions: questions, dragElement: dragElement),
          const SizedBox(height: 5)
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
                  FightFrame(frame :frame, hamburgerAttack: hamburgerAttack, robotAttack: robotAttack, attackType: attackType, images: images),
                  buildTimer(context)
                ],
              ),
              const SizedBox(width: 10),
              NumbersGridFrame(grid: grid, acceptDrag: acceptDrag, successDrag: successDrag, stage: stage, total: total),
              const SizedBox(width: 10)
            ]
          ),
        )
      ];
    }

    return [
      NumbersGridFrame(grid: grid, acceptDrag: acceptDrag, successDrag: successDrag, stage: stage, total: total),
      const SizedBox(height: 10),
      FightFrame(frame: frame, hamburgerAttack: hamburgerAttack, robotAttack: robotAttack, attackType: attackType, images: images),
      const SizedBox(height: 10),
      buildTimer(context)
    ];
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
