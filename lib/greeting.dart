import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_daily_success/main.dart';

import 'data.dart';
import 'new_success.dart';

class Greeting extends StatelessWidget {
  const Greeting({
    Key key,
    this.switchToMutmacher,
  }) : super(key: key);

  final VoidCallback switchToMutmacher;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(55.0),
          child: Text(
            name?.isNotEmpty == true ? 'Guten Tag, $name!' : 'Guten Tag!',
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
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => NewSuccess(
                      type: EntryType.Success,
                      morningRoutine: true,
                    )));
          },
        ),
        GreetingBox(
          color: Colors.blue[200],
          child: Text("TÄGLICHE REFLEXION:\nPositive Stimmung!"),
        ),
        GreetingBox(
            color: Colors.pink[200],
            child: Text("SELBSTVERTRAUEN-BOOST:\nJa, ich schaffe es!"),
            onTap: switchToMutmacher),
      ],
    );
  }
}

DateTime toDate(DateTime time) {
  return DateTime(time.year, time.month, time.day);
}

Map<DateTime, List<Entry>> filterEntries(List<Entry> entries) {
  final map = Map<DateTime, List<Entry>>();
  for (var entry in entries) {
    final date = toDate(entry.date);
    if (map.containsKey(date)) {
      map[date].add(entry);
    } else {
      map[date] = [entry];
    }
  }
  return map;
}

class DayWidget extends StatelessWidget {
  final List<Entry> entries;
  final DateTime date;

  const DayWidget({Key key, this.entries, this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.MMMMd("de").format(date),
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 8),
            Text("Das habe ich geschafft:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: entries
                  .where((element) => element.type == EntryType.Success)
                  .map(
                    (e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: e.contents
                          .where((element) => element.isNotEmpty)
                          .map((c) => Text(c))
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 8),
            Text("Dafür bin ich dankbar:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: entries
                  .where((element) => element.type == EntryType.Grateful)
                  .map(
                    (e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: e.contents
                          .where((element) => element.isNotEmpty)
                          .map((c) => Text(c))
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
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
      padding: EdgeInsets.only(left: 65.0, top: 3.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(8.0)),
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
