import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../main.dart';

void showSnackBar(String message) {
  irbsRootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

void showErrorSnackBar(DioException err) {
  irbsRootScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    content: Text(
        (err.response != null)
            ? err.response!.data['message']
            : "Some error occurred. try again"
    ),
    duration: const Duration(seconds: 5),
  ));
}