import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import 'screenlocker.dart';

import 'data.dart';

class NewCameraEntry extends StatefulWidget {
  final DateTime date;
  const NewCameraEntry({Key key, this.date}) : super(key: key);

  @override
  _NewCameraEntryState createState() => _NewCameraEntryState();
}

class _NewCameraEntryState extends State<NewCameraEntry> {
  File imageFile;

  @override
  void initState() {
    pickImage();
    super.initState();
  }

  void pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    if (file == null) {
      Navigator.pop(context);
    } else {
      setState(() {
        imageFile = File(file.path);
      });
      // remove the screen locker,
      // since it would be below the dialog
      context.findAncestorStateOfType<ScreenlockerState>().popLockscreen();

      // show the dialog
      final resultFuture = showLengthDialog(context, widget.date == null);

      // lock the screen again
      context.findAncestorStateOfType<ScreenlockerState>().tryUnlock();

      final result = await resultFuture;
      if (result != null) {
        Navigator.pop(
          context,
          Tuple2(
            ImageEntry(imageFile.path, result.item1),
            widget.date ?? result.item2,
          ),
        );
      } else {
        imageFile.delete();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kameranotiz'),
      ),
      body: Container(
        child: imageFile == null ? Container() : Image.file(imageFile),
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}

Future<Tuple2<int, DateTime>> showLengthDialog(
    BuildContext context, bool allowDateEdit) {
  return showDialog(
    context: context,
    builder: (context) => _LengthDialog(
      allowDateEdit: allowDateEdit,
    ),
  );
}

class _LengthDialog extends StatefulWidget {
  final bool allowDateEdit;

  const _LengthDialog({Key key, this.allowDateEdit}) : super(key: key);
  @override
  _LengthDialogState createState() => _LengthDialogState();
}

class _LengthDialogState extends State<_LengthDialog> {
  final _controller = TextEditingController();
  DateTime date = DateTime.now();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Text(
            "Wie viele Einträge sind das?",
            style: Theme.of(context).textTheme.headline6,
          ),
          TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: _controller,
            onChanged: (_) => setState(() {}),
          ),
          if (widget.allowDateEdit) ...[
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Datum:",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100))
                    .then((value) => {
                          if (value != null)
                            {
                              setState(() {
                                date = value;
                              })
                            }
                        });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        DateFormat.yMd("de").format(date),
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.edit),
                  )
                ],
              ),
            ),
          ]
        ],
        mainAxisSize: MainAxisSize.min,
      ),
      actions: [
        FlatButton(
          child: Text("Abbrechen"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Speichern"),
          onPressed: _controller.text.isNotEmpty &&
                  int.tryParse(_controller.text) != null
              ? () => Navigator.pop(
                  context, Tuple2(int.parse(_controller.text), date))
              : null,
        ),
      ],
    );
  }
}
