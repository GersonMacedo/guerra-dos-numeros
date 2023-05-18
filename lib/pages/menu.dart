import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/pages/levelSelector.dart';

class Menu extends StatefulWidget {
  const Menu(this.changePage, this.frame, this.fps, {super.key});

  final void Function(Widget?, {bool bottom, bool back}) changePage;
  final int frame;
  final int fps;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu>{

  _MenuState(){
    _timer = Timer.periodic(
        Duration(microseconds: 1000000 ~/ fps), (timer) {
      setState(() {
        frame++;
      });
    }
    );
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }


  late Timer _timer;
  int frame = 0;
  int fps = 10;

  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "Guerra dos números, Robôs e coisas matemáticas",
              style: TextStyle(fontSize: 40, color: Colors.white),
              textAlign: TextAlign.center,
            )
          ),
          Container(
            width: double.infinity,
            height: 200,
            child: Stack(
              children: [
                Positioned(
                    left: width / 2 - 150,
                    top: 87,
                    width: 50,
                    height: 50,
                    child: Image.asset('asse'
                        'ts/images/hamburgerJumping/${frame % 8  < 5 ? frame % 8 : 0}.png', scale: 0.2)
                ),
                Positioned(
                    left:width / 2 + 100,
                    top: 85,
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/images/movingRobot/${frame % 8  > 2 ? frame % 8 - 3 : 0}.png', scale: 0.2)
                ),
                Positioned.fill(child: Image.asset('assets/images/clouds/${15 - frame % 16}.png', repeat: ImageRepeat.repeatX, scale: 0.2))
              ],
            )
          ),
          ElevatedButton(
            onPressed: (){widget.changePage(LevelSelector(widget.changePage, frame, fps), back: true);},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff50CB93),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            child: Container(
              width: 300,
              height: 50,
              alignment: Alignment.center,
              child:  const Text("Iniciar", style: TextStyle(fontSize: 25))
            )
          )
        ],
      )
    );
  }
}