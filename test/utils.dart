import 'package:flutter/material.dart';
import 'package:microblogging/design_system/theme.dart';

MaterialApp defaultMaterialApp(Widget child) {
  return MaterialApp(
    theme: theme,
    home: child,
  );
}
