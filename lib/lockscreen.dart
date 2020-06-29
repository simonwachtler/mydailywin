import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class LockScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const LockScreen({Key key, this.onRetry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "My Daily Win ist gesperrt",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text("Ensperren"),
                  onPressed: onRetry,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
