import 'package:flutter/material.dart';
import 'package:my_daily_win/hall_of_fame.dart';
import 'package:my_daily_win/main.dart';

import 'animations.dart';
import 'new_entry.dart';

class Greeting extends StatelessWidget {
  const Greeting({
    Key key,
    this.switchToMutmacher,
  }) : super(key: key);

  final VoidCallback switchToMutmacher;

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(55.0),
          child: Text(
            data.name?.isNotEmpty == true
                ? 'Guten Tag, ${data.name}!'
                : 'Guten Tag!',
            style: TextStyle(
              fontSize: 38.0,
              fontFamily: 'Abadi',
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        GreetingBox(
          color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "MORGEN-ROUTINE: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Perfekt in den Tag starten!"),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MorningRoutine(),
              ),
            );
          },
        ),
        GreetingBox(
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "TÄGLICHE REFLEXION:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Positive Stimmung!"),
            ],
          ),
        ),
        GreetingBox(
          color: Colors.pink,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "SELBSTVERTRAUEN-BOOST:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Ja, ich schaffe es!"),
            ],
          ),
          onTap: switchToMutmacher,
        ),
        if (data.entries.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: DayWidget(entry: data.entries.last),
          ),
        SizedBox(
          height: 100,
        )
      ],
    );
  }
}

class GreetingBox extends StatelessWidget {
  const GreetingBox({
    Key key,
    @required this.color,
    @required this.child,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 65.0, bottom: 8.0),
      child: Material(
        elevation: 4,
        color:
            Color.lerp(color, Theme.of(context).scaffoldBackgroundColor, .300),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: child,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
