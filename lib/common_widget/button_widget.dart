import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, this.onPressed, required this.color, required this.child});

  final void Function()? onPressed;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minWidth: double.infinity,
        height: 50,
        color: color,
        onPressed: onPressed,
        child: child,
        );
  }
}
