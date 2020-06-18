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
              color: Colors.grey,
            ),
          ),
        ),
        GreetingBox(
          color: Colors.green[300],
          child: Text("MORGEN-ROUTINE:\nPerfekt in den Tag starten!"),
        ),
        GreetingBox(
          color: Colors.blue[200],
          child: Text("TÄGLICHE REFLEXION:\nPositive Stimmung!"),
        ),
        GreetingBox(
          color: Colors.pink[200],
          child: Text("SELBSTVERTRAUEN-BOOST:\nJa, ich schaffe es!"),
        ),
      ],
    );
  }
}

class GreetingBox extends StatelessWidget {
  const GreetingBox({
    Key key,
    @required this.color,
    @required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 65.0, top: 3.0),
      child: Container(
        decoration: new BoxDecoration(
          color: color,
          borderRadius: BorderRadius.horizontal(left: Radius.circular(8.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: child,
        ),
      ),
    );
  }
}
