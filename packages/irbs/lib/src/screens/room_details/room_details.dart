import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onestop_ui/index.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../store/data_store.dart';
import '../../store/room_detail_store.dart';
import '../../widgets/myrooms/add_member_dailogue.dart';
import '../../widgets/myrooms/member_tile.dart';
import 'edit_room_details.dart';

class RoomDetailsScreen extends StatefulWidget {
  const RoomDetailsScreen({super.key});

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
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: Icon(FluentIcons.arrow_left_24_regular, color: OColor.gray800),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text("IRBS", style: OTextStyle.headingMedium.copyWith(color: OColor.gray800)),
            backgroundColor: OColor.gray100,
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
                          style: OTextStyle.headingLarge.copyWith(color: OColor.gray800),
                        ),
                      ),
                      if (isAdmin)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditRoomScreen(data: rd.currentRoom),
                              ),
                            );
                          },
                          child: ImageIcon(
                            const AssetImage('packages/irbs/assets/images/edit.png'),
                            color: Themes.white,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Capacity: ${rd.currentRoom.roomCapacity}',
                      style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Instructions',
                      style: OTextStyle.headingXSmall.copyWith(color: OColor.gray600),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${rd.currentRoom.instructions}',
                      style: OTextStyle.bodyXSmall.copyWith(color: OColor.gray800, height: 1.4545),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Members',
                      style: OTextStyle.headingXSmall.copyWith(color: OColor.gray600),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (isAdmin)
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Themes.comet, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Themes.primaryColor),
                            Text(
                              'Add Member',
                              style: OTextStyle.labelSmall.copyWith(color: Themes.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        await addMemberDialog(context);
                      },
                    ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: rd.currentRoom.owner.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          MemberTile(
                            isAdmin: isAdmin,
                            index: index,
                            room: rd.currentRoom,
                            isPersonAdmin: true,
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: rd.currentRoom.allowedUsers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          MemberTile(
                            isAdmin: isAdmin,
                            index: index,
                            room: rd.currentRoom,
                            isPersonAdmin: false,
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
