import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:microblogging/design_system/theme.dart';

import 'mocks.dart';

MaterialApp defaultMaterialApp(Widget child) {
  return MaterialApp(
    theme: theme,
    home: child,
  );
}

Storage mockStorage() {
  final Storage storage = MockStorage();
  when<dynamic>(() => storage.read(any())).thenReturn(<String, dynamic>{});
  when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
  when(() => storage.delete(any())).thenAnswer((_) async {});
  when(storage.clear).thenAnswer((_) async {});
  return storage;
}
