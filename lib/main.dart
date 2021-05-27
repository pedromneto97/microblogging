import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/authentication/authentication/authentication_bloc.dart';
import 'design_system/theme.dart';
import 'features/authentication/login/login.dart';
import 'features/authentication/register/register.dart';
import 'features/bottom_tab/bottom_tab_container.dart';
import 'models/post.dart';
import 'models/user.dart';
import 'repository/authentication_repository.dart';
import 'utils/bloc_observer.dart';
import 'utils/populate.dart';

void main() async {
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

  populateStorage();

  if (kDebugMode) Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(
        box: Hive.box<User>('users'),
      ),
      lazy: false,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context),
        ),
        lazy: false,
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) => MaterialApp(
            title: 'Seu blog',
            theme: theme,
            initialRoute: state is AuthenticationSuccessState
                ? BottomTabContainer.screenName
                : Login.screenName,
            routes: {
              Login.screenName: (context) => const Login(),
              Register.screenName: (context) => const Register(),
              BottomTabContainer.screenName: (context) =>
                  const BottomTabContainer(),
            },
          ),
        ),
      ),
    );
  }
}
