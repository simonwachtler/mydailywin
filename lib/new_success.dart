import 'package:flutter/material.dart';

import 'data.dart';
import 'main.dart';

class NewSuccess extends StatelessWidget {
  final String text;
  final bool morningRoutine;
  final EntryType type;

  const NewSuccess({Key key, this.text, this.morningRoutine = false, this.type})
      : super(key: key);
  String getText() {
    switch (type) {
      case EntryType.Success:
        return "Was ist dir gestern gut gelungen – Erfolge, Anerkennung:";
      case EntryType.Grateful:
        return "Wofür bist Du dankbar?";
      default:
        throw Error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 90, left: 13),
                child: Text(
                  'Guten Tag, $name!',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Abadi',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 13),
            child: Text(
              getText(),
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Abadi',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          NewSuccessForm(
            confirmText: morningRoutine && type == EntryType.Success
                ? "Weiter"
                : "Fertig",
            onConfirm: (contents) async {
              entries.add(Entry(DateTime.now(), contents, type));
              writeEntries();
              if (morningRoutine && type == EntryType.Success) {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => NewSuccess(type: EntryType.Grateful)));
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
    );
  }
}

typedef void ConfirmationCallback(List<String> contents);

class NewSuccessForm extends StatefulWidget {
  final String confirmText;
  final ConfirmationCallback onConfirm;

  const NewSuccessForm({Key key, this.confirmText, this.onConfirm})
      : super(key: key);

  @override
  _NewSuccessFormState createState() => _NewSuccessFormState();
}

class _NewSuccessFormState extends State<NewSuccessForm> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers =
      List.generate(5, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Form(
          child: Column(
            children: <Widget>[
              for (var i = 0; i < controllers.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controllers[i],
                          decoration: InputDecoration(
                            labelText: "${i + 1}.",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            controllers.removeAt(i);
                          });
                        },
                      )
                    ],
                  ),
                ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () =>
                    setState(() => controllers.add(TextEditingController())),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text(
                  widget.confirmText,
                ),
                onPressed: controllers.any((c) => c.text.isNotEmpty)
                    ? () {
                        final contents = controllers
                            .map((c) => c.text)
                            .where((t) => t.isNotEmpty)
                            .toList();

                        widget.onConfirm(contents);
                      }
                    : null,
              )
            ],
          ),
          key: _formKey),
    );
  }
}
