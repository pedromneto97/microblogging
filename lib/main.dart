import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/authentication/authentication/authentication_bloc.dart';
import 'box/user_box.dart';
import 'design_system/theme.dart';
import 'features/authentication/login/login.dart';
import 'features/authentication/register/register.dart';
import 'features/feed/feed/feed.dart';
import 'repository/register_repository.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserBoxAdapter());
  await Hive.openBox<UserBox>('users');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(
        box: Hive.box<UserBox>('users'),
      ),
      lazy: false,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        ),
        lazy: false,
        child: MaterialApp(
          title: 'Seu blog',
          theme: theme,
          initialRoute: Login.screenName,
          routes: {
            Login.screenName: (context) => const Login(),
            Register.screenName: (context) => const Register(),
            Feed.screenName: (context) => const Feed(),
          },
        ),
      ),
    );
  }
}
