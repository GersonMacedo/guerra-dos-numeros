import 'dart:math';

import 'package:guerra_dos_numeros/levels.dart';

class MathStack{
  MathStack(this.operation, this.x, this.y, this.numbers, this.stage);

  String operation;
  int x, y;
  List<String> numbers;
  int stage;
}

class LevelData{
  LevelData(this.operations, this.correctBonus, this.wrongPenalty){
    question = "";
  }
  LevelData.withQuestion(this.operations, this.correctBonus, this.wrongPenalty, this.question);

  List<MathStack> operations;
  late String question;
  int startTime = 150;
  int correctBonus;
  int wrongPenalty;
}

class Levels{
  static Random random = Random();
  static bool interpretation = true;
  static List<int> next = [3, 2];
  static int type = -1;
  static int actual = 0;
  static int size = 0;

  static List<String> operators = ["+", "-", "x", "/"];
  static int operator = 0;
  static int digits = 2;
  static int time = 0;
  static List<int> correctTimeList = [90, 30, 10, 2];
  static List<int> wrongTimeList = [30, 45, 60, 90];

  static int getRandomNumber(){
    Random random = Random();
    return pow(10, digits - 1).toInt() + random.nextInt(pow(10, digits).toInt() - pow(10, digits - 1).toInt() - 1);
  }


  static List<int> getNumberList(int size){
    List<int> list = [];
    for(int i = 0; i < size; i++){
      list.add(getRandomNumber());
    }

    return list;
  }

  static List<String> sumQuestions = [
    "Mariazinha tinha | reais guardado, no seu aniversário ela ganhou mais | reais do seu pai. Quantos reais ela tem hoje?",
    "Joãozinho tinha | maçãs e acabou de pegar | da macieira do seu vizinho, quantas maçãs ele tem agora?"
  ];

  static List<List<LevelData>> levels = [
    [
      LevelData.withQuestion([MathStack("+", 0, 0, ["12", "47"], 0)], 90, 30, sumQuestions[0]),
      LevelData.withQuestion([MathStack("+", 0, 0, ["37", "29"], 0)], 90, 30, sumQuestions[1]),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 3 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 4 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 5 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 6 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 7 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 8 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 9 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 10 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 11 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 12 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 13 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 14 : | + | ?"),
      LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0)], 90, 30, "TODO 15 : | + | ?"),
    ],
    [
      LevelData([MathStack("x", 0, 0, ["12", "23"], 0)], 90, 30),
      LevelData.withQuestion([MathStack("x", 0, 0, ["1", "4"], 0)], 90, 30, "TODO 2 : | x |"),
      LevelData.withQuestion([MathStack("x", 0, 0, ["1", "4"], 0)], 90, 30, "TODO 3 : | x |"),
      LevelData.withQuestion([MathStack("x", 0, 0, ["1", "4"], 0)], 90, 30, "TODO 4 : | x |"),
    ]
  ];

  static LevelData getLevel(){
    return type >= 0 ? levels[type][actual] : getCustomLevel();
  }

  static LevelData getNextLevel(){
    return levels[type][++actual];
  }

  static int getTotalLevels(){
    return levels[type].length;
  }

  static bool hasNextLevel(){
    return getTotalLevels() > actual + 1;
  }

  static LevelData getCustomLevel(){

    var mathStack = [MathStack(operators[operator], 0, 0, getNumberList(2).map((e) => e.toString()).toList(), 0)];

    return LevelData(mathStack, correctTimeList[time], wrongTimeList[time]);
  }

  static void finish(){
    if(next[type] == actual + 1){
      next[type]++;
    }
  }
}