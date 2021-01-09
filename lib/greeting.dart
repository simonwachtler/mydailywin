import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animations.dart';
import 'data.dart';
import 'hall_of_fame.dart';
import 'new_entry.dart';

class Greeting extends StatelessWidget {
  const Greeting({
    Key key,
    this.switchToMutmacher,
  }) : super(key: key);

  final VoidCallback switchToMutmacher;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DataModel>();
    return AnimatedListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(55.0),
          child: Text(
            model.name?.isNotEmpty == true
                ? 'Guten Tag, ${model.name}!'
                : 'Guten Tag!',
            style: TextStyle(
              fontSize: 38.0,
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
                "TÄGLICHE ROUTINE: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Halte täglich deine Erfolge fest!"),
            ],
          ),
          onTap: () async {
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
                "NEUES LEVEL ERREICHEN:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("Jetzt neuen Erfolg notieren"),
            ],
          ),
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewSuccess(),
              ),
            );
          },
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
        if (model.entries.length != 0)
          Padding(
            padding: const EdgeInsets.only(top: 19.0),
            child: DayWidget(
              index: 0,
            ),
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
        clipBehavior: Clip.hardEdge,
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
