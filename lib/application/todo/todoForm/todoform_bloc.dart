import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:taskio/core/Failures/todo_failures.dart';
import 'package:taskio/domain/entities/todo.dart';
import 'package:taskio/domain/entities/todo_color.dart';
import 'package:taskio/domain/repositories/todo_repository.dart';

part 'todoform_event.dart';
part 'todoform_state.dart';

class TodoformBloc extends Bloc<TodoformEvent, TodoformState> {
  final TodoRepository todoRepository;
  TodoformBloc({required this.todoRepository})
      : super(TodoformState.initial()) {
    on<InitializeTodoDetailPage>((event, emit) {
      if (event.todo != null) {
        emit(state.copyWith(todo: event.todo, isEditing: true));
      } else {
        emit(state);
      }
    });

    on<SafePressedEvent>((event, emit) async {
      Either<TodoFailure, Unit>? failureOrSuccess;

      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

      if (event.title != null && event.body != null) {
        final Todo editedTodo =
            state.todo.copyWith(title: event.title, body: event.body);

        if (state.isEditing) {
          failureOrSuccess = await todoRepository.update(editedTodo);
        } else {
          failureOrSuccess = await todoRepository.create(editedTodo);
        }
      }

      emit(state.copyWith(
          isSaving: false,
          showErrorMessages: true,
          failureOrSuccessOption: optionOf(failureOrSuccess)));
    });

    on<ColorChangedEvent>((event, emit) {
      emit(state.copyWith(
          todo: state.todo.copyWith(color: TodoColor(color: event.color))));
    });
  }
}
