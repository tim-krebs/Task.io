import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskio/application/auth/signupform/signupform_bloc.dart';
import 'package:taskio/injection.dart';
import 'package:taskio/presentation/signup/widgets/signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => sl<SignupformBloc>(), child: const SignUpForm()),
    );
  }
}
