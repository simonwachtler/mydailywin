import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_daily_win/new_camera_entry.dart';

import 'animations.dart';
import 'data.dart';
import 'new_entry.dart';

typedef EditingConpleteCallback = void Function(Entry replacement);

class EditEntry extends StatefulWidget {
  final Entry entry;
  final VoidCallback onDelete;
  final EditingConpleteCallback onReplace;

  const EditEntry({Key key, this.entry, this.onDelete, this.onReplace})
      : super(key: key);

  @override
  _EditEntryState createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  List<TextEditingController> _successControllers;
  List<TextEditingController> _gratefulControllers;
  List<ImageEntry> imageEntries;

  @override
  void initState() {
    _successControllers = widget.entry.success
        .map((e) => TextEditingController(text: e))
        .toList();
    _gratefulControllers = widget.entry.grateful
        .map((e) => TextEditingController(text: e))
        .toList();
    imageEntries = widget.entry.images?.toList() ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 90, left: 13),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Eintrag vom\n" +
                        DateFormat.MEd("de").format(widget.entry.date) +
                        " bearbeiten",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    if (await showConfirmationDialog(
                      context,
                      title: "Eintrag löschen?",
                      content: "Der gesamte Eintrag wird gelöscht",
                      confirmation: "Löschen",
                    )) {
                      widget.onDelete();
                      Navigator.pop(context);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    if (await showConfirmationDialog(
                      context,
                      title: "Bearbeiten abbrechen?",
                      content: "Deine Änderungen gehen verloren",
                      confirmation: "Änderungen verwerfen",
                    )) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            key: ValueKey("title - Erfolge"),
            padding: const EdgeInsets.only(top: 70, left: 13),
            child: Text(
              "Erfolge",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (var i = 0; i < _successControllers.length; i++)
            DeleteableTile(
              key: ValueKey(_successControllers[i]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _successControllers[i],
                  decoration: InputDecoration(
                    labelText: "${i + 1}.",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              onDeleted: () {
                setState(() {
                  _successControllers.removeAt(i);
                });
              },
            ),
          IconButton(
            key: ValueKey("add - success"),
            icon: Icon(Icons.add),
            onPressed: () => setState(
                () => _successControllers.add(TextEditingController())),
          ),
          Padding(
            key: ValueKey("title - Dankbarkeitsnotizen"),
            padding: const EdgeInsets.only(top: 70, left: 13),
            child: Text(
              "Dankbarkeitsnotizen",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (var i = 0; i < _gratefulControllers.length; i++)
            DeleteableTile(
              key: ValueKey(_gratefulControllers[i]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _gratefulControllers[i],
                  decoration: InputDecoration(
                    labelText: "${i + 1}.",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              onDeleted: () {
                setState(() {
                  _gratefulControllers.removeAt(i);
                });
              },
            ),
          IconButton(
            key: ValueKey("add - grateful"),
            icon: Icon(Icons.add),
            onPressed: () => setState(
                () => _gratefulControllers.add(TextEditingController())),
          ),
          Padding(
            key: ValueKey("title - Kameranotizen"),
            padding: const EdgeInsets.only(top: 70, left: 13),
            child: Text(
              "Kameranotizen",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (final image in imageEntries)
            Deleteable(
              key: ValueKey(image.path),
              builder: (context, onDelete) => Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                              "${image.length} ${image.length == 1 ? "Eintrag" : "Einträge"}",
                              style: Theme.of(context).textTheme.subtitle1),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              final result = await showLengthDialog(context);
                              if (result != null) {
                                setState(() {
                                  image.length = result;
                                });
                              }
                            },
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await onDelete();
                              setState(() {
                                imageEntries.remove(image);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Image.file(File(image.path)),
                  ],
                ),
              ),
            ),
          IconButton(
            key: ValueKey("add - image"),
            icon: Icon(Icons.add),
            onPressed: () async {
              final imageEntry = await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => NewCameraEntry()),
              );
              if (imageEntry != null) {
                setState(() {
                  imageEntries.add(imageEntry);
                });
              }
            },
          ),
          Padding(
            key: ValueKey("save"),
            padding: const EdgeInsets.all(18),
            child: RaisedButton(
              color: Colors.blue,
              elevation: 10,
              child: Text(
                "Speichern",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                final success = _successControllers
                    .map((c) => c.text)
                    .where((t) => t.isNotEmpty)
                    .toList();
                final grateful = _gratefulControllers
                    .map((c) => c.text)
                    .where((t) => t.isNotEmpty)
                    .toList();

                final entry =
                    Entry(widget.entry.date, success, grateful, imageEntries);
                if (entry.grateful.isEmpty &&
                    entry.success.isEmpty &&
                    entry.images.isEmpty) {
                  widget.onDelete();
                } else {
                  widget.onReplace(entry);
                }
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> showConfirmationDialog(BuildContext context,
    {String title, String content, String confirmation}) {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : null,
        actions: <Widget>[
          FlatButton(
            child: Text('Abbrechen'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: Text(confirmation),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
