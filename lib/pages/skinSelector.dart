import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';

class SkinSelector extends StatelessWidget {
  final void Function(int) callback;

  SkinSelector(this.callback);

  @override
  Widget build(BuildContext context) {
    ImagesLoader images = ImagesLoader(false, true);
    double width = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 960 : 540;
    double height = MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 540 : 960;

    if(MediaQuery.of(context).size.width / width > MediaQuery.of(context).size.height / height){
      width = MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        color: const Color(0xFF54436B),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                callback(0);
                Navigator.pop(context);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  width: width*0.3,
                  height: height*0.1,
                  margin: const EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: images.storeHamburger,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                callback(1);
                Navigator.pop(context);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  width: width * 0.3,
                  height: height * 0.1,
                  margin: const EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: images.storeRobotHamburger,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
