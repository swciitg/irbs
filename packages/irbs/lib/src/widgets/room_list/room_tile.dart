import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import 'package:provider/provider.dart';
import '../../store/room_list_store.dart';

class RoomTile extends StatefulWidget {
  final String roomName;
  const RoomTile({Key? key, required this.roomName, }) : super(key: key);

  @override
  State<RoomTile> createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  @override
  Widget build(BuildContext context) {

    return Container(
        height: 48,
        margin: const EdgeInsets.only(left: 7.68,right: 13.68,bottom: 6),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Themes.tileColor,
          borderRadius: BorderRadius.circular(8), // Set the radius here
        ),
        child: ChangeNotifierProvider<RoomListProvider>(
          create: (context)=>RoomListProvider(),
          child: Consumer<RoomListProvider>(
            builder: (context,roomListProvider,child){
              return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 9,horizontal: 16),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Themes.white,
                          borderRadius: BorderRadius.circular(4), // Set the radius here
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 16),
                        child: Text(widget.roomName,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily:'Montserrat'
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children:  [
                      IconButton(
                        icon: const Icon(Icons.add),
                        // icon: Image.asset('assets/images/pinned.svg',
                        //   height: 20,
                        //   width: 20,
                        // ),
                        onPressed: () {
                          roomListProvider.modifyPinnedRooms(widget.roomName.toString());
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 20),
                        child: IconButton(
                          icon: const Icon(Icons.more_vert,color: Themes.white,),
                          onPressed: () {
                          },
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        )
    );
  }
}
