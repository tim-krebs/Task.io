import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskio/application/auth/signupform/signupform_bloc.dart';
import 'package:taskio/core/Failures/auth_failures.dart';

import 'package:taskio/presentation/register/widgets/create_account_button.dart';
import 'package:taskio/presentation/routes/router.gr.dart';
import 'package:taskio/presentation/register/widgets/register_button.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String _fullname;
    late String _email;
    late String _password;
    late String _confirmpassword;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    //Function to prove name is valid
    String? validateName(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter Full Name";
      } else if (input.length >= 6) {
        // if valid save to string
        _fullname = input;
        return null;
      } else {
        return "This is not a name";
      }
    }

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

    // Function to prove password is valid
    String? confirmPassword(String? input) {
      if (input == null || input != _password || input.isEmpty) {
        return "Passwords don\'t match!";
      } else if (input.length >= 6) {
        // if valid save to string
        _confirmpassword = input;
        return null;
      } else {
        return "Passwords don\'t match!";
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
                "assets/tasks_card.png",
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(height: 40),
              TextFormField(
                cursorColor: const Color(0xff7ec9f5),
                decoration: InputDecoration(
                  labelText: "Full Name",
                  hintText: "Enter your name here...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: validateName,
              ),
              const SizedBox(
                height: 10,
              ),
              // EMail field
              TextFormField(
                cursorColor: const Color(0xff7ec9f5),
                decoration: InputDecoration(
                  labelText: "Email Address",
                  hintText: "Enter your email here ...",
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
                height: 10,
              ),
              TextFormField(
                cursorColor: const Color(0xff7ec9f5),
                obscureText: true,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: "Confirm Password",
                  hintText: "Confirm password here ...",
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: confirmPassword,
              ),
              const SizedBox(
                height: 40,
              ),
              //Register Button
              CreateAccount(
                buttonText: "Register",
                callback: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<SignupformBloc>(context).add(
                        RegisterWithEmailAndPasswordPressed(
                            email: _email, password: _password));
                  } else {
                    BlocProvider.of<SignupformBloc>(context).add(
                      RegisterWithEmailAndPasswordPressed(
                          email: null, password: null),
                    );
                  }
                },
              ),
              // Already have Account?
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 6),
                    child: Text(
                      "Already have an account?",
                      style:
                          themeData.textTheme.headline1!.copyWith(fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: RegisterButton(
                      buttonName: "Login",
                      callback: () {
                        AutoRouter.of(context).push(SignUpPageRoute());
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
              ]
            ],
          ),
        );
      },
    );
  }
}
