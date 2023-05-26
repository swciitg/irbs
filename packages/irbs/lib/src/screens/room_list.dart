import 'package:flutter/material.dart';
import 'package:irbs/src/store/room_list_store.dart';
import 'package:irbs/src/widgets/search_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';
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
                //bool pinned=roomListProvider.pinnedRooms.isEmpty?false:true;
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
                      roomListProvider.pinnedRooms.isEmpty? const SizedBox():ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: roomListProvider.pinnedRooms.length,
                          itemBuilder: (context,index){
                            return Container(
                              height: 48,
                              margin: const EdgeInsets.only(left: 16,right: 16,bottom: 6),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Themes.tileColor,
                                borderRadius: BorderRadius.circular(8), // Set the radius here
                              ),
                              child:   Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 9,horizontal: 16),
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4), // Set the radius here
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15,bottom: 16),
                                        child: Text(roomListProvider.pinnedRooms[index],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontFamily:'Montserrat',
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children:  [
                                      IconButton(
                                        icon: SvgPicture.asset("packages/irbs/assets/images/pinned.svg",height: 24,width: 24,),
                                        onPressed: () {
                                          roomListProvider.modifyPinnedRooms(roomListProvider.pinnedRooms[index]);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 19,),
                                        child: IconButton(
                                          icon: const Icon(Icons.more_vert,color: Colors.white,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],


                              ),


                            );
                          }
                      ),
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
                      roomListProvider.commonRooms.isEmpty ? const SizedBox():ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: roomListProvider.commonRooms.length,
                          itemBuilder: (context,index){
                            return Container(
                              height: 48,
                              margin: const EdgeInsets.only(left: 16,right: 16,bottom: 6),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Themes.tileColor,
                                borderRadius: BorderRadius.circular(8), // Set the radius here
                              ),
                              child:   Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 9,horizontal: 16),
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4), // Set the radius here
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15,bottom: 16),
                                        child: Text(roomListProvider.commonRooms[index],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontFamily:'Montserrat',
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children:  [
                                      IconButton(
                                        icon: SvgPicture.asset("packages/irbs/assets/images/unpinned.svg",height: 20,width: 20,),
                                        onPressed: () {
                                          roomListProvider.modifyPinnedRooms(roomListProvider.commonRooms[index]);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 19,),
                                        child: IconButton(
                                          icon: const Icon(Icons.more_vert,color: Colors.white,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],


                              ),


                            );
                          }
                      ),
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
                      roomListProvider.clubRooms.isEmpty ? const SizedBox():ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: roomListProvider.clubRooms.length,
                          itemBuilder: (context,index){
                            return Container(
                              height: 48,
                              margin: const EdgeInsets.only(left: 16,right: 16,bottom: 6),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Themes.tileColor,
                                borderRadius: BorderRadius.circular(8), // Set the radius here
                              ),
                              child:   Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 9,horizontal: 16),
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4), // Set the radius here
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15,bottom: 16),
                                        child: Text(roomListProvider.clubRooms[index],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontFamily:'Montserrat',
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children:  [
                                      IconButton(
                                        icon: SvgPicture.asset("packages/irbs/assets/images/unpinned.svg",height: 20,width: 20,),
                                        onPressed: () {
                                          roomListProvider.modifyPinnedRooms(roomListProvider.clubRooms[index]);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 14,),
                                        child: IconButton(
                                          icon: const Icon(Icons.more_vert,color: Colors.white,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],


                              ),


                            );
                          }
                      ),
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
// Expanded(
//   child: ListView(
//     children: roomListProvider.commonRooms.map((e) => RoomTile(roomName: e, pinned: true)).toList(),
//   ),
// ),
