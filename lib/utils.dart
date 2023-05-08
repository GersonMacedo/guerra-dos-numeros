import 'package:flutter/material.dart';

Widget customIconButton(BuildContext context, Color buttonColor, Icon icon, String text, double textSize, Color textColor, double w, double h, Function() pressed){
  return SizedBox(
    width: w,
    height: h,
    child: ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
        child: Row(
          children: [
            icon,
            Text(text, style: TextStyle(fontSize: textSize, color: textColor))
          ],
        )
    ),
  );
}

Widget backButton(void Function(Widget?) changePage){
  return SizedBox(
    height: 30,
    width: 80,
    child: ElevatedButton(
      onPressed: (){changePage(null);},
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: 5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          Text("Voltar", style: TextStyle(color: Colors.black, fontSize: 18))
        ],
      )
    )
  );
}