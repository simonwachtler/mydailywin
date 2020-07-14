import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'animations.dart';
import 'data.dart';
import 'edit_entry.dart';
import 'main.dart';

class HallOfFame extends StatefulWidget {
  @override
  _HallOfFameState createState() => _HallOfFameState();
}

class _HallOfFameState extends State<HallOfFame> {
  @override
  Widget build(BuildContext context) {
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
            data.entries.length == 0
                ? "Wir werden dir hier deine Erfolge anzeigen. Notiere sie täglich, um sie hier anzusehen."
                : "Ich habe schon so viel geschafft! \nIch werde auch diese Herausforderung meistern!",
            style: TextStyle(fontSize: 23.0),
          ),
        ),
        ...data.entries
            .map(
              (e) => DayWidget(
                entry: e,
                onDelete: () {
                  setState(() {
                    setData(() {
                      data.entries.remove(e);
                      // delete all image files from disk
                      e.images.forEach((image) {
                        File(image.path).delete();
                      });
                    });
                  });
                },
                onReplace: (newEntry) {
                  setState(
                    () {
                      setData(() {
                        final index = data.entries.indexOf(e);
                        data.entries[index] = newEntry;
                        // delete all deleted image's files from disk
                        e.images?.forEach((image) {
                          if (!newEntry.images
                              .any((i) => i.path == image.path)) {
                            File(image.path).delete();
                          }
                        });
                      });
                    },
                  );
                },
              ),
            )
            .toList(),
        SizedBox(height: 100),
      ],
    );
  }
}

class DayWidget extends StatelessWidget {
  final Entry entry;
  final VoidCallback onDelete;
  final EditingConpleteCallback onReplace;

  const DayWidget({Key key, this.entry, this.onDelete, this.onReplace})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 5,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 23, right: 15, left: 15, bottom: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      DateFormat.MMMMd("de").format(entry.date),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  if (onReplace != null && onDelete != null)
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => EditEntry(
                              entry: entry,
                              onDelete: onDelete,
                              onReplace: onReplace,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
              SizedBox(height: 8),
              if (entry.success.isNotEmpty)
                Text("Das habe ich geschafft:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              for (var s in entry.success) Text(s),
              SizedBox(height: 8),
              if (entry.grateful.isNotEmpty)
                Text("Dafür bin ich dankbar:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              for (var g in entry.grateful) Text(g),
              if (entry.images?.isNotEmpty == true) ...[
                Text("Meine Kameranotizen:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                for (var i in entry.images)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.file(File(i.path)),
                  )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
