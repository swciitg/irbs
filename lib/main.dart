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
    return MaterialApp(
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
              child: Text(
                'IRBS',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                SharedPreferences user = await SharedPreferences.getInstance();

                // h.nandigrama@iitg.ac.in -> superadmin
                // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NDlkOTk2NzA2MmNmOTBmYzljMjMwNjAiLCJpYXQiOjE2ODg4MDQ4OTQsImV4cCI6MTY4OTY2ODg5NH0.wfrq1RDzMbDOWKQzauZpbXyxg8u687pQPK054SyQdpM

                //k.pal@iitg.ac.in
                // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NDlkOTE3NTVkZDQxYWRkNjgwNzgxMWMiLCJpYXQiOjE2ODg4MTIyMDYsImV4cCI6MTY4OTY3NjIwNn0.MXtOloM4Uq_c2Yl0hlr7OwtrqZdnu3BGSI0jaQUhVNk

                //b.abhinav@iitg.ac.in
                // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGE5MWVjODllN2ZiYzU5ZWZmMzQ0ZDAiLCJpYXQiOjE2ODg4MDUwNjQsImV4cCI6MTY4OTY2OTA2NH0.tVRhkBUH-a6F8LpR0bBBDGa8Jjnd6Ovnmgdv9xGSPg8

                await user.setString("userInfo", jsonEncode(
                  {
                    "_id": "649d9967062cf90fc9c23060",
                    "name": "Nandigrama Naga Venkata Hareesh",
                    "outlookEmail": "h.nandigrama@iitg.ac.in",
                    "rollNo": "200101071",
                    "__v": 0,
                    "altEmail": "hareeshnandigrama@gmail.com",
                    "dob": "2023-06-29T00:00:00.000Z",
                    "emergencyPhoneNumber": 7780298361,
                    "gender": "Male",
                    "homeAddress": "ahajfk",
                    "hostel": "Kameng",
                    "linkedin": "",
                    "phoneNumber": 8888888888,
                    "roomNo": "B1202"
                  }
                ));
                await user.setString("accessToken", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NDlkOTk2NzA2MmNmOTBmYzljMjMwNjAiLCJpYXQiOjE2ODg4MDQ4OTQsImV4cCI6MTY4OTY2ODg5NH0.wfrq1RDzMbDOWKQzauZpbXyxg8u687pQPK054SyQdpM");
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

