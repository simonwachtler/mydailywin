import 'package:flutter/material.dart';

class Level extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Text(
            'Guten Tag, Michael!',
            style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Abadi',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: PercentageWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            "Glückwunsch, du hast Level 5 erreicht!",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 54, left: 20),
          child: Text(
            "So startest du durch:",
            style: TextStyle(fontSize: 26, fontFamily: "Abadi"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 55),
          child: Text(
            "+5 pro Erfolgseintrag \n+5 pro Dankbarkeitseintrag\n+50 pro gesamte Morgenroutine",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ]),
    );
  }
}

class PercentageWidget extends StatelessWidget {
  const PercentageWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 0.75,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 10),
                shape: BoxShape.circle),
            width: 250,
            height: 250,
            child: Center(
              child: Text("60 %",
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'Abadi',
                    fontWeight: FontWeight.bold,
                  )),
            )),
      ),
    );
  }
}
