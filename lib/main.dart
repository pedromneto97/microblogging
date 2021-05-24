import 'package:flutter/material.dart';

import 'design_system/theme.dart';
import 'features/authentication/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seu blog',
      theme: theme,
      initialRoute: Home.screenName,
      routes: {
        Home.screenName: (context) => Home(),
      },
    );
  }
}
