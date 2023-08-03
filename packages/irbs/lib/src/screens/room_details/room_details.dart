import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';
import '../../store/data_store.dart';
import '../../store/room_detail_store.dart';
import '../../widgets/myrooms/add_member_dailogue.dart';
import '../../widgets/myrooms/memberTile.dart';
import 'edit_room_details.dart';

class RoomDetailsScreen extends StatefulWidget {
  const RoomDetailsScreen({super.key,});

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    var rd = context.read<RoomDetailStore>();
    isAdmin = rd.currentRoom.owner.contains(DataStore.userData['outlookEmail']);
    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: Themes.backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              ),
            ),
            title: const Text(
              "IRBS",
              style: kAppBarTextStyle,
            ),
            backgroundColor: Themes.kCommonBoxBackground,
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            rd.currentRoom.roomName,
                        style: roomheadingStyle,
                      )),
                      if (isAdmin)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditRoomScreen(
                                  data: rd.currentRoom,
                                ),
                              ),
                            );
                          },
                          child: const ImageIcon(
                            AssetImage('packages/irbs/assets/images/edit.png'),
                            color: Colors.white,
                          ),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Capacity: ${rd.currentRoom.roomCapacity}',
                      style: kRequestedRoomStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Instructions',
                      style: instrHeadingStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${rd.currentRoom.instructions}',
                      style: instrTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Members',
                      style: instrHeadingStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (isAdmin)
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: const Color.fromRGBO(85, 95, 113, 1),
                              width: 1),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Color.fromRGBO(118, 172, 255, 1),
                            ),
                            Text(
                              'Add Member',
                              style: addmemberStyle,
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
                        await addMemberDialog(context);
                      },
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: rd.currentRoom.owner.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MemberTile(
                              isAdmin: isAdmin,
                              index: index,
                              room: rd.currentRoom,
                              isPersonAdmin: true,
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        );
                      }),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: rd.currentRoom.allowedUsers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MemberTile(
                              isAdmin: isAdmin,
                              index: index,
                              room: rd.currentRoom,
                              isPersonAdmin: false,
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
