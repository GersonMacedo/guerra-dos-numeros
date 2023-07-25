import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/imagesLoader.dart';

// TODO: toda a pagina de ranking

class Ranking extends StatelessWidget {
  const Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    ImagesLoader images = ImagesLoader(false, false, false, false);

    double width =
    MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
        ? 960
        : 540;
    double height =
    MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
        ? 540
        : 960;

    if (MediaQuery.of(context).size.width / width >
        MediaQuery.of(context).size.height / height) {
      width =
          MediaQuery.of(context).size.width * height / MediaQuery.of(context).size.height;
    }

    return Container(
      padding: const EdgeInsets.only(left:60, right: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "RANKING",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                width: 93,
                height: 96,
                child: images.trophy,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
