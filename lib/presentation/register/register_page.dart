import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskio/application/auth/signupform/signupform_bloc.dart';
import 'package:taskio/injection.dart';
import 'package:taskio/presentation/register/widgets/register_form.dart';
import 'package:taskio/presentation/signup/widgets/signup_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => sl<SignupformBloc>(),
          child: const RegisterForm()),
    );
  }
}
