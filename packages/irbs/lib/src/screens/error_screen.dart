import 'package:flutter/material.dart';
import 'package:onestop_kit/onestop_kit.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback reloadCallback;
  const ErrorScreen({super.key, required this.reloadCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OneStopColors.backgroundColor,
      body: ErrorReloadScreen(reloadCallback: reloadCallback),
    );
  }
}
