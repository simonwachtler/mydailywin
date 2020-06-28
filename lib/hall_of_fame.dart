import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'animations.dart';
import 'data.dart';
import 'main.dart';
import 'util.dart';

class HallOfFame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entries = filterEntries(data.entries);
    return AnimatedListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 85),
          child: Text(
            "Ich schaffe das!",
            style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 7, bottom: 15.0),
          child: Text(
            entries.length == 0
                ? "Wir werden dir hier deine Erfolge anzeigen. Notiere sie täglich, um sie hier anzusehen."
                : "Ich habe schon so viel geschafft! \nIch werde auch diese Herausforderung meistern!",
            style: TextStyle(fontSize: 23.0),
          ),
        ),
        ...entries.entries
            .map((e) => DayWidget(entries: e.value, date: e.key))
            .toList(),
        SizedBox(height: 100),
      ],
    );
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
}

class DayWidget extends StatelessWidget {
  final List<Entry> entries;
  final DateTime date;

  const DayWidget({Key key, this.entries, this.date}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final success =
        entries.where((element) => element.type == EntryType.Success).fold(
      <String>[],
      (previousValue, element) => previousValue..addAll(element.contents),
    ).where((String c) => c.isNotEmpty);
    final grateful =
        entries.where((element) => element.type == EntryType.Grateful).fold(
      <String>[],
      (previousValue, element) => previousValue..addAll(element.contents),
    ).where((String c) => c.isNotEmpty);
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 5,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 23, right: 15, left: 15, bottom: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.MMMMd("de").format(date),
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 8),
              if (success.isNotEmpty)
                Text("Das habe ich geschafft:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              for (var s in success) Text(s),
              SizedBox(height: 8),
              if (grateful.isNotEmpty)
                Text("Dafür bin ich dankbar:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              for (var g in grateful) Text(g)
            ],
          ),
        ),
      ),
    );
  }
}
