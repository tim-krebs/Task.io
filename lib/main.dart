import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskio/application/auth/authbloc/auth_bloc.dart';
import 'package:taskio/injection.dart' as di;
import 'package:taskio/injection.dart';
import 'package:taskio/theme.dart';

import 'presentation/routes/router.gr.dart' as r;

void main() async {
  // check no widgets build
  WidgetsFlutterBinding.ensureInitialized();
  // Init firebase
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = r.AppRouter();
  //const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(AuthChekRequestedEvent()),
        )
      ],
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        title: 'Task.io',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
