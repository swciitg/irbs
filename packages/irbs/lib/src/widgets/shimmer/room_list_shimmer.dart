import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/room_model.dart';
import '../roomList/list_display.dart';
import '../roomList/search_bar.dart';

class RoomListShimmer extends StatefulWidget {
  const RoomListShimmer({super.key});

  @override
  State<RoomListShimmer> createState() => _RoomListShimmerState();
}

class _RoomListShimmerState extends State<RoomListShimmer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Shimmer.fromColors(
          highlightColor: const Color.fromRGBO(68, 71, 79, 1),
          baseColor: const Color.fromRGBO(47, 48, 51, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const RoomSearchBar(),
              ListDisplay(
                type: 'Club Rooms',
                roomList: [
                  RoomModel(
                    owner: [''], 
                    roomName: '', 
                    allowedUsers: [''], 
                    roomType: 'roomType', 
                    roomCapacity: 0, 
                    id: ' id', 
                    ownerInfo: [
                      OwnerInfo(
                        name: 'name', 
                        email: 'email', 
                        rollNo: 'rollNo'
                      ),
                    ], 
                    allowedUserInfo: [
                      OwnerInfo(
                        name: 'name', 
                        email: 'email', 
                        rollNo: 'rollNo'
                      ),
                    ]
                  ),
                ],
              ),
              ListDisplay(
                type: 'Common Rooms',
                roomList: [
                  RoomModel(
                    owner: [''], 
                    roomName: '', 
                    allowedUsers: [''], 
                    roomType: 'roomType', 
                    roomCapacity: 0, 
                    id: ' id', 
                    ownerInfo: [
                      OwnerInfo(
                        name: 'name', 
                        email: 'email', 
                        rollNo: 'rollNo'
                      ),
                    ], 
                    allowedUserInfo: [
                      OwnerInfo(
                        name: 'name', 
                        email: 'email', 
                        rollNo: 'rollNo'
                      ),
                    ]
                  ),
                ],
              ),
              ListDisplay(
                type: 'Board Rooms',
                roomList: [
                  RoomModel(
                    owner: [''], 
                    roomName: '', 
                    allowedUsers: [''], 
                    roomType: 'roomType', 
                    roomCapacity: 0, 
                    id: ' id', 
                    ownerInfo: [
                      OwnerInfo(
                        name: 'name', 
                        email: 'email', 
                        rollNo: 'rollNo'
                      ),
                    ], 
                    allowedUserInfo: [
                      OwnerInfo(
                        name: 'name', 
                        email: 'email', 
                        rollNo: 'rollNo'
                      ),
                    ]
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}