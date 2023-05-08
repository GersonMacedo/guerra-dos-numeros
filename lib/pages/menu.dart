import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/pages/about.dart';
import 'package:guerra_dos_numeros/pages/achievements.dart';
import 'package:guerra_dos_numeros/pages/levelSelector.dart';
import 'package:guerra_dos_numeros/pages/settings.dart';
import 'package:guerra_dos_numeros/utils.dart';

class Menu extends StatelessWidget  {
  const Menu({super.key, required this.changePage, required this.vertical});
  final void Function(Widget?) changePage;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    double buttonsWidth = vertical ? 300 : 220;
    double buttonsHeiht = vertical ? 70 : 50;
    double fontSize = vertical ? 30 : 22;
    List<Widget> buttons = [
      customIconButton(context, Colors.green, const Icon(Icons.play_circle), " Jogar", fontSize, Colors.white, buttonsWidth, buttonsHeiht,
              (){changePage(LevelSelector(changePage: changePage, vertical: vertical));}),
      customIconButton(context, Colors.green, const Icon(Icons.emoji_events), " Configurações", fontSize, Colors.white, buttonsWidth, buttonsHeiht,
              (){changePage(Settings(changePage: changePage, vertical: vertical));}),
      customIconButton(context, Colors.green, const Icon(Icons.settings), " Conquistas", fontSize, Colors.white, buttonsWidth, buttonsHeiht,
              (){changePage(Achievements(changePage: changePage, vertical: vertical));}),
      customIconButton(context, Colors.green, const Icon(Icons.info_outline), " Sobre", fontSize, Colors.white, buttonsWidth, buttonsHeiht,
              (){changePage(About(changePage: changePage, vertical: vertical));}),
    ];

    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
                "Guerra dos números, Robôs e coisas matemáticas",
                style: TextStyle(fontSize: 40, color: Colors.white)
            ),
            Image.asset('assets/images/main.png'),
            vertical
            ? SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: buttons,
                )
              )
            : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons,
            )
          ],
        )
    );
  }
}