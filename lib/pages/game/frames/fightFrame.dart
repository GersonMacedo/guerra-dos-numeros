import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';

class FightFrame extends StatefulWidget {
  const FightFrame(this.state, this.images, {super.key});

  final FightState state;
  final ImagesLoader images;

  @override
  State<FightFrame> createState() => state;
}

class FightState extends State<FightFrame>{
  int frame = 0;
  int hamburgerAttack = -100;
  int robotAttack = -100;
  int attackType = 0;

  void updateFrame(int newFrame){
    setState(() {
      frame = newFrame;
    });
  }

  void setHamburgerAttack(int time){
    hamburgerAttack = time;
    attackType = frame % widget.images.attackPath.length;
  }

  void setRobotAttack(int time){
    robotAttack = time;
  }

  bool nobodyAttacks(){
    return (frame < hamburgerAttack || hamburgerAttack + 20 < frame) && (frame < robotAttack + 10 || robotAttack + 20 < frame);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 400 : 500;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 200 : 250;

    return Container(
      alignment: Alignment.center,
      width: width + 10,
      height: height + 5,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: height,
            height: height,
            child: getHamburger()
          ),
          Positioned(
              left: height,
              top: 0,
              width: height,
              height: height,
              child: getRobot()
          ),
          Positioned(
              left: height * 9 / 10,
              top: (frame % 10  < 5 && nobodyAttacks() ? height / 10 - widget.images.heights[frame % 10] * height / 50 : height / 10),
              width: height / 2,
              height: height / 2,
              child: getBanana()
          ),
          Positioned(
              left: 133 * height / 250,
              top: 0,
              width: height,
              height: height,
              child: getLaser()
          )
        ]
      )
    );
  }

  Widget getHamburger(){
    if(frame >= hamburgerAttack && frame < hamburgerAttack + 20){
      return widget.images.hamburger[0];
    }

    if(frame >= robotAttack + 10 && frame < robotAttack + 20){
      int diff = frame - robotAttack - 10;
      return diff % 2 == 0 ? widget.images.hittingHamburger[diff ~/ 2] : Container();
    }

    return widget.images.hamburger[frame % 10  < 5 ? frame % 10 : 0];
  }

  Widget getRobot(){
    if(frame >= hamburgerAttack + 10 && frame < hamburgerAttack + 20){
      int diff = frame - hamburgerAttack - 10;
      return diff % 2 == 0 ? widget.images.hittingRobot[diff ~/ 2] : Container();
    }

    if(frame >= robotAttack && frame < robotAttack + 20){
      return widget.images.robot[0];
    }

    return widget.images.robot[(frame % 10  > 1) && (frame % 10 < 7) ? frame % 10 - 2 : 0];
  }

  Widget getBanana(){
    int start = hamburgerAttack + widget.images.attackDelay[attackType];
    int end = start + widget.images.attackFrames[attackType];
    if(frame >= start && frame < end){
      return widget.images.hamburgerAttacks[attackType][frame - start];
    }

    if(frame >= robotAttack + 10 && frame < robotAttack + 20 && (frame - robotAttack) % 2 == 1 ){
      return Container();
    }

    return widget.images.banana;
  }

  Widget getLaser(){
    if(frame >= robotAttack + 3 && frame < robotAttack + 10){
      return widget.images.robotAttack[frame - robotAttack - 3];
    }

    return Container();
  }
}