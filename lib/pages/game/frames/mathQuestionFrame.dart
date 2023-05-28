import 'dart:math';

import 'package:flutter/material.dart';

class MathQuestionFrame extends StatefulWidget {
  const MathQuestionFrame(this.state, this.respond, {super.key});

  final MathQuestionState state;
  final void Function(bool) respond;

  @override
  State<MathQuestionFrame> createState() => state;
}

class MathQuestionState extends State<MathQuestionFrame>{
  String question = "";
  List<String> options = [];
  int correct = 0;
  bool responded = false;
  bool built = false;
  Random random = Random();

  void reset(){
    question = "";
    options = [];
    correct = 0;
    responded = false;
  }

  void buildOperationQuestion(String answer){
    question = "Qual operação você precisa fazer?";
    options = ["+", "-", "x", "/"];
    responded = false;

    for(int i = 0; i < options.length; i++){
      if(options[i] == answer){
        correct = i;
        break;
      }
    }

    if(built){
      setState((){});
    }
  }

  void buildMathQuestion(String newQuestion, int answer){
    question = newQuestion;
    correct = random.nextInt(min(answer + 1, 6));
    responded = false;

    options = [];
    for(int i = 0; i < 6; i++){
      options.add((answer - correct + i).toString());
    }

    if(built){
      setState((){});
    }
  }

  void respond(String message){
    question = message;
    responded = true;

    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    built = true;
    Size size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    double buttonsWidth = 140;
    double buttonsHeight = 50;
    List<Widget> buttons = [];

    for(int i = 0; i < options.length; i++){
      if(i == correct){
        buttons.add(buildCorrectButton(options[i], buttonsWidth, buttonsHeight));
      }else{
        buttons.add(buildWrongButton(options[i], buttonsWidth, buttonsHeight));
      }

      if(i + 1 != options.length){
        buttons.add(const SizedBox(width: 10));
      }
    }

    Widget buttonsWidget = Container();
    if(size.width > size.height && buttons.isNotEmpty){
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

  Widget buildCorrectButton(String text, double width, double height){
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: responded ? Colors.green : const Color(0xFF828DF4)),
        onPressed: (){
          widget.respond(true);
        },
        child: Text(text, style: const TextStyle(fontSize: 30))
      ),
    );
  }

  Widget buildWrongButton(String text, double width, double height){
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF828DF4)),
        onPressed: (){
          widget.respond(false);
        },
        child: Text(text, style: const TextStyle(fontSize: 30))
      ),
    );
  }
}