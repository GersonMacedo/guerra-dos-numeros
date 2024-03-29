import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';
import 'package:guerra_dos_numeros/levels.dart';

class FightFrame extends StatefulWidget {
  const FightFrame(this.state, this.images,{super.key});

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
  int finished = -1;

  void reset(){
    frame = 0;
    hamburgerAttack = -100;
    robotAttack = -100;
    attackType = 0;
    finished = -1;
  }

  void updateFrame(int newFrame){
    frame = newFrame;

    setState((){});
  }

  void setHamburgerAttack(int time){
    hamburgerAttack = time;
    attackType = frame % widget.images.attacksTypes[Levels.hamburgerType];
  }

  void setRobotAttack(int time){
    robotAttack = time;
  }

  bool nobodyAttacks(){
    return (frame < hamburgerAttack || hamburgerAttack + 20 < frame) && (frame < robotAttack + 10 || robotAttack + 20 < frame);
  }

  void end(bool victory){
    finished = victory ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 400 : 500;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 200 : 250;

    List<Widget> players = [];
    if(frame >= robotAttack && frame < robotAttack + 10){
      players.add(
        Positioned(
            left: getAttackWidth(width),
            top: height*0.3,
            width: height,
            height: height,
            child: getHamburger()
        )
      );
      players.add(
        Positioned(
            right: getAttackWidth(width),
            top: height*0.3,
            width: height,
            height: height,
            child: getRobot()
        )
      );
    }else{
      players.add(
          Positioned(
              right: getAttackWidth(width),
              top: height*0.3,
              width: height,
              height: height,
              child: getRobot()
          )
      );
      players.add(
          Positioned(
              left: getAttackWidth(width),
              top: height*0.3,
              width: height,
              height: height,
              child: getHamburger()
          )
      );
    }

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
          players[0],
          players[1]
        ]
      )
    );
  }

  Widget getHamburger(){
<<<<<<< HEAD
    if(frame >= hamburgerAttack && frame < hamburgerAttack + 5){
      return const SizedBox(
        width: 0,
        height: 0,
      );
=======
    if(frame >= robotAttack + 20 && finished == 1){
      return widget.images.hamburgerDefeated;
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
    }

    int start = hamburgerAttack;
    int end = start + widget.images.attacksFrames[Levels.hamburgerType][attackType];

    if(frame >= start && frame < end){
      return widget.images.hamburgerAttacks[attackType][frame - start];
    }

    if(frame >= robotAttack + 10 && frame < robotAttack + 20){
      int diff = frame - robotAttack - 10;
      return diff % 2 == 0 ? widget.images.takingDamageHamburger[diff ~/ 2] : Container();
    }

    return widget.images.hamburger[frame % 10  < 5 ? frame % 10 : 0];
  }

  Widget getRobot(){
    if(frame >= hamburgerAttack + 20 && finished == 0){
      return widget.images.robotDefeated;
    }

    if(frame >= hamburgerAttack + 10 && frame < hamburgerAttack + 20){
      int diff = frame - hamburgerAttack - 10;
      return diff % 2 == 0 ? widget.images.takingDamageRobot[diff ~/ 2] : Container();
    }

    if(frame >= robotAttack && frame < robotAttack + 10){
<<<<<<< HEAD
      return const SizedBox(
        width: 0,
        height: 0,
      );
=======
      return widget.images.robotAttack[frame - robotAttack];
>>>>>>> b4878a0f941ad913c768ad05490f526adfeb1c64
    }

    if(frame >= robotAttack + 10 && frame < robotAttack + 20){
      return widget.images.robot[0];
    }

    return widget.images.robot[(frame % 10  > 1) && (frame % 10 < 7) ? frame % 10 - 2 : 0];
  }

  double getAttackWidth(width){
    return (width == 500)?(width / 2 - 110):(width / 2 - 90);
  }
}