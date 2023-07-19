import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:irbs/irbs.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage()
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

                //k.pal@iitg.ac.in
                // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NDlkOTE3NTVkZDQxYWRkNjgwNzgxMWMiLCJpYXQiOjE2ODg4MTIyMDYsImV4cCI6MTY4OTY3NjIwNn0.MXtOloM4Uq_c2Yl0hlr7OwtrqZdnu3BGSI0jaQUhVNk

                //b.abhinav@iitg.ac.in
                // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGE5MWVjODllN2ZiYzU5ZWZmMzQ0ZDAiLCJpYXQiOjE2ODg4MDUwNjQsImV4cCI6MTY4OTY2OTA2NH0.tVRhkBUH-a6F8LpR0bBBDGa8Jjnd6Ovnmgdv9xGSPg8

                await user.setString("userInfo", jsonEncode({
                  "_id": "64a9bf9aac3eab0197b5b67e",
                  "name": "Hareesh Nandigrama",
                  "outlookEmail": "h.nandigrama@iitg.ac.in",
                  "rollNo": "200101071",
                  "__v": 0
                }));

                await user.setString("accessToken", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NDlkOTk2NzA2MmNmOTBmYzljMjMwNjAiLCJpYXQiOjE2ODk2NzA4NjksImV4cCI6MTY5MDUzNDg2OX0.V1tZsJIYivxmhbz4eEtzPRWnzWCqTvcuP1B_-kT77SU");
                await user.setString("refreshToken", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NDlkOTk2NzA2MmNmOTBmYzljMjMwNjAiLCJpYXQiOjE2ODk2NzA4NjksImV4cCI6MTY5MjI2Mjg2OX0.Dyegn9DHB3Qf_V3lA3kh59qU_K5QTzTkOd9lEKocSv4");

                // await user.setString("userInfo", jsonEncode({
                //   "_id": "64a9bf9aac3eab0197b5b67e",
                //   "name": "Hardik Roongta",
                //   "outlookEmail": "r.hardik@iitg.ac.in",
                //   "rollNo": "210102036",
                //   "__v": 0
                // }));
                //
                // await user.setString("accessToken", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGE5YmY5YWFjM2VhYjAxOTdiNWI2N2UiLCJpYXQiOjE2ODk2NzA1MjYsImV4cCI6MTY5MDUzNDUyNn0.n81Mu0bO0wnasxlKZrE9eRd1uLpnsd3ETp71xBP63Ew");
                // await user.setString("refreshToken", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGE5YmY5YWFjM2VhYjAxOTdiNWI2N2UiLCJpYXQiOjE2ODk2NzA1MjYsImV4cCI6MTY5MjI2MjUyNn0.Jn71fi6NRaRdNxu5-k8sjU0cD32ea62VtZ2snTZgrcY");
                //

                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const IRBS()
                    )
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

