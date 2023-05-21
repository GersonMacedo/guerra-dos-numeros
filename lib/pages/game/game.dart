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

class MathStack{
  MathStack(this.operation, this.x, this.y, this.numbers, this.stage);

  String operation;
  int x, y;
  List<String> numbers;
  int stage;
}

class Game extends StatefulWidget {
  const Game(this.question, this.stack, this.changePage, this.time, {super.key});

  final String question;
  final List<MathStack> stack;
  final void Function(Widget?) changePage;
  final int time;

  @override
  State<Game> createState() => GameState();
}

class GameState extends State<Game>{
  late List<MathStack> stack;
  late String operation;
  late int stage, x, y, r;
  late List<String> numbers;
  late int totalStages;
  int step = 0;
  int totalSteps = 2;
  int iteration = 0;
  bool responded = false;
  int timeLeft = 90;
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

  void loadStack(){
    stage = stack.last.stage;
    x = stack.last.x;
    y = stack.last.y;
    operation = stack.last.operation;
    numbers = stack.last.numbers.sublist(0);
    r = x + numbers.length + 1;
    stack.removeLast();
  }

  @override
  void initState() {
    print("INIT");
    stack = widget.stack;
    loadStack();

    for(var number in numbers){
      maxSize = max(maxSize, number.length);
    }
    totalStages = maxSize + 1;

    String mainQuestion = widget.question == "" ? "Quanto é | $operation | ?" : widget.question;
    topGameFrame = TopGameFrame(TopGameState(), mainQuestion, numbers, widget.question == "" ? 1 : 0, totalStages, widget.changePage);
    fightFrame = FightFrame(FightState(), images);
    numbersGridFrame = NumbersGridFrame(NumbersGridState(), successDrag, totalStages, operation, x, y, r, maxSize);
    mathQuestionFrame = MathQuestionFrame(MathQuestionState(), respond);
    dragQuestionFrame = DragQuestionFrame(DragQuestionState());


    if(operation == "/"){
      throw("NOT IMPLEMENTED");
    }else{
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
        numbersGridFrame.state.acceptDrag[x + 1][y + i] = operation == "-" ? 1 : 3;
        numbersGridFrame.state.acceptDrag[x + 2][y + i] = operation == "-" ? 2 : 3;
      }

      if(stage == 0){
        mathQuestionFrame.state.buildOperationQuestion(operation);
      }else{
        dragQuestionFrame.state.update(numbers.map((e) => e.toString()).toList());
        numbersGridFrame.state.grid[r - 1][y] = operation;
      }
    }

    super.initState();
  }

  @override
  void didChangeDependencies(){
    images.cacheImages(context);

    super.didChangeDependencies();
  }

  void setDragResultQuestion(){
    if(stage == 0){
      dragQuestionFrame.state.update(numbers.map((e) => e.toString()).toList());
      numbersGridFrame.state.grid[r - 1][y] = operation;
    }else{
      dragQuestionFrame.state.dragElement = [true, true];
      timeLeft = max(timeLeft, 10);

      if(result >= 10){
        carry = result ~/ 10;
        dragQuestionFrame.state.update([(carry).toString(), (result % 10).toString()]);
        numbersGridFrame.state.acceptDrag[stage != totalStages && iteration + 1 != maxSize ? x : r][maxSize - (operation == "x" ? 1 : stage) - iteration] = 1;
        numbersGridFrame.state.acceptDrag[r][numbersGridFrame.state.acceptDrag[r].length - stage - iteration] = 2;
      }else{
        carry = 0;
        dragQuestionFrame.state.update([(result % 10).toString()]);
        numbersGridFrame.state.acceptDrag[r][numbersGridFrame.state.acceptDrag[r].length - stage - iteration] = 1;
      }
    }
  }

  void updateStage(){
    setState(() {
      timeLeft = widget.time;

      step++;
      if(step == totalSteps){
        step = 0;
        if(operation == "x" && stage != 0 && numbersGridFrame.state.grid[1][maxSize - iteration - 1] != ""){
          iteration++;
        }else{
          stage++;
          iteration = 0;

          if(stage == totalStages){
            if(stack.isEmpty){
              topGameFrame.state.updateStage(stage);
              return;
            }

            loadStack();
          }

          if(operation == "x" && stage != 1){
            List<String> newLine = [];
            List<int> newAccept = [];
            for(int i = 0; i <= numbersGridFrame.state.grid.last.length; i++){
              newLine.add("");
              newAccept.add(0);
            }

            numbersGridFrame.state.grid.add(newLine);
            numbersGridFrame.state.acceptDrag.add(newAccept);
            numbersGridFrame.state.r++;
            r++;
            for(int i = 0; i < numbersGridFrame.state.grid[x].length; i++){
              numbersGridFrame.state.grid[x][i] = "";
            }
            carry = 0;
            numbersGridFrame.state.addLine.add(false);
          }

          topGameFrame.state.updateStage(stage);
        }
      }

      responded = false;
      if(operation == "/"){

      }else if(step + 1 == totalSteps){
        setDragResultQuestion();
      }else if(operation == "+"){

        List<int> digits = [];
        for(int i = numbers.length; i >= 0; i--){
          String d = numbersGridFrame.state.grid[x + i][y + maxSize - stage + 1];
          if(d != " " && d != ""){
            digits.add(int.parse(d));
          }
        }

        if(digits.isEmpty){
          result = 0;
          step = 1;
          setDragResultQuestion();
        }else if(digits.length == 1){
          result = digits[0];
          step = 1;
          setDragResultQuestion();
        }else{
          String question = "Quanto é ${digits[0]}";
          result = digits[0];
          for(int i = 1; i < digits.length; i++){
            question += " + ${digits[i]}";
            result += digits[i];
          }
          question += " ?";

          mathQuestionFrame.state.buildMathQuestion(question, result);
        }

      }else if(operation == "x"){

        print("$stage $step $iteration $maxSize");
        int num1 = int.parse(numbersGridFrame.state.grid[x + 2][y + maxSize  - stage + 1]);
        int num2 = int.parse(numbersGridFrame.state.grid[x + 1][y + maxSize - iteration]);

        String question = "Quanto é $num1 x $num2";
        if(carry != 0){
          question += " + ${carry}";
        }

        result = num1 * num2 + carry;
        mathQuestionFrame.state.buildMathQuestion(question, result);

      }

      numbersGridFrame.state.updateGrid(stage, step, iteration, operation);
    });
  }

  void respond(bool right){
    if(responded){
      return;
    }

    setState((){
      responded = true;
      if(right){
        fightFrame.state.setHamburgerAttack(frame + 10 - frame % 10);
        nextStage = frame + 30 - frame % 10;
        mathQuestionFrame.state.respond("Resposta correta!");
      }else if(timeLeft == 0){
        wrongAnswers++;
        fightFrame.state.setRobotAttack(frame);
        nextStage = frame + 20;
        mathQuestionFrame.state.respond("Acabou o tempo!");
        if(stage == 0 && step + 1 == totalSteps && operation != "/"){
          for(int i = 0; i < maxSize; i++){
            numbersGridFrame.state.grid[x + 1][i + 1] = numbers[0][i];
            numbersGridFrame.state.grid[x + 2][i + 1] = numbers[1][i];
          }

          dragQuestionFrame.state.dragElement = [false, false];
          numbersGridFrame.state.clearDrag();
        }else if(operation == "+"){
          if(step == 1){
            if(carry != 0){
              numbersGridFrame.state.grid[stage + 1 != totalStages ? x : r][maxSize - stage] = carry.toString();
            }

            numbersGridFrame.state.grid[r][maxSize - stage + 1] = (result % 10).toString();
            numbersGridFrame.state.clearDrag();
          }

        }else{
          throw("NOT IMPLEMENTED RIGHT ANSWER $operation");
        }
      }else{
        fightFrame.state.setRobotAttack(frame + 10 - frame % 10);
        nextStage = frame + 30 - frame % 10;
        wrongAnswers++;
        mathQuestionFrame.state.respond("Resposta errada!");
      }

      numbersGridFrame.state.updateGrid(stage, step, iteration, operation);
    });
  }

  void successDrag(int i, int j, int element){
    setState(() {
      dragQuestionFrame.state.dragElement[element] = false;
      if(stage == 0){
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
      numbersGridFrame.state.updateGrid(stage, step, iteration, operation);
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
            index: stage == totalStages ? 2 : step,
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
