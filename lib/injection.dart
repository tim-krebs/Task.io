import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:taskio/application/auth/authbloc/auth_bloc.dart';
import 'package:taskio/application/auth/signupform/signupform_bloc.dart';
import 'package:taskio/application/todo/controller/controller_bloc.dart';
import 'package:taskio/application/todo/observer/observer_bloc.dart';
import 'package:taskio/application/todo/todoForm/todoform_bloc.dart';
import 'package:taskio/domain/repositories/auth_repository.dart';
import 'package:taskio/domain/repositories/todo_repository.dart';
import 'package:taskio/infrastructure/repositories/auth_repository_impl.dart';
import 'package:taskio/infrastructure/repositories/todo_repository_impl.dart';

// sl = service locator
final sl = GetIt.I;

Future<void> init() async {
  /*#################### auth ####################*/

  // state management
  sl.registerFactory(() => SignupformBloc(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

  //! repos
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

  //! extern
  final friebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => friebaseAuth);

  /*#################### tasks ####################*/

  //!X state management
  sl.registerFactory(() => ObserverBloc(todoRepository: sl()));
  sl.registerFactory(() => ControllerBloc(todoRepository: sl()));
  sl.registerFactory(() => TodoformBloc(todoRepository: sl()));

  //! repos
  sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(firestore: sl()));

  //! extern
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);
}
