import 'package:flutter/material.dart';
import 'package:irbs/src/screens/bookinghistory/booking_history.dart';
import 'package:irbs/src/screens/home/home.dart';
import 'package:irbs/src/screens/onboarding/onboarding.dart';
import 'package:irbs/src/screens/roomdetails/room_details.dart';
import 'package:irbs/src/screens/roomlist/room_list.dart';
import 'package:irbs/src/store/room_list_store.dart';
import 'package:irbs/src/widgets/bookinghistory/booking_status.dart';
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
        debugShowCheckedModeBanner: false,
        initialRoute: '/irbs/RoomDeatils',
        routes: {
          '/irbs/RoomDeatils': (context) => RoomDetails(),
          '/irbs/onboarding': (context) => const Onboarding(),
          '/irbs/home': (context) => const Home(),
          '/irbs/roomList': (context) => const RoomList(),
          '/irbs/bookingHistory': (context) => const BookingHistory(),
        },
        theme: ThemeData(),
      ),
    );
  }
}
