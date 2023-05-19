import 'package:flutter/material.dart';

class ImagesLoader{
  ImagesLoader(bool loadClouds, bool loadAttacks){
    for(int i = 0; i < 5; i++){
      hamburger.add(Image.asset('assets/images/hamburgerJumping/$i.png', scale: 0.2));
      robot.add(Image.asset('assets/images/movingRobot/$i.png', scale: 0.2));
    }

    banana = Image.asset('assets/images/banana.png', scale: 0.2);

    if(loadClouds){
      for(int i = 0; i < 16; i++){
        clouds.add(Image.asset('assets/images/clouds/${15 - i}.png', repeat: ImageRepeat.repeatX, scale: 0.2));
      }
    }

    if(loadAttacks){
      for(int i = 0; i < attackPath.length; i++){
        List<Image> attacks = [];
        for(int j = 0; j < attackFrames[i]; j++){
          attacks.add(Image.asset('assets/images/${attackPath[i]}/$j.png'));
        }

        hamburgerAttacks.add(attacks);
      }

      for(int i = 0; i < 7; i++){
        robotAttack.add(Image.asset('assets/images/laser/$i.png'));
      }

      for(int i = 0; i < 5; i++){
        hittingHamburger.add(Image.asset('assets/images/hittingHamburger/$i.png', scale: 0.2));
        hittingRobot.add(Image.asset('assets/images/hittingRobot/$i.png', scale: 0.2));
      }
    }
  }

  List<Image> hamburger = [];
  List<Image> robot = [];
  List<Image> clouds = [];
  List<List<Image>> hamburgerAttacks = [];
  List<Image> robotAttack = [];
  List<Image> hittingHamburger = [];
  List<Image> hittingRobot = [];
  late Image banana;

  List<double> heights = [0, 3, 5, 3, 0];
  List<String> attackPath = ["pinkBananaAttack", "appleBananaAttack", "throwBananaAttack"];
  List<int> attackDelay = [4, 5, 6];
  List<int> attackFrames = [8, 8, 6];

  void cacheImages(BuildContext context){
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

    for(var attack in hamburgerAttacks){
      for(var element in attack){
        precacheImage(element.image, context);
      }
    }

    for(var element in robotAttack){
      precacheImage(element.image, context);
    }

    for(var element in hittingHamburger){
      precacheImage(element.image, context);
    }

    for(var element in hittingRobot){
      precacheImage(element.image, context);
    }
  }
}