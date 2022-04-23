import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskio/application/todo/todoForm/todoform_bloc.dart';
import 'package:taskio/presentation/core/custom_button.dart';
import 'package:taskio/presentation/todo_detail/widgets/color_field.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        final themeData = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          child: Form(
            key: formKey,
            autovalidateMode: state.showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(
              children: [
                Text(
                  'Add Task',
                  style: themeData.textTheme.headline1!.copyWith(fontSize: 30),
                ),
                const SizedBox(height: 5),
                Text(
                  "Fill out the details below to add a new task.",
                  style: themeData.textTheme.headline1!.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 5),
                TextFormField(
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
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(
                  height: 20,
                ),
                ColorField(color: state.todo.color),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  buttonText: "Create Todo",
                  callback: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<TodoformBloc>(context)
                          .add(SafePressedEvent(body: body, title: title));
                    } else {
                      BlocProvider.of<TodoformBloc>(context)
                          .add(SafePressedEvent(body: null, title: null));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            "Invalid Input",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
