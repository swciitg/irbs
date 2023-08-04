import 'package:flutter/material.dart';
import 'package:irbs/src/screens/booking_history.dart';
import 'package:irbs/src/screens/home.dart';
import 'package:irbs/src/screens/onboarding.dart';
import 'package:irbs/src/screens/room_list.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:irbs/src/store/room_detail_store.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> irbsRootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

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
        Provider<RoomDetailStore>(
          create: (_) => RoomDetailStore(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          '/irbs/onboarding': (context) => const OnboardingScreen(),
          '/irbs/roomList': (context) => const RoomListScreen(),
          '/irbs/bookingHistory': (context) => const BookingHistoryScreen(),
        },
      ),
    );
  }
}
