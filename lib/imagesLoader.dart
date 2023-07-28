import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/levels.dart';

class ImagesLoader{
  ImagesLoader(bool loadSkins, bool loadClouds, bool loadAttacks, bool loadStore){
    if(loadSkins){
      for(int i = 0; i < 5; i++){
        hamburger.add(Image.asset('assets/images/hamburger/default/${Levels.hamburgerType}_$i.png', scale: 0.2));
        robot.add(Image.asset('assets/images/robot/default/$i.png', scale: 0.2));
      }
    }

    if(loadStore){
      for(int i = 0; i < hamburgerSkins; i++){
        storeHamburger.add(Image.asset("assets/images/hamburger/store/$i.png", scale: 0.2));
      }
    }

    if(loadClouds){
      for(int i = 0; i < 16; i++){
        clouds.add(Image.asset('assets/images/clouds/${15 - i}.png', repeat: ImageRepeat.repeatX, scale: 0.2));
      }
    }

    if(loadAttacks){
      for(int i = 0; i < attacksTypes[Levels.hamburgerType]; i++){
        List<Image> attacks = [];
        for(int j = 0; j < attacksFrames[Levels.hamburgerType][i]; j++){
          attacks.add(Image.asset("assets/images/hamburger/attacks/${Levels.hamburgerType}_${i}_$j.png", scale: 0.2));
        }

        hamburgerAttacks.add(attacks);
      }

      for(int i = 0; i < 11; i++){
        robotAttack.add(Image.asset('assets/images/robot/attacks/$i.png', scale: 0.2));
      }

      for(int i = 0; i < 10; i++){
        takingDamageHamburger.add(Image.asset('assets/images/hamburger/takingDamage/${Levels.hamburgerType}_$i.png', scale: 0.2));
        takingDamageRobot.add(Image.asset('assets/images/robot/takingDamage/$i.png', scale: 0.2));
      }

      for(int i = 0; i < 16; i++){
        grassMap.add(Image.asset('assets/images/grassMap/${15 - i}.png', repeat: ImageRepeat.repeatX, scale: 0.2));
      }
    }

    // Other images
    trophy = Image.asset('assets/images/trophy.png', scale: 0.2);
    hamburgerDefeated = Image.asset('assets/images/hamburger/defeated/${Levels.hamburgerType}.png', scale: 0.2);
  }

  List<Image> hamburger = [];
  List<Image> robot = [];
  List<Image> clouds = [];
  List<Image> grassMap = [];
  List<List<Image>> hamburgerAttacks = [];
  List<Image> robotAttack = [];
  List<Image> takingDamageHamburger = [];
  List<Image> takingDamageRobot = [];
  List<Image> storeHamburger = [];
  Image hamburgerDefeated = Image.asset('assets/images/hamburger/defeated/${Levels.hamburgerType}.png', scale: 0.2);
  Image robotDefeated = Image.asset('assets/images/robot/defeated.png', scale: 0.2);

  int hamburgerSkins = 8;
  List<double> heights = [0, 3, 5, 3, 0];
  List<int> attacksTypes = [3, 1, 1, 1, 1, 1, 1, 1];
  List<List<int>> attacksFrames = [[10, 11, 8], [17], [10], [21], [21], [10], [14], [30]];

  late Image trophy;

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

    for(var element in storeHamburger){
      precacheImage(element.image, context);
    }
  }
}