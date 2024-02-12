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
  const DismissKeyboard({Key? key, required this.child}) : super(key: key);

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
    return const DismissKeyboard(
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            color: Colors.red,
            child: GestureDetector(
              child: const Text(
                'IRBS',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                SharedPreferences user = await SharedPreferences.getInstance();

                await user.setString(
                    "userInfo",
                    jsonEncode({
                      "_id": "64a9bf9aac3eab0197b5b67e",
                      "name": "Hareesh Nandigrama",
                      "outlookEmail": "h.nandigrama@iitg.ac.in",
                      "rollNo": "200101071",
                      "__v": 0
                    }));


                await user.setString("accessToken",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGMyNDE5ODRhYTU5ZGM4OTQzYzgyNGMiLCJpYXQiOjE3MDcyNTA1OTYsImV4cCI6MTcwODExNDU5Nn0.TPIANeU8SQIo7dC07jU0FW4loLnkURRMo1jmAp1W54k");

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
