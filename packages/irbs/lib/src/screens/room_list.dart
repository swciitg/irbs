import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:provider/provider.dart';
import '../functions/filter_rooms.dart';
import '../globals/colors.dart';
import '../store/common_store.dart';
import '../store/room_detail_store.dart';
import '../widgets/home/empty_sate.dart';
import '../widgets/roomlist/list_display.dart';
import '../widgets/roomlist/search_bar.dart';
import '../widgets/shimmer/room_list_shimmer.dart';
import 'onboarding.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    var rd = context.read<RoomDetailStore>();

    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Themes.white,
          ),
        ),
        title: Text(
          'IRBS',
          style: OnestopFonts.w500.size(20).setColor(Themes.white),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) => const OnboardingScreen()));
                // Navigator.pushReplacementNamed(context, '/irbs/onboarding');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 11.0),
                child: Image.asset(
                  'assets/question_circle.png',
                  package: 'irbs',
                  height: 24,
                  width: 24,
                ),
              ))
        ],
        backgroundColor: Themes.tileColor,
      ),
      body: FutureBuilder(
          future: rd.getAllRooms(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const RoomListShimmer();
            } else if (snapshot.hasError) {
              return const EmptyListPlaceholder(text: 'Some error occured, try again');
            }
            return Observer(builder: (context) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const RoomSearchBar(),
                    ListDisplay(
                      type: 'Club Rooms',
                      roomList: filterRooms(snapshot.data!['club']!, commonStore.searchText),
                    ),
                    ListDisplay(
                      type: 'Common Rooms',
                      roomList: filterRooms(snapshot.data!['common']!, commonStore.searchText),
                    ),
                    ListDisplay(
                      type: 'Board Rooms',
                      roomList: filterRooms(snapshot.data!['board']!, commonStore.searchText),
                    )
                  ]),
                ),
              );
            });
          }),
    );
  }
}
