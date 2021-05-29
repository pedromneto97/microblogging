// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:microblogging/main.dart';
import 'package:microblogging/models/post.dart';
import 'package:microblogging/models/user.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(PostAdapter());
    Intl.defaultLocale = 'pt_BR';
    await Future.wait([
      Hive.openBox<User>('users'),
      Hive.openBox<Post>('posts'),
      getTemporaryDirectory().then(
        (storage) => HydratedStorage.build(
          storageDirectory: storage,
        ).then(
          (hydrateStorage) => (HydratedBloc.storage = hydrateStorage),
        ),
      ),
      initializeDateFormatting(),
    ]);
  });
  testWidgets('App', (tester) async {
    await tester.pumpWidget(MyApp());
  });
}
