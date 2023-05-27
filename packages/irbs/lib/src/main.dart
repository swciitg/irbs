import 'package:flutter/material.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/screens/room_list.dart';
import 'package:irbs/src/screens/onboarding/onboarding.dart';
import 'package:irbs/src/store/room_list_store.dart';
import 'package:provider/provider.dart';
import 'globals/colors.dart';
class IRBS extends StatefulWidget {
  const IRBS({Key? key}) : super(key: key);

  @override
  State<IRBS> createState() => _IRBSState();
}
class _IRBSState extends State<IRBS> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RoomListProvider>(
          create: (_) => RoomListProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(

        ),
        home: Scaffold(
          backgroundColor: Themes.darkGrey,
          appBar: AppBar(
            title: const Center(
              child: Text('IRBS',
              style: appBarStyle,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.help_outline),
              ),
            ],
            backgroundColor: Themes.tileColor,
          ),
          body: const RoomList()
        ),
      ),
    );
  }
}
