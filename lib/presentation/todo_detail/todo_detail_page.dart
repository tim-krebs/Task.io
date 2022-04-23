import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskio/application/todo/todoForm/todoform_bloc.dart';
import 'package:taskio/domain/entities/todo.dart';
import 'package:taskio/injection.dart';
import 'package:taskio/presentation/routes/router.gr.dart';
import 'package:taskio/presentation/todo_detail/widgets/save_progress_overlay.dart';
import 'package:taskio/presentation/todo_detail/widgets/todo_form.dart';

class TodoDetail extends StatelessWidget {
  final Todo? todo;
  const TodoDetail({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<TodoformBloc>()..add(InitializeTodoDetailPage(todo: todo)),
      child: BlocConsumer<TodoformBloc, TodoformState>(
        listenWhen: (p, c) =>
            p.failureOrSuccessOption != c.failureOrSuccessOption,
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
              () {},
              (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
                  (failure) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("failure"),
                          backgroundColor: Colors.redAccent)),
                  (_) => Navigator.of(context).popUntil(
                      (route) => route.settings.name == HomePageRoute.name)));
        },
        builder: (context, state) {
          return Scaffold(
            //appBar: AppBar(
            //  centerTitle: true,
            //  title: Text(todo == null ? "Create Todo" : "Edit Todo"),
            //),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 12, 12),
                  child: Form(
                    autovalidateMode: state.showErrorMessages
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Theme.of(context).colorScheme.secondary,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.black,
                                size: 29,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const TodoForm(),
                SafeInProgressOverlay(isSaving: state.isSaving)
              ],
            ),
          );
        },
      ),
    );
  }
}
