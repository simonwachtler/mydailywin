import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';

typedef LockscreenBuilder = Widget Function(
  BuildContext context,
  VoidCallback onRetry,
);

const screenlockerRouteName = "screenlocker";

class Screenlocker extends StatefulWidget {
  final Widget child;
  final LockscreenBuilder lockscreenBuilder;

  const Screenlocker({Key key, this.child, this.lockscreenBuilder})
      : super(key: key);
  @override
  _ScreenlockerState createState() => _ScreenlockerState();
}

class _ScreenlockerState extends State<Screenlocker>
    with WidgetsBindingObserver {
  bool unlockInProgress = false;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      tryUnlock();
    }
  }

  @override
  void initState() {
    tryUnlock();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void tryUnlock() async {
    if (unlockInProgress || !await isScreenlockerEnabled()) return;
    unlockInProgress = true;
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: screenlockerRouteName),
        builder: (context) {
          return WillPopScope(
            child: widget.lockscreenBuilder(context, doUnlock),
            onWillPop: () async {
              SystemNavigator.pop();
              return false;
            },
          );
        },
      ),
    );
    doUnlock();

    unlockInProgress = false;
  }

  void doUnlock() async {
    if (await LocalAuthentication().authenticateWithBiometrics(
        localizedReason: "Zum Entsperren bestätigen")) {
      Navigator.of(context)
          .popUntil((route) => route.settings.name != screenlockerRouteName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

Future<File> getScreenlockFile() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  return File("${documentsDirectory.path}/screenlockenabled");
}

Future<bool> isScreenlockerEnabled() async {
  return await (await getScreenlockFile()).exists();
}
