import 'package:flutter/material.dart';

class FightFrame extends StatelessWidget {
  const FightFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 410 : 510,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Image.asset('assets/images/sampleFight.png'),
    );
  }
}