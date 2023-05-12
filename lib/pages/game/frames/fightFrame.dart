import 'dart:math';

import 'package:flutter/material.dart';

class FightFrame extends StatelessWidget {
  FightFrame({super.key, required this.frame, required this.hamburgerAttack, required this.robotAttack, required this.attackType});
  final int frame;
  final int hamburgerAttack;
  final int robotAttack;
  final int attackType;
  List<double> heights = [0, 3, 5, 3, 0];
  List<String> attackPath = ["pinkBananaAttack", "appleBananaAttack", "throwBananaAttack"];
  List<int> attackDelay = [4, 5, 6];
  List<int> attackFrames = [8, 8, 6];

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
              top: (frame % 10  < 5 && nobodyAttacks() ? height / 10 - heights[frame % 10] * height / 50 : height / 10),
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
      return Image.asset('assets/images/hamburgerJumping/0.png');
    }

    if(frame >= robotAttack + 10 && frame < robotAttack + 20){
      int diff = frame - robotAttack - 10;
      return diff % 2 == 0 ? Image.asset('assets/images/hittingHamburger/${diff ~/ 2}.png') : Container();
    }

    return Image.asset('assets/images/hamburgerJumping/${frame % 10  < 5 ? frame % 10 : 0}.png');
  }

  Widget getRobot(){
    if(frame >= hamburgerAttack + 10 && frame < hamburgerAttack + 20){
      int diff = frame - hamburgerAttack - 10;
      return diff % 2 == 0 ? Image.asset('assets/images/hittingRobot/${diff ~/ 2}.png') : Container();
    }

    if(frame >= robotAttack && frame < robotAttack + 20){
      return Image.asset('assets/images/movingRobot/0.png');
    }

    return Image.asset('assets/images/movingRobot/${(frame % 10  > 1) && (frame % 10 < 7) ? frame % 10 - 2 : 0}.png');
  }

  Widget getBanana(){
    int start = hamburgerAttack + attackDelay[attackType];
    int end = start + attackFrames[attackType];
    if(frame >= start && frame < end){
      return Image.asset('assets/images/${attackPath[attackType]}/${frame - start}.png');
    }

    if(frame >= robotAttack + 10 && frame < robotAttack + 20 && (frame - robotAttack) % 2 == 1 ){
      return Container();
    }

    return Image.asset('assets/images/banana.png');
  }

  Widget getLaser(){
    if(frame >= robotAttack + 3 && frame < robotAttack + 10){
      return Image.asset('assets/images/laser/${frame - robotAttack - 3}.png');
    }

    return Container();
  }
}