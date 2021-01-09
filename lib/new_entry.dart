import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animations.dart';
import 'data.dart';

class NewSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _NewEntry(
      text: "Was ist dir gestern gut gelungen – Erfolge, Anerkennung:",
      confirmText: "Fertig",
      onConfirm: (contents) {
        context.read<DataModel>().addSuccess(contents);
        Navigator.pop(context);
      },
    );
  }
}

class NewGrateful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _NewEntry(
      text: "Wofür bist Du dankbar?",
      confirmText: "Fertig",
      onConfirm: (contents) {
        context.read<DataModel>().addGrateful(contents);
        Navigator.pop(context);
      },
    );
  }
}

class MorningRoutine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _NewEntry(
      text:
          "Guten Morgen!\nWas ist dir gestern gut gelungen – Erfolge, Anerkennung:",
      confirmText: "Weiter",
      onConfirm: (contents) async {
        context.read<DataModel>().addSuccess(contents);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (c) => NewGrateful(),
          ),
        );
      },
    );
  }
}

class _NewEntry extends StatelessWidget {
  final String text, confirmText;
  final ConfirmationCallback onConfirm;

  const _NewEntry({
    Key key,
    this.text,
    this.confirmText,
    this.onConfirm,
  }) : super(key: key);

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
                  'Guten Tag, ${context.watch<DataModel>().name}!',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Image.asset('assets/win-grey.png', width: 65),
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
              text,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _NewEntryForm(
            confirmText: confirmText,
            onConfirm: onConfirm,
          )
        ],
      ),
    );
  }
}

typedef ConfirmationCallback = void Function(List<String> contents);

class _NewEntryForm extends StatefulWidget {
  final String confirmText;
  final ConfirmationCallback onConfirm;

  const _NewEntryForm({Key key, this.confirmText, this.onConfirm})
      : super(key: key);

  @override
  _NewEntryFormState createState() => _NewEntryFormState();
}

class _NewEntryFormState extends State<_NewEntryForm> {
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
              DeleteableTile(
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
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: RaisedButton(
                color: Colors.blue,
                elevation: 10,
                child: Text(
                  widget.confirmText,
                  style: TextStyle(fontSize: 16),
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
              ),
            )
          ],
        ),
        key: _formKey,
      ),
    );
  }
}

class DeleteableTile extends StatelessWidget {
  final Widget child;
  final VoidCallback onDeleted;

  const DeleteableTile({Key key, this.onDeleted, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Deleteable(
      builder: (context, onDelete) => Row(
        children: [
          Expanded(child: child),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () async {
              await onDelete();
              onDeleted();
            },
          )
        ],
      ),
    );
  }
}

typedef DeleteableBuilder = Widget Function(
  BuildContext context,
  FutureVoidCallback onDelete,
);

typedef FutureVoidCallback = Future<void> Function();

class Deleteable extends StatefulWidget {
  final DeleteableBuilder builder;
  final Duration duration;

  const Deleteable(
      {Key key,
      this.builder,
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
    return SizeTransition(
      sizeFactor: _controller,
      child: widget.builder(context, () async {
        await _controller.animateTo(
          0,
          duration: widget.duration,
          curve: Curves.ease,
        );
      }),
      axisAlignment: 1,
    );
  }
}
