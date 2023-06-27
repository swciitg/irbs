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
                var searchResults = roomListProvider.searchResults;
                return searchResults.isEmpty?
                SingleChildScrollView(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const RoomSearchBar(),

                      roomListProvider.pinnedRooms.isEmpty ? const SizedBox(): Padding(
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
                      ListDisplay(type: pin, ),
                      roomListProvider.commonRooms.isEmpty ? const SizedBox(): Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            roomListProvider.searchResults.isEmpty ?
                            const Text( 'Common Rooms',
                              style: roomTypeStyle,
                            ):const SizedBox(),
                          ],
                        ),
                      ),
                      ListDisplay(type: common, ),
                      roomListProvider.clubRooms.isEmpty ? const SizedBox(): Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            roomListProvider.searchResults.isEmpty ?
                            const Text('Club Rooms',
                                style: roomTypeStyle
                            ):const SizedBox(),
                          ],
                        ),
                      ),
                      ListDisplay(type: club,),
                    ],
                  ),
                ):
                SingleChildScrollView(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const RoomSearchBar(),
                      ListDisplay(type: searchResults,),
                    ],
                  ),
                )
                ;
              }
          ),
        ),

      ),
    );
  }
}

