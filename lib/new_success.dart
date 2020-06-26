import 'package:flutter/material.dart';
import 'package:my_daily_success/animations.dart';

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
      body: AnimatedListView(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 90, left: 13),
                child: Text(
                  'Guten Tag, ${data.name}!',
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
              setData(() {
                data.entries.add(Entry(DateTime.now(), contents, type));
              });
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

typedef ConfirmationCallback = void Function(List<String> contents);

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
        child: AnimatedColumn(
          children: <Widget>[
            for (var i = 0; i < controllers.length; i++)
              Deleteable(
                key: ValueKey(controllers[i]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: controllers[i],
                    decoration: InputDecoration(
                      labelText: "${i + 1}.",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                onDeleted: () {
                  setState(() {
                    controllers.removeAt(i);
                  });
                },
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
        key: _formKey,
      ),
    );
  }
}

class Deleteable extends StatefulWidget {
  final Widget child;
  final VoidCallback onDeleted;
  final Duration duration;

  const Deleteable(
      {Key key,
      this.child,
      this.onDeleted,
      this.duration = const Duration(milliseconds: 500)})
      : super(key: key);
  @override
  _DeleteableState createState() => _DeleteableState();
}

class _DeleteableState extends State<Deleteable>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, value: 0);
    _controller.animateTo(
      1,
      duration: widget.duration,
      curve: Curves.ease,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Row(
      children: [
        Expanded(child: widget.child),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () async {
            await _controller.animateTo(
              0,
              duration: widget.duration,
              curve: Curves.ease,
            );
            widget.onDeleted();
          },
        )
      ],
    );
    return SizeTransition(
      sizeFactor: _controller,
      child: content,
      axisAlignment: 1,
    );
  }
}
