import 'package:flutter/material.dart';
import 'package:guerra_dos_numeros/pages/customLevelSelector.dart';
import 'package:guerra_dos_numeros/pages/levelSelector.dart';

class ModeSelector extends StatefulWidget {
  const ModeSelector(this.changePage, {super.key});
  final void Function(Widget?, {bool bottom, bool back, bool keep}) changePage;

  @override
  State<ModeSelector> createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<ModeSelector>{
  bool numericMode = true;
  
  void setMode(bool mode){
    setState(() {
      numericMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("escolha um modo", style: TextStyle(color: Colors.white, fontSize: 38)),
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0x20D9D9D9),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 220,
                      alignment: Alignment.center,
                      color: Color(0x00D9D9D9 + (numericMode ? 0x20000000 : 0)),
                      child: TextButton(
                        onPressed: () => setMode(true),
                        child: Container(
                          width: 200,
                          alignment: Alignment.center,
                          child: const Text("numérico", style: TextStyle(color: Colors.white, fontSize: 38))
                        ),
                      )
                    ),
                    Container(
                      width: 160,
                      alignment: Alignment.center,
                      color: Color(0x20D9D9D9 - (numericMode ? 0x20000000 : 0)),
                      child: TextButton(
                        onPressed: () => setMode(false),
                        child: Container(
                          width: 140,
                          alignment: Alignment.center,
                          child: const Text("texto", style: TextStyle(color: Colors.white, fontSize: 38))
                        ),
                      ),
                    )
                  ]
                )
              )
            ]
          )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () => widget.changePage(LevelSelector(widget.changePage, 0), keep: true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: Container(
                width: 400,
                height: 70,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFF212A3E),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      width: 50,
                      height: 50
                    ),
                    const Text("      adição e subtração", style: TextStyle(fontSize: 30, color: Colors.black))
                  ],
                )
              )
            ),
            const SizedBox(height: 20, width: double.infinity),
            ElevatedButton(
                onPressed: () => widget.changePage(LevelSelector(widget.changePage, 1), keep: true),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                child: Container(
                    width: 400,
                    height: 70,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF212A3E),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          width: 50,
                          height: 50
                        ),
                        const Text("      multiplicação e divisão", style: TextStyle(fontSize: 30, color: Colors.black))
                      ],
                    )
                )
            ),
            const SizedBox(height: 20, width: double.infinity),
            ElevatedButton(
                onPressed: () => widget.changePage(CustomLevelSelector(widget.changePage), keep: true),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                child: Container(
                    width: 400,
                    height: 70,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF212A3E),
                            borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          width: 50,
                          height: 50
                        ),
                        const Text("      aleatório", style: TextStyle(fontSize: 30, color: Colors.black))
                      ],
                    )
                )
            ),
          ]
        ),
        Container()
      ]
    );
  }
}