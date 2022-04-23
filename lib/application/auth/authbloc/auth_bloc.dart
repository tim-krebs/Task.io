import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskio/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      await authRepository.signOut();
      emit(AuthStateUnauthenticated());
    });

    on<AuthChekRequestedEvent>((event, emit) async {
      final userOption = authRepository.getSignedInUser();
      userOption.fold(() => emit(AuthStateUnauthenticated()),
          (a) => emit(AuthStateAuthenticated()));
    });
  }
}
