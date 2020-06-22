import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'data.dart';
import 'main.dart';

class HallOfFame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Ich schaffe das!",
            style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 7, bottom: 15.0),
          child: Text(
            "Ich habe schon so viel geschafft! \nIch werde auch diese Herausforderung meistern!",
            style: TextStyle(fontSize: 23.0),
          ),
        ),
        ...filterEntries(entries)
            .entries
            .map((e) => DayWidget(entries: e.value, date: e.key))
            .toList(),
        SizedBox(height: 100),
      ]),
    );
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
