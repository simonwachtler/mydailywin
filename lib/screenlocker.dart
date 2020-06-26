import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'main.dart';

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
  ScreenlockerState createState() => ScreenlockerState();
}

class ScreenlockerState extends State<Screenlocker>
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

  /// Locks the screen by pushing a route and attempts to unlock with biometrics.
  ///
  /// If screen locking is disabled this is a no-op.
  void tryUnlock() async {
    if (unlockInProgress || !(await firstData).screenlockerEnabled) return;
    unlockInProgress = true;
    Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: screenlockerRouteName),
        builder: (context) {
          return WillPopScope(
            child: widget.lockscreenBuilder(context, _doUnlock),
            onWillPop: () async {
              SystemNavigator.pop();
              return false;
            },
          );
        },
      ),
    );
    _doUnlock();

    unlockInProgress = false;
  }

  void _doUnlock() async {
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
