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

bool onVertical(BuildContext context){
  return MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;
}