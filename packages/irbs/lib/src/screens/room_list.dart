import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irbs/src/widgets/shimmer/room_list_shimmer.dart';
import 'package:provider/provider.dart';
import '../functions/filter_rooms.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';
import '../store/common_store.dart';
import '../store/data_store.dart';
import '../widgets/roomlist/list_display.dart';
import '../widgets/roomlist/search_bar.dart';

class RoomList extends StatefulWidget {
  const RoomList({Key? key}) : super(key: key);

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
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
      body: FutureBuilder(
          future: DataStore().getAllRooms(),
          builder: (context, snapshot) {
            commonStore.setSearchText('');
            if (!snapshot.hasData) {
              return const RoomListShimmer();
            } else if (snapshot.hasError) {
              return const Text('Error');
            }
            return Observer(builder: (context) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const RoomSearchBar(),
                      ListDisplay(
                        type: 'Club Rooms',
                        roomList: filterRooms(
                          snapshot.data!['club']!, commonStore.searchText
                        ),
                      ),
                      ListDisplay(
                        type: 'Common Rooms',
                        roomList: filterRooms(
                          snapshot.data!['common']!, commonStore.searchText
                        ),
                      ),
                      ListDisplay(
                        type: 'Board Rooms',
                        roomList: filterRooms(
                          snapshot.data!['board']!, commonStore.searchText
                        ),
                      )
                    ]
                  ),
                ),
              );
            });
          }),
    );
  }
}
