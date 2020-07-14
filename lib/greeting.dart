import 'dart:io';

import 'package:flutter/material.dart';

import 'animations.dart';
import 'data.dart';
import 'hall_of_fame.dart';
import 'main.dart';
import 'new_entry.dart';

class Greeting extends StatefulWidget {
  const Greeting({
    Key key,
    this.switchToMutmacher,
  }) : super(key: key);

  final VoidCallback switchToMutmacher;

  @override
  _GreetingState createState() => _GreetingState();
}

class _GreetingState extends State<Greeting> {
  @override
  Widget build(BuildContext context) {
    final entry = data.entries.isNotEmpty ? data.entries.last : null;
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
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MorningRoutine(),
              ),
            );
            setState(() {});
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
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewSuccess(),
              ),
            );
            setState(() {});
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
          onTap: widget.switchToMutmacher,
        ),
        if (entry != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: DayWidget(
              entry: entry,
              // TODO: clean up: code duplication
              onDelete: () {
                setState(() {
                  setData(() {
                    data.entries.remove(entry);
                    // delete all image files from disk
                    entry.images.forEach((image) {
                      File(image.path).delete();
                    });
                  });
                });
              },
              onReplace: (newEntry) {
                setState(
                  () {
                    setData(() {
                      final index = data.entries.indexOf(entry);
                      data.entries[index] = newEntry;
                      // delete all deleted image's files from disk
                      entry.images?.forEach((image) {
                        if (!newEntry.images.any((i) => i.path == image.path)) {
                          File(image.path).delete();
                        }
                      });
                    });
                  },
                );
              },
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
