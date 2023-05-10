import 'package:flutter/material.dart';

class MathQuestionFrame extends StatelessWidget {
  const MathQuestionFrame({super.key, required this.question, required this.respond, required this.responded, required this.questions, required this.correct});

  final String question;
  final void Function(bool) respond;
  final bool responded;
  final List<String> questions;
  final int correct;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    double buttonsWidth = 140;
    double buttonsHeight = 50;
    List<Widget> buttons = [];

    for(int i = 0; i < questions.length; i++){
      if(i == correct){
        buttons.add(buildCorrectButton(questions[i], buttonsWidth, buttonsHeight));
      }else{
        buttons.add(buildWrongButton(questions[i], buttonsWidth, buttonsHeight));
      }

      if(i + 1 != questions.length){
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
          if(!responded){
            respond(true);
          }
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
          if(!responded) {
            respond(false);
          }
        },
        child: Text(text, style: const TextStyle(fontSize: 30))
      ),
    );
  }
}