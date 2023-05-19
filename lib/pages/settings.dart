import 'package:flutter/material.dart';

//TODO: toda a pagina de configurações

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 15),
            Text("TODO: tela de configurações")
          ],
        )
    );
  }
}