import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonName;
  final Function callback;
  const Button({Key? key, required this.buttonName, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: () => callback(),
      child: Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: themeData.colorScheme.secondary),
        child: Center(
          child: Text(
            buttonName,
            style: themeData.textTheme.headline1!.copyWith(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
