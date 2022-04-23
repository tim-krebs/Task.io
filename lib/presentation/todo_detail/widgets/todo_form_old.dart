import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskio/application/todo/todoForm/todoform_bloc.dart';
import 'package:taskio/presentation/todo_detail/widgets/ButtonCancel.dart';
import 'package:taskio/presentation/todo_detail/widgets/ButtonWidget.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final textEditingControllerTitle = TextEditingController();
    final textEditingControllerBody = TextEditingController();

    late String body;
    late String title;

    String? validateBody(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter a description";
      } else if (input.length < 300) {
        body = input;
        return null;
      } else {
        return "body too long";
      }
    }

    String? validateTitle(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter a title";
      } else if (input.length < 30) {
        title = input;
        return null;
      } else {
        return "title too long";
      }
    }

    return BlocConsumer<TodoformBloc, TodoformState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (context, state) {
        textEditingControllerTitle.text = state.todo.title;
        textEditingControllerBody.text = state.todo.body;
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 44, 12, 12),
              child: Form(
                key: formKey,
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
                          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.black,
                            size: 29,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(236, 239, 241, 1),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7,
                            color: Color.fromARGB(93, 112, 110, 110),
                            offset: Offset(0, -1),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 20, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Add Todo",
                                  style: themeData.textTheme.headline1,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Fill out the details below to add a new task.",
                                    style: themeData.textTheme.headline1!
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 2),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: TextFormField(
                              controller: textEditingControllerTitle,
                              cursorColor: const Color(0xff7ec9f5),
                              validator: validateTitle,
                              maxLength: 100,
                              maxLines: 2,
                              minLines: 1,
                              decoration: InputDecoration(
                                  labelText: "Todo Name",
                                  hintText: "Enter your todo here...",
                                  fillColor: Colors.white,
                                  counterText: "",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 16, 16, 0),
                            child: TextFormField(
                              controller: textEditingControllerBody,
                              cursorColor: const Color(0xff7ec9f5),
                              validator: validateBody,
                              maxLength: 300,
                              maxLines: 8,
                              minLines: 5,
                              decoration: InputDecoration(
                                  labelText: "Details",
                                  hintText: "Enter a description here...",
                                  counterText: "",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 16, 16, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ButtonCancel(
                                  buttonName: "Cancel",
                                  callback: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                                Button(
                                  buttonName: "Create Task",
                                  callback: () {
                                    print(body);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
