import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('IRBS',
          style: appBarStyle,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.help_outline),
          ),
        ],
        backgroundColor: Themes.tileColor,
      ),
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

