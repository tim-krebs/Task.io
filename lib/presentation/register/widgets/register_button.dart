import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final String buttonName;
  final Function callback;
  const RegisterButton(
      {Key? key, required this.buttonName, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: () => callback(),
      child: Container(
        height: 30,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            buttonName,
            style: themeData.textTheme.headline1!.copyWith(
              fontSize: 17,
              color: Color(0xff7ec9f5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
