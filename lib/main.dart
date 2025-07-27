import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:irbs/irbs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;

  const DismissKeyboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        theme: ThemeData.dark(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              child: const Text(
                'IRBS',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                SharedPreferences user = await SharedPreferences.getInstance();

                await user.setString(
                    "userInfo",
                    jsonEncode({
                      "_id": "66a23edaaebbb4f8ae5db9ff",
                      "name": "Hardik Roongta",
                      "outlookEmail": "r.hardik@iitg.ac.in",
                      "rollNo": "210102036",
                      "__v": 0
                    }));

                await user.setString(
                  "accessToken",
                  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NmEyM2VkYWFlYmJiNGY4YWU1ZGI5ZmYiLCJpYXQiOjE3MjQwOTAxNzQsImV4cCI6MTcyNDk1NDE3NH0.Y3vBYmNN8uvhzUw6WTaoNwRD8NuXf1xLYyQFHlNfTy0",
                );

                if (!context.mounted) return;
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const IRBS()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
