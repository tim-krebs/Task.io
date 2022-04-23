import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskio/application/auth/authbloc/auth_bloc.dart';
import 'package:taskio/application/todo/controller/controller_bloc.dart';
import 'package:taskio/application/todo/observer/observer_bloc.dart';
import 'package:taskio/core/Failures/todo_failures.dart';
import 'package:taskio/injection.dart';
import 'package:taskio/presentation/home/widgets/home_body.dart';
import 'package:taskio/presentation/routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  String _mapFailureToMessage(TodoFailure todoFailure) {
    switch (todoFailure.runtimeType) {
      case InsufficientPermisssons:
        return "You have no permissions";
      case UnexpectedFailure:
        return "Something went wrong";

      default:
        return "Something went wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    final observerBloc = sl<ObserverBloc>()..add(ObserveAllEvent());
    return MultiBlocProvider(
      providers: [
        BlocProvider<ObserverBloc>(
          create: (context) => observerBloc,
        ),
        BlocProvider<ControllerBloc>(
          create: (context) => sl<ControllerBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthStateUnauthenticated) {
              AutoRouter.of(context).push(const SignUpPageRoute());
            }
          }),
          BlocListener<ControllerBloc, ControllerState>(
              listener: (context, state) {
            if (state is ControllerFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(_mapFailureToMessage(state.todoFailure))));
            }
          })
        ],
        child: Scaffold(
          body: const HomeBody(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              AutoRouter.of(context).push(TodoDetailRoute(todo: null));
            },
            child: const Icon(
              Icons.add,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
