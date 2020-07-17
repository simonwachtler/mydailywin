import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import 'data.dart';

typedef LockscreenBuilder = Widget Function(
  BuildContext context,
  VoidCallback onRetry,
);

const screenlockerRouteName = "screenlocker";

DateTime lastInteraction;
bool isScreenLocked = false;

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
  bool wasLoading = true;

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
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    periodicalCheck();
  }

  @override
  void didChangeDependencies() {
    if (!context.read<DataModel>().loading && wasLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        tryUnlock();
      });
    }
    super.didChangeDependencies();
  }

  void periodicalCheck() {
    Future.delayed(Duration(seconds: 5), () {
      if (!isScreenLocked) tryUnlock();
      periodicalCheck();
    });
  }

  /// Locks the screen by pushing a route and attempts to unlock with biometrics.
  ///
  /// If screen locking is disabled or less than 30 seconds have passed since
  /// the last interaction this is a no-op.
  void tryUnlock() async {
    if (unlockInProgress ||
        (lastInteraction != null &&
            DateTime.now().difference(lastInteraction) <
                Duration(seconds: 30)) ||
        !context.read<DataModel>().screenlockerEnabled) {
      return;
    }
    unlockInProgress = true;
    if (!isScreenLocked) {
      isScreenLocked = true;
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
    }
    await _doUnlock();

    unlockInProgress = false;
  }

  Future<void> _doUnlock() async {
    if (await LocalAuthentication().authenticateWithBiometrics(
        localizedReason: "Zum Entsperren bestätigen")) {
      // unlocking counts as an interaction
      lastInteraction = DateTime.now();
      popLockscreen();
    }
  }

  /// Pop the current lockscreen
  ///
  /// This unlocks the app!
  void popLockscreen() {
    Navigator.of(context)
        .popUntil((route) => route.settings.name != screenlockerRouteName);
    isScreenLocked = false;
    unlockInProgress = false;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<DataModel>();
    return Listener(
      child: widget.child,
      onPointerDown: (_) {
        lastInteraction = DateTime.now();
      },
      onPointerMove: (_) {
        lastInteraction = DateTime.now();
      },
    );
  }
}
