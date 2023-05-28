import 'package:flutter/material.dart';
import 'package:irbs/src/store/room_list_store.dart';
import 'package:irbs/src/widgets/room_tile.dart';
import 'package:irbs/src/widgets/search_bar.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';
import '../widgets/list_display.dart';
class RoomList extends StatefulWidget {
  const RoomList({Key? key}) : super(key: key);

  @override
  State<RoomList> createState() => _RoomListState();
}
class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      body: SafeArea(
        child: ChangeNotifierProvider<RoomListProvider>(
          create: (context)=>RoomListProvider(),
          child: Consumer<RoomListProvider>(
              builder: (context,roomListProvider,child){
                var pin =roomListProvider.pinnedRooms;
                var club =roomListProvider.clubRooms;
                var common = roomListProvider.commonRooms;
                return SingleChildScrollView(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const RoomSearchBar(),
                      roomListProvider.pinnedRooms.isEmpty ? const SizedBox():const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Pinned Rooms',
                              style: roomTypeStyle,
                            ),
                          ],
                        ),
                      ),
                      ListDisplay(type: pin, pinned: true,),
                      roomListProvider.commonRooms.isEmpty ? const SizedBox():const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Common Rooms',
                              style: roomTypeStyle,
                            ),
                          ],
                        ),
                      ),
                      ListDisplay(type: common, pinned: false,),
                      roomListProvider.clubRooms.isEmpty ? const SizedBox():const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Club Rooms',
                                style: roomTypeStyle
                            ),
                          ],
                        ),
                      ),
                      ListDisplay(type: club, pinned: false,),
                    ],
                  ),
                );
              }
          ),
        ),

      ),
    );
  }
}
