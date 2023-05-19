import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/pages/levelSelector.dart';

class Menu extends StatefulWidget {
  const Menu(this.changePage, {super.key});

  final void Function(Widget?, {bool bottom, bool back}) changePage;

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
    });
  }

  @override
  void initState(){
    super.initState();

    for(int i = 0; i < 16; i++){
      clouds.add(Image.asset('assets/images/clouds/${15 - i}.png', repeat: ImageRepeat.repeatX, scale: 0.2));
    }

    for(int i = 0; i < 5; i++){
      hamburger.add(Image.asset('assets/images/hamburgerJumping/$i.png', scale: 0.2));
    }

    for(int i = 0; i < 5; i++){
      robot.add(Image.asset('assets/images/movingRobot/$i.png', scale: 0.2));
    }

    banana = Image.asset('assets/images/banana.png', scale: 0.2);
  }

  @override
  void didChangeDependencies(){
    for(var element in clouds){
      precacheImage(element.image, context);
    }
    for(var element in hamburger){
      precacheImage(element.image, context);
    }
    for(var element in robot){
      precacheImage(element.image, context);
    }
    precacheImage(banana.image, context);

    super.didChangeDependencies();
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  late Timer _timer;
  int frame = 0;
  int fps = 10;
  List<Image> clouds = [];
  List<Image> hamburger = [];
  List<Image> robot = [];
  List<double> heights = [0, 3, 5, 3, 0];
  late Image banana;

  @override
  Widget build(BuildContext context){
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 540 : 960;

    if(MediaQuery.of(context).size.width / width > MediaQuery.of(context).size.height / height){
      width = MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }

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
            decoration: BoxDecoration(
                border: Border.symmetric(horizontal: BorderSide(color: Colors.white))
            ),
            child: Stack(
              children: [
                Positioned.fill(child: clouds[frame % 16]),
                Positioned(
                    left: width / 2 - 150,
                    top: 107,
                    width: 50,
                    height: 50,
                    child: hamburger[frame % 8  < 5 ? frame % 8 : 0]
                ),
                Positioned(
                    left: width / 2 + 100,
                    top: 107,
                    width: 50,
                    height: 50,
                    child: robot[frame % 8  > 2 ? frame % 8 - 3 : 0]
                ),
                Positioned(
                    left: width / 2 - 105,
                    top: frame % 8  < 5 ? 112 - heights[frame % 8] : 112,
                    width: 25,
                    height: 25,
                    child: banana
                )
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