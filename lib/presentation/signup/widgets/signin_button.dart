import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String buttonName;
  final Function callback;
  const SignInButton(
      {Key? key, required this.buttonName, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: () => callback(),
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Color(0xff7ec9f5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: themeData.textTheme.headline1!.copyWith(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
