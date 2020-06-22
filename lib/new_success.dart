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
          Padding(
            padding: const EdgeInsets.only(top: 90, left: 13),
            child: Row(
              children: <Widget>[
                Text(
                  'Guten Tag, Michael!',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Abadi',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
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
            onConfirm: (contents) {
              entries.add(Entry(DateTime.now(), contents, type));
              writeEntries();
              if (morningRoutine && type == EntryType.Success) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => NewSuccess(type: EntryType.Grateful)));
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
  final textEditingController1 = TextEditingController(),
      textEditingController2 = TextEditingController(),
      textEditingController3 = TextEditingController(),
      textEditingController4 = TextEditingController(),
      textEditingController5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: textEditingController1,
                decoration: InputDecoration(
                    labelText: "1.", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: textEditingController2,
                decoration: InputDecoration(
                    labelText: "2.", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: textEditingController3,
                decoration: InputDecoration(
                    labelText: "3.", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: textEditingController4,
                decoration: InputDecoration(
                    labelText: "4.", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: textEditingController5,
                decoration: InputDecoration(
                    labelText: "5.", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text(
                  widget.confirmText,
                ),
                onPressed: () {
                  final contents = [
                    textEditingController1.text,
                    textEditingController2.text,
                    textEditingController3.text,
                    textEditingController4.text,
                    textEditingController5.text,
                  ];
                  print(contents);
                  widget.onConfirm(contents);
                },
              )
            ],
          ),
          key: _formKey),
    );
  }
}
