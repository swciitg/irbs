import 'package:flutter/material.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:onestop_ui/index.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback reloadCallback;
  const ErrorScreen({super.key, required this.reloadCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColor.gray100,
      body: ErrorReloadScreen(reloadCallback: reloadCallback),
    );
  }
}
