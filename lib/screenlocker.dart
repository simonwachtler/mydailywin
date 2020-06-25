import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';

class Screenlocker extends StatefulWidget {
  final Widget child;
  final Widget lockScreen;

  const Screenlocker({Key key, this.child, this.lockScreen}) : super(key: key);
  @override
  _ScreenlockerState createState() => _ScreenlockerState();
}

class _ScreenlockerState extends State<Screenlocker>
    with WidgetsBindingObserver {
  bool isLocked = true;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      isLocked = await isScreenlockerEnabled();
      if (isLocked) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WillPopScope(
              child: widget.lockScreen,
              onWillPop: () async => false,
            ),
          ),
        );
      }
    } else if (state == AppLifecycleState.resumed) {
      if (isLocked) {
        final localAuth = LocalAuthentication();
        isLocked = !await localAuth.authenticateWithBiometrics(
            localizedReason: "Zum Entsperren bestätigen");
        if (!isLocked) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    isScreenlockerEnabled().then((value) async {
      if (value) {
        final localAuth = LocalAuthentication();
        isLocked = !await localAuth.authenticateWithBiometrics(
            localizedReason: "Zum Entsperren bestätigen");
        setState(() {});
      } else {
        setState(() {
          isLocked = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLocked ? widget.lockScreen : widget.child;
  }
}

Future<File> getScreenlockFile() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  return File("${documentsDirectory.path}/screenlockenabled");
}

Future<bool> isScreenlockerEnabled() async {
  return await (await getScreenlockFile()).exists();
}
