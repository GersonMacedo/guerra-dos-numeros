import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/utils.dart';

class Settings extends StatelessWidget {
  const Settings({super.key, required this.changePage});
  final void Function(Widget?) changePage;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(changePage),
            const SizedBox(height: 15),
            const Text("TODO: tela de configurações")
          ],
        )
    );
  }
}