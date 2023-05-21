import 'package:flutter/material.dart';

class CongratulationsFrame extends StatelessWidget {
  const CongratulationsFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 115 : 175,
      child: const Text("Parabéns voce terminou!!!", style: TextStyle(fontSize: 40,color: Colors.black)),
    );
  }
}