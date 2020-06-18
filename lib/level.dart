
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
          child: Text("Glückwunsch, du hast Level 5 erreicht!"),
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
