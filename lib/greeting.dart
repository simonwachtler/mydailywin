
import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  const Greeting({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(55.0),
          child: Text(
            'Guten Tag, Michael!',
            style: TextStyle(
                fontSize: 38.0,
                fontFamily: 'Abadi',
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print("isRecording");
          },
          child: Padding(
            padding: EdgeInsets.only(left: 65.0, top: 3.0),
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text("MORGEN-ROUTINE: \nPerfekt in den Tag starten!"),
              ),
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print("isRecording");
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 65.0,
              top: 15.0,
            ),
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text("TÄGLICHE REFLEXION:\nPositive Stimmung!"),
              ),
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print("isRecording");
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 65.0,
              top: 18.0,
            ),
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.pink[200],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Text("SELBSTVERTRAUEN-BOOST: \nJa, ich schaffe es!"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
