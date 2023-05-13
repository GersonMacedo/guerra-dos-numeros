import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/pages/levelSelector.dart';

class Menu extends StatelessWidget {
  const Menu(this.changePage, this.frame, this.fps, {super.key});

  final void Function(Widget?, {bool bottom, bool back}) changePage;
  final int frame;
  final int fps;

  @override
  Widget build(BuildContext context){
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
                Positioned.fill(child: Image.asset('assets/images/clouds/${frame % 16}.png', repeat: ImageRepeat.repeatX, scale: 0.2)),
              ],
            )
          ),
          ElevatedButton(
            onPressed: (){changePage(LevelSelector(changePage, frame, fps), back: true);},
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