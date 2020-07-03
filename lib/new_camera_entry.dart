import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'screenlocker.dart';

import 'data.dart';

class NewCameraEntry extends StatefulWidget {
  const NewCameraEntry({Key key}) : super(key: key);

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
      final resultFuture = showLengthDialog(context);

      // lock the screen again
      context.findAncestorStateOfType<ScreenlockerState>().tryUnlock();

      final result = await resultFuture;
      if (result != null) {
        Navigator.pop(context, ImageEntry(imageFile.path, result));
      } else {
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

Future<int> showLengthDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => LengthDialog(),
  );
}

class LengthDialog extends StatefulWidget {
  @override
  _LengthDialogState createState() => _LengthDialogState();
}

class _LengthDialogState extends State<LengthDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Wie viele Einträge sind das?"),
      content: TextField(
        autofocus: true,
        keyboardType: TextInputType.number,
        controller: _controller,
        onChanged: (_) => setState(() {}),
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
              ? () => Navigator.pop(context, int.parse(_controller.text))
              : null,
        ),
      ],
    );
  }
}
