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

                //k.pal@iitg.ac.in
                // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NDlkOTE3NTVkZDQxYWRkNjgwNzgxMWMiLCJpYXQiOjE2ODg4MTIyMDYsImV4cCI6MTY4OTY3NjIwNn0.MXtOloM4Uq_c2Yl0hlr7OwtrqZdnu3BGSI0jaQUhVNk

                //b.abhinav@iitg.ac.in
                // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGE5MWVjODllN2ZiYzU5ZWZmMzQ0ZDAiLCJpYXQiOjE2ODg4MDUwNjQsImV4cCI6MTY4OTY2OTA2NH0.tVRhkBUH-a6F8LpR0bBBDGa8Jjnd6Ovnmgdv9xGSPg8

                await user.setString(
                    "userInfo",
                    jsonEncode({
                      "_id": "64a9bf9aac3eab0197b5b67e",
                      "name": "Kunal Pal",
                      "outlookEmail": "k.pal@iitg.ac.in",
                      "rollNo": "200101071",
                      "__v": 0
                    }));
                //
                // await user.setString("accessToken", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGMyNDMxZjRhYTU5ZGM4OTQzYzgyNWUiLCJpYXQiOjE2OTEwNjIzMDYsImV4cCI6MTY5MTkyNjMwNn0.iFog7su3j5r25URlhEmuc8Qr7Ur49_zMvVnbkXHU7DA");
                // await user.setString("refreshToken", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGMyNDMxZjRhYTU5ZGM4OTQzYzgyNWUiLCJpYXQiOjE2OTEwNjIzMDYsImV4cCI6MTY5MzY1NDMwNn0.PNQXBR1Bi0D681Yxp863dELFSXCRNicYbcj9QDM8Vts");

                await user.setString("accessToken",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGQzOTcwNGVjZGRiYTE3YWY3MjgyNzAiLCJpYXQiOjE2OTI0NjgwNTYsImV4cCI6MTY5MzMzMjA1Nn0.yo35_VRGfyGYLZVMBaLuE6akP-d8yjyTDk_TUAxzThs");
                await user.setString("refreshToken",
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGQzOTcwNGVjZGRiYTE3YWY3MjgyNzAiLCJpYXQiOjE2OTI0NjgwNTYsImV4cCI6MTY5NTA2MDA1Nn0.zMeNXklcF7qa9YlI70rPTy6tnU0Rw4HShu8qE9LKAF8");
                //
                // await user.setString("accessToken", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGMyNDcyZmY0NTE0MzA1YTlkMmE4MzkiLCJpYXQiOjE2OTEwODEyNDIsImV4cCI6MTY5MTk0NTI0Mn0.zQOh-aBPoUck3fW7O04Wej5olQOdKgQXPVz9aLZL0LQ");
                // await user.setString("refreshToken", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyaWQiOiI2NGMyNDcyZmY0NTE0MzA1YTlkMmE4MzkiLCJpYXQiOjE2OTEwODEyNDIsImV4cCI6MTY5MzY3MzI0Mn0.PHrCal_5KKnIIasgvmbAQL3vfdyMfZU-oiU0SMxqZQ0");
                // ignore: use_build_context_synchronously
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
