import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskio/application/auth/signupform/signupform_bloc.dart';
import 'package:taskio/core/Failures/auth_failures.dart';
import 'package:taskio/presentation/core/custom_button.dart';
import 'package:taskio/presentation/register/widgets/create_account_button.dart';
import 'package:taskio/presentation/routes/router.gr.dart';
import 'package:taskio/presentation/register/widgets/register_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String _email;
    late String _password;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // Function to prove email is valid
    String? validateEmail(String? input) {
      const emailRegex =
          r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

      if (input == null || input.isEmpty) {
        return "please enter email";
      } else if (RegExp(emailRegex).hasMatch(input)) {
        // if valid save to string
        _email = input;
        return null;
      } else {
        return "invalid email format";
      }
    }

    // Function to prove password is valid
    String? validatePassword(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter password";
      } else if (input.length >= 6) {
        // if valid save to string
        _password = input;
        return null;
      } else {
        return "short password";
      }
    }

    String mapFailureMessage(AuthFailure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return "something went wrong";
        case EmailAlreadyInUseFailure:
          return "email already in use";
        case InvalidEmailAndPasswordCombinationFailure:
          return "invalid email and password combination";
        default:
          return "something went wrong";
      }
    }

    final themeData = Theme.of(context);

    return BlocConsumer<SignupformBloc, SignupformState>(
      listener: (context, state) {
        //navigate to another page -> homepage if auth success
        state.authFailureOrSuccessOption.fold(
            () => {},
            (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold((failure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        mapFailureMessage(failure),
                        style: themeData.textTheme.bodyText1,
                      )));
                }, (_) {
                  AutoRouter.of(context).push(const HomePageRoute());
                }));
        // show error message if not
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showValidationMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/task_home.png",
                width: 200,
                height: 234,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(height: 90),
              // EMail field
              TextFormField(
                cursorColor: const Color(0xff7ec9f5),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.mail,
                    color: Colors.grey,
                  ),
                  labelText: "E-Mail",
                  hintText: "Your email...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: validateEmail,
              ),
              const SizedBox(
                height: 10,
              ),
              // Password field
              TextFormField(
                cursorColor: const Color(0xff7ec9f5),
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.lock,
                    size: 30,
                    color: Colors.grey,
                  ),
                  isDense: true,
                  labelText: "Password",
                  hintText: "Enter your password here ...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: validatePassword,
              ),
              const SizedBox(
                height: 40,
              ),
              // Sign In button
              CreateAccount(
                buttonText: "Sign in",
                callback: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<SignupformBloc>(context).add(
                        SignInWithEmailAndPasswordPressed(
                            email: _email, password: _password));
                  } else {
                    BlocProvider.of<SignupformBloc>(context).add(
                      SignInWithEmailAndPasswordPressed(
                          email: null, password: null),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 6),
                    child: Text(
                      'Don’t have an account? ',
                      style:
                          themeData.textTheme.headline1!.copyWith(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: RegisterButton(
                      buttonName: "Register",
                      callback: () {
                        AutoRouter.of(context).push(RegisterPageRoute());
                      },
                    ),
                  ),
                ],
              ),

              if (state.isSubmitting) ...[
                const SizedBox(
                  height: 20,
                ),
                LinearProgressIndicator(
                  color: themeData.colorScheme.secondary,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
