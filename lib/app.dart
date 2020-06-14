import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import './res/res.dart';
import './screens/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppStyles.buildAppTextTheme(),
      home: Home(Connectivity().onConnectivityChanged),
    );
  }
}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) {
      return Center(
        child: Material(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.redAccent,
            child: Text(
              'No internet connection',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    },
  );

  void showOverlay(BuildContext context) {
    return Overlay.of(context).insert(overlayEntry);
  }

  void removeOverlay(BuildContext context) {
    overlayEntry.remove();
  }
}
