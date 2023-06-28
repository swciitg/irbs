import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';
import '../../store/room_list_store.dart';
import '../../widgets/roomlist/list_display.dart';
import '../../widgets/roomlist/search_bar.dart';

class RoomList extends StatefulWidget {
  const RoomList({Key? key}) : super(key: key);

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {

  late List<String> pin;
  // late bool pinEmpty;
  late Timer timer;

  @override
  void initState(){
    pin = [];
    super.initState();
    getPinnedRooms();
    timer=Timer.periodic(Duration(milliseconds: 100), (timer) {
      getPinnedRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'IRBS',
          style: appBarStyle,
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/irbs/onboarding');
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
          // const [
          //   Padding(
          //     padding: EdgeInsets.only(right: 8),
          //     child: Icon(Icons.help_outline),
          //   ),
        ],
        backgroundColor: Themes.tileColor,
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<RoomListProvider>(
          create: (context) => RoomListProvider(),
          child: Consumer<RoomListProvider>(
              builder: (context,roomListProvider,child){
                // var pin =roomListProvider.pinnedRooms;
                var club =roomListProvider.clubRooms;
                var common = roomListProvider.commonRooms;
                var searchResults = roomListProvider.searchResults;
                bool wrongKeyword = roomListProvider.wrongKeyword;
                return searchResults.isEmpty ?
                SingleChildScrollView(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const RoomSearchBar(),
                      wrongKeyword ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Please Enter Correct Keyword',style: textStyle,),
                      ):const SizedBox(),
                      // roomListProvider.pinnedRooms.isEmpty||wrongKeyword ? const SizedBox(): Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       roomListProvider.searchResults.isEmpty ?
                      //       const Text('Pinned Rooms',
                      //         style: roomTypeStyle,
                      //       ):const SizedBox(),
                      //     ],
                      //   ),
                      // ),
                      // if(!wrongKeyword ) ListDisplay(type: pin, ),
                      pin.isEmpty||wrongKeyword ? const SizedBox(): Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            roomListProvider.searchResults.isEmpty ?
                            const Text('Pinned Rooms',
                              style: roomTypeStyle,
                            ):const SizedBox(),
                          ],
                        ),
                      ),
                      if(!pin.isEmpty ) ListDisplay(type: pin, ),
                      roomListProvider.commonRooms.isEmpty||wrongKeyword ? const SizedBox(): Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            roomListProvider.searchResults.isEmpty ?
                            const Text( 'Common Rooms',
                              style: roomTypeStyle,
                            ):const SizedBox(),
                          ],
//               builder: (context, roomListProvider, child) {
//             var pin = roomListProvider.pinnedRooms;
//             var club = roomListProvider.clubRooms;
//             var common = roomListProvider.commonRooms;
//             var searchResults = roomListProvider.searchResults;
//             bool wrongKeyword = roomListProvider.wrongKeyword;
//             return searchResults.isEmpty
//                 ? SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const RoomSearchBar(),
//                         wrongKeyword
//                             ? const Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Please Enter Correct Keyword',
//                                   style: textStyle,
//                                 ),
//                               )
//                             : const SizedBox(),
//                         roomListProvider.pinnedRooms.isEmpty || wrongKeyword
//                             ? const SizedBox()
//                             : Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 12),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     roomListProvider.searchResults.isEmpty
//                                         ? const Text(
//                                             'Pinned Rooms',
//                                             style: roomTypeStyle,
//                                           )
//                                         : const SizedBox(),
//                                   ],
//                                 ),
//                               ),
//                         if (!wrongKeyword)
//                           ListDisplay(
//                             type: pin,
//                           ),
//                         roomListProvider.commonRooms.isEmpty || wrongKeyword
//                             ? const SizedBox()
//                             : Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 12),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     roomListProvider.searchResults.isEmpty
//                                         ? const Text(
//                                             'Common Rooms',
//                                             style: roomTypeStyle,
//                                           )
//                                         : const SizedBox(),
//                                   ],
//                                 ),
//                               ),
//                         if (!wrongKeyword)
//                           ListDisplay(
//                             type: common,
//                           ),
//                         roomListProvider.clubRooms.isEmpty || wrongKeyword
//                             ? const SizedBox()
//                             : Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 12),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     roomListProvider.searchResults.isEmpty
//                                         ? const Text('Club Rooms',
//                                             style: roomTypeStyle)
//                                         : const SizedBox(),
//                                   ],
//                                 ),
//                               ),
//                         if (!wrongKeyword)
//                           ListDisplay(
//                             type: club,
//                           ),
//                       ],
//                     ),
//                   )
//                 : SingleChildScrollView(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const RoomSearchBar(),
//                         ListDisplay(
//                           type: searchResults,
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }

  Future<void> getPinnedRooms() async {
    if(!mounted)return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    pin = prefs.getStringList('pinnedRooms') ?? [];
    setState(() {

    });
  }
}
