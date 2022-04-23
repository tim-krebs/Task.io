import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskio/application/todo/controller/controller_bloc.dart';
import 'package:taskio/domain/entities/todo.dart';
import 'package:taskio/presentation/routes/router.gr.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({Key? key, required this.todo}) : super(key: key);

  void _showDeleteDialog(
      {required BuildContext context, required ControllerBloc bloc}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Selected todo to delete:"),
            content: Text(
              todo.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  bloc.add(DeleteTodoEvent(todo: todo));
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
        onTap: () {
          // Navigate to Edit Todo Page
          AutoRouter.of(context).push(TodoDetailRoute(todo: todo));
        },
        onLongPress: () {
          final controllerbloc = context.read<ControllerBloc>();
          _showDeleteDialog(context: context, bloc: controllerbloc);
        },
        child: Material(
          elevation: 16,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: todo.color.color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.textTheme.headline1!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    todo.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            shape: const CircleBorder(),
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                            value: todo.done,
                            onChanged: (value) {
                              if (value != null) {
                                BlocProvider.of<ControllerBloc>(context).add(
                                    UpdateTodoEvent(todo: todo, done: value));
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
