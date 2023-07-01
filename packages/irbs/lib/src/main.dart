import 'package:flutter/material.dart';
import 'package:irbs/src/screens/bookinghistory/booking_history.dart';
import 'package:irbs/src/screens/home/home.dart';
import 'package:irbs/src/screens/myrooms/myRooms.dart';
import 'package:irbs/src/screens/onboarding/onboarding.dart';
import 'package:irbs/src/screens/roomdetails/room_details.dart';
import 'package:irbs/src/screens/roomlist/room_list.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> irbsRootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

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
        Provider<CommonStore>(
          create: (_) => CommonStore(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/irbs/home',
        routes: {
          '/irbs/my_room': (context) => MyRooms(isAdmin: true),
          '/irbs/home': (context) => Home(isAdmin: false),
          '/irbs/RoomDetails': (context) => RoomDetails(),
          '/irbs/onboarding': (context) => const Onboarding(),
          '/irbs/roomList': (context) => const RoomList(),
          '/irbs/bookingHistory': (context) => const BookingHistory(),
        },
      ),
    );
  }
}