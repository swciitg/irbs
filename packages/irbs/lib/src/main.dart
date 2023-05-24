import 'package:flutter/material.dart';
import 'package:irbs/src/globals/my_colors.dart';
import 'package:irbs/src/pages/room_list.dart';
import 'package:irbs/src/screens/onboarding/onboarding.dart';
import 'package:irbs/src/store/room_list_store.dart';
import 'package:provider/provider.dart';

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
          appBar: AppBar(
            title: const Text('IRBS'),
          ),
          body: const RoomList()
        ),
      ),
    );
  }
}
// ChangeNotifierProvider<RoomListProvider>(
// create: (context)=>RoomListProvider(),
// child: Consumer<RoomListProvider>(
// builder: (context,roomListProvider,child){
// return RoomList();
// }))