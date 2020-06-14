import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';

import './screens/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppStyles.buildAppTextTheme(),
      home: Home(),
    );
  }
}
