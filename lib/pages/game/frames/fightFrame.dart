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

  void reset(){
    frame = 0;
    hamburgerAttack = -100;
    robotAttack = -100;
    attackType = 0;
  }

  void updateFrame(int newFrame){
    frame = newFrame;

    setState((){});
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
      decoration: const BoxDecoration(
          color: Color(0xFF1F2D5E),
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            top: 0,
            child: Transform.translate(
              offset: Offset(0, height*0.28), // Defina o deslocamento desejado verticalmente
              child: widget.images.grassMap[frame % 16],
            ),
          ),
          Positioned(
            left: width / 2 - 125,
            top: height*0.3,
            width: height,
            height: height,
            child: getHamburger()
          ),
          Positioned(
              right: width / 2 - 125,
              top: height*0.3,
              width: height,
              height: height,
              child: getRobot()
          ),
          Positioned(
              left: width / 2 - 125,
              top: height*0.3,
              width: height,
              height: height,
              child: getBanana()
          ),
          Positioned(
              right: width / 2 - 125,
              top: height*0.3,
              width: height,
              height: height,
              child: getLaser()
          )
        ]
      )
    );
  }

  Widget getHamburger(){
    if(frame >= hamburgerAttack && frame < hamburgerAttack + 5){
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }

    if(frame >= hamburgerAttack + 5 && frame < hamburgerAttack + 20){
      return widget.images.sttopedHamburger;
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

    if(frame >= robotAttack && frame < robotAttack + 10){
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }

    if(frame >= robotAttack + 10 && frame < robotAttack + 20){
      return widget.images.sttopedRobot;
    }

    return widget.images.robot[(frame % 10  > 1) && (frame % 10 < 7) ? frame % 10 - 2 : 0];
  }

  Widget getBanana(){
    int start = hamburgerAttack;
    int end = start + widget.images.attackFrames[attackType];
    if(frame >= start && frame < end){
      return widget.images.hamburgerAttacks[attackType][frame - start];
    }

    return Container();
  }

  Widget getLaser(){
    if(frame >= robotAttack && frame < robotAttack + 10){
      return widget.images.robotAttack[frame - robotAttack];
    }

    return Container();
  }
}