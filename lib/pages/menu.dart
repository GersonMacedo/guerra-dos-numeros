import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/pages/about.dart';
import 'package:guerra_dos_numeros/pages/achievements.dart';
import 'package:guerra_dos_numeros/pages/levelSelector.dart';
import 'package:guerra_dos_numeros/pages/settings.dart';
import 'package:guerra_dos_numeros/utils.dart';

class Menu extends StatelessWidget{
  const Menu({super.key, required this.changePage});
  final void Function(Widget?) changePage;

  @override
  Widget build(BuildContext context){
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Guerra dos números, Robôs e coisas matemáticas",
              style: TextStyle(fontSize: 40, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Image.asset('assets/images/main.png', fit: BoxFit.contain),
            MenuButtons(changePage: changePage)
          ],
        )
    );
  }
}

class MenuButtons extends StatelessWidget{
  const MenuButtons({super.key, required this.changePage});
  final void Function(Widget?) changePage;

  @override
  Widget build(BuildContext context) {
    bool vertical = onVertical(context);
    double buttonsWidth = vertical ? 300 : 220;
    double buttonsHeight = vertical ? 70 : 50;
    double fontSize = vertical ? 30 : 22;
    List<Widget> buttons = [
      customIconButton(context, Colors.green, const Icon(Icons.play_circle), " Jogar", fontSize, Colors.white, buttonsWidth, buttonsHeight,
              (){changePage(LevelSelector(changePage: changePage));}),
      customIconButton(context, Colors.green, const Icon(Icons.emoji_events), " Configurações", fontSize, Colors.white, buttonsWidth, buttonsHeight,
              (){changePage(Settings(changePage: changePage));}),
      customIconButton(context, Colors.green, const Icon(Icons.settings), " Conquistas", fontSize, Colors.white, buttonsWidth, buttonsHeight,
              (){changePage(Achievements(changePage: changePage));}),
      customIconButton(context, Colors.green, const Icon(Icons.info_outline), " Sobre", fontSize, Colors.white, buttonsWidth, buttonsHeight,
              (){changePage(About(changePage: changePage));}),
    ];

    if(vertical){
      return SizedBox(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons,
    );
  }
}