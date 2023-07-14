import 'package:flutter/material.dart';

class ImagesLoader{
  ImagesLoader(bool loadClouds, bool loadAttacks){
    for(int i = 0; i < 5; i++){
      hamburger.add(Image.asset('assets/images/defaultHamburger/$i.png', scale: 0.2));
      robot.add(Image.asset('assets/images/defaultRobot/$i.png', scale: 0.2));
    }

    stoppedHamburger = Image.asset('assets/images/stoppedHamburger.png', scale: 0.2);
    stoppedRobot = Image.asset('assets/images/stoppedRobot.png', scale: 0.2);

    //skins hamburger
    stoppedRobotHamburger = Image.asset('assets/images/skins/hamburger/robotHamburger/stoppedRobotHamburger.png', scale: 0.2);

    if(loadClouds){
      for(int i = 0; i < 16; i++){
        clouds.add(Image.asset('assets/images/clouds/${15 - i}.png', repeat: ImageRepeat.repeatX, scale: 0.2));
      }
    }

    if(loadAttacks){
      for(int i = 0; i < attackPath.length; i++){
        List<Image> attacks = [];
        for(int j = 0; j < attackFrames[i]; j++){
          attacks.add(Image.asset('assets/images/${attackPath[i]}/$j.png', scale: 0.2));
        }

        hamburgerAttacks.add(attacks);
      }

      for(int i = 0; i < 11; i++){
        robotAttack.add(Image.asset('assets/images/attackLaser/$i.png', scale: 0.2));
      }

      for(int i = 0; i < 10; i++){
        takingDamageHamburger.add(Image.asset('assets/images/takingDamageHamburger/$i.png', scale: 0.2));
        takingDamageRobot.add(Image.asset('assets/images/takingDamageRobot/$i.png', scale: 0.2));
      }

      for(int i = 0; i < 16; i++){
        grassMap.add(Image.asset('assets/images/grassMap/${15 - i}.png', repeat: ImageRepeat.repeatX, scale: 0.2));
      }

      // hamburger skins
      for(int i = 0; i < 5; i++){
        robotHamburger.add(Image.asset('assets/images/skins/hamburger/robotHamburger/default/$i.png', scale: 0.2));
      }

      for(int i = 0; i < 9; i++){
        robotHamburgerTakingDamage.add(Image.asset('assets/images/skins/hamburger/robotHamburger/takingDamage/$i.png', scale: 0.2));
        robotHamburgerAttack.add(Image.asset('assets/images/skins/hamburger/robotHamburger/attackLaser/$i.png', scale: 0.2));
      }

    }
  }

  List<Image> hamburger = [];
  List<Image> robot = [];
  List<Image> clouds = [];
  List<Image> grassMap = [];
  List<List<Image>> hamburgerAttacks = [];
  List<Image> robotAttack = [];
  List<Image> takingDamageHamburger = [];
  List<Image> takingDamageRobot = [];
  late Image stoppedHamburger;
  late Image stoppedRobot;

  // hamburger skins
  List<Image> robotHamburger = [];

  // hamburger skins stopped
  late Image stoppedRobotHamburger;

  // hamburger skins attack
  List<Image> robotHamburgerAttack = [];

  // hamburger skins taking damage
  List<Image> robotHamburgerTakingDamage = [];

  List<double> heights = [0, 3, 5, 3, 0];
  List<String> attackPath = ["attackPinkBanana", "attackAppleBanana", "attackThrowBanana"];
  List<int> attackFrames = [8, 8, 6];

  void cacheImages(BuildContext context){
    for(var element in clouds){
      precacheImage(element.image, context);
    }

    for(var element in grassMap){
      precacheImage(element.image, context);
    }

    for(var element in hamburger){
      precacheImage(element.image, context);
    }

    for(var element in robot){
      precacheImage(element.image, context);
    }


    for(var attack in hamburgerAttacks){
      for(var element in attack){
        precacheImage(element.image, context);
      }
    }

    for(var element in robotAttack){
      precacheImage(element.image, context);
    }

    for(var element in takingDamageHamburger){
      precacheImage(element.image, context);
    }

    for(var element in takingDamageRobot){
      precacheImage(element.image, context);
    }

    // hamburger skins
    for(var element in robotHamburger){
      precacheImage(element.image, context);
    }

    for(var element in robotHamburgerAttack){
      precacheImage(element.image, context);
    }

    for(var element in robotHamburgerTakingDamage){
      precacheImage(element.image, context);
    }

  }
}