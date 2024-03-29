import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';
import 'package:guerra_dos_numeros/levels.dart';
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
  const Game(this.changePage, this.level, {super.key});

  final LevelData level;
  final void Function(Widget?) changePage;

  @override
  State<Game> createState() => GameState();
}

class GameState extends State<Game>{
  late List<MathStack> stack;
  late String operation;
  late int stage, x, y, r;
  late List<String> numbers;
  late int totalStages;
  late LevelData level;
  int step = 0;
  int totalSteps = 2;
  int iteration = 0;
  bool responded = false;
  bool finished = false;
   int timeLeft = 90;
  int maxSize = 0;
  int carry = 0;
  int result = 0;
  int frame = 0;
  int fps = 10;
  int nextStage = -100;
  int mistakes = 0;
  ImagesLoader images = ImagesLoader(true, false, true, false);
  late TopGameFrame topGameFrame;
  late FightFrame fightFrame;
  late NumbersGridFrame numbersGridFrame;
  late MathQuestionFrame mathQuestionFrame;
  late DragQuestionFrame dragQuestionFrame;
  late Timer _timer;

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  GameState(){
    _timer = Timer.periodic(
      Duration(microseconds: 1000000 ~/ fps), (timer) {
        setState(() {
          frame++;
          if(frame >= 10){
            fightFrame.state.updateFrame(frame);
          }

          if(finished){
            return;
          }

          if(timeLeft <= 0){
            finished = true;
            fightFrame.state.end(false);
            return;
          }

          if((stage != 0 || step != 0) && frame % fps == 0){
            if(timeLeft != 0 && !responded){
              timeLeft--;
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
    step = stack.last.step;
    iteration = stack.last.iteration;
    x = stack.last.x;
    y = stack.last.y;
    operation = stack.last.operation;
    numbers = stack.last.numbers.sublist(0);
    if(int.parse(numbers[0]) < int.parse(numbers[1])){
      String k = numbers[0];
      numbers[0] = numbers[1];
      numbers[1] = k;
    }
    r = x + numbers.length + 1;
    stack.removeLast();
  }

  void startLevel(bool first){
    stack = level.operations.sublist(0);
    finished = false;
    timeLeft = min(90, 3 * level.correctBonus);
    carry = 0;
    result = 0;
    responded = false;
    nextStage = -100;
    mistakes = 0;
    loadStack();

    maxSize = 0;
    for(var number in numbers){
      maxSize = max(maxSize, number.length);
    }
    totalStages = (operation == '+' ? maxSize: min(numbers[0].length, numbers[1].length)) + 1;

    String mainQuestion = level.question == "" ? "Quanto é | $operation | ?" : level.question;
    if(first){
      topGameFrame = TopGameFrame(TopGameState(), mainQuestion, numbers, level.question == "" ? 1 : 0, totalStages, widget.changePage);
      fightFrame = FightFrame(FightState(), images);
      numbersGridFrame = NumbersGridFrame(NumbersGridState(), successDrag, operation, x, y, r, maxSize);
      mathQuestionFrame = MathQuestionFrame(MathQuestionState(), respond);
      dragQuestionFrame = DragQuestionFrame(DragQuestionState());
    }else{
      topGameFrame.state.updateQuestion(mainQuestion, numbers, stage, totalStages);
      fightFrame.state.reset();
      numbersGridFrame.state.newOperation(operation, x, y, r, maxSize);
      mathQuestionFrame.state.reset();
      dragQuestionFrame.state.reset();
    }

    frame = -1;
  }

  void firstFrame(){
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
        numbersGridFrame.state.acceptDrag[x + 1][y + i] = (operation == "-" || (operation == 'x' && numbers[0].length != numbers[1].length)) ? 1 : 3;
        numbersGridFrame.state.acceptDrag[x + 2][y + i] = (operation == "-" || (operation == 'x' && numbers[0].length != numbers[1].length)) ? 2 : 3;
      }

      mathQuestionFrame.state.buildOperationQuestion(operation);
    }
  }

  @override
  void initState() {
    level = widget.level;
    startLevel(true);
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
      //timeLeft = max(timeLeft, 10);

      if(result >= 10){
        carry = result ~/ 10;
        dragQuestionFrame.state.update([(carry).toString(), (result % 10).toString()]);
        numbersGridFrame.state.acceptDrag[(operation == "+" ? stage + 1 != totalStages : numbersGridFrame.state.grid[x + 1][maxSize - iteration - 1] != "") ? x : r][maxSize - (operation == "x" ? 1 : stage) - iteration] = 1;
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
      step++;
      if(step == totalSteps){
        step = 0;
        if(operation == "x" && stage != 0 && numbersGridFrame.state.grid[x + 1][maxSize - iteration - 1] != ""){
          iteration++;
        }else{
          stage++;
          iteration = 0;

          if(stage == totalStages){
            if(operation == "x" && maxSize != 1){
              operation = "+";
              stage = 1;
              step = 0;
              iteration = 0;
              x += 3;
              r += 2;
              maxSize = numbers[0].length + numbers[1].length - (carry != 0 ? 0 : 1);
              totalStages = maxSize + 1;
              numbersGridFrame.state.updateOperation(operation, x, y, r, maxSize);
            }else if(stack.isEmpty){
              topGameFrame.state.updateStage(stage);
              finished = true;
              fightFrame.state.end(true);
              Levels.finish(mistakes != 0);
              return;
            }else{
              loadStack();
            }
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
            numbersGridFrame.state.carryLine.add(false);
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
        for(int i = r - 1; i >= x; i--){
          String d = numbersGridFrame.state.grid[i][y + maxSize - stage + 1];
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

        int num1 = int.parse(numbersGridFrame.state.grid[x + 2][y + maxSize  - stage + 1]);
        int num2 = int.parse(numbersGridFrame.state.grid[x + 1][y + maxSize - iteration]);

        String question = "Quanto é $num1 x $num2";
        if(carry != 0){
          question += " + $carry";
        }
        question += " ?";

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
        timeLeft += level.correctBonus;
      }else if(timeLeft == 0){
        fightFrame.state.setRobotAttack(frame);
        nextStage = frame + 20;
        mathQuestionFrame.state.respond("Acabou o tempo!");
      }else{
        mistakes++;
        fightFrame.state.setRobotAttack(frame + 10 - frame % 10);
        nextStage = frame + 30 - frame % 10;
        timeLeft = max(0, timeLeft - level.wrongPenalty);
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
            numbersGridFrame.state.grid[i][k + maxSize - dragQuestionFrame.state.questions[element].length] = dragQuestionFrame.state.questions[element][k - 1];
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
    if(frame == 0){
      firstFrame();
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          topGameFrame,
          IndexedStack(
            index: finished ? 2 : step,
            children: [
              mathQuestionFrame,
              dragQuestionFrame,
              buildEnd()
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
                GestureDetector(
                  onDoubleTap: (){
                    if(Levels.devMode){
                      print("Skiped");
                      stage = totalStages;
                      finished = true;
                      Levels.finish(false);
                    }
                  },
                  child: fightFrame,
                ),
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
      height: 40,
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

  Widget buildEnd(){
    double width = 140;
    double height = 40;

    Widget message;
    if (stage == totalStages){
      message = Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: height / 2),
        alignment: Alignment.center,
        child: Image.asset("assets/images/congratulations.png"),
      );
    }else{
      message = Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: const Text("Acabou o tempo, voce perdeu!!", style: TextStyle(fontSize: 25, color: Colors.white))
      );
    }

    bool next = Levels.hasNextLevel() && (Levels.type == -1 || stage == totalStages || Levels.next[Levels.type] > Levels.actual + 1);

    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 115 : 175,
      width: double.infinity,
      child: Stack(
        children: [
          message,
          Container(
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width,
                  height: height,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF828DF4)),
                      onPressed: () => widget.changePage(null),
                      child: const Text("Sair da fase", style: TextStyle(fontSize: 15))
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: width,
                  height: height,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF828DF4), padding: const EdgeInsets.all(5)),
                      onPressed: () => startLevel(false),
                      child: const Text("Jogar novamente", style: TextStyle(fontSize: 15))
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: width,
                  height: height,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: next ? const Color(0xFF828DF4) : Colors.black),
                      onPressed: (){
                        if(next){
                          level = Levels.getNextLevel();
                          startLevel(false);
                        }
                      },
                      child: const Text("Próxima fase", style: TextStyle(fontSize: 15))
                  ),
                ),
              ],
            )
          )
        ],
      )
    );
  }
}
