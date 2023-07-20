import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';
import '../../models/room_model.dart';
import '../../store/data_store.dart';
import '../../widgets/myrooms/add_member_dailogue.dart';
import '../../widgets/myrooms/memberTile.dart';
import 'edit_room_details.dart';

class RoomDetailsScreen extends StatefulWidget {
  final RoomModel room;
  const RoomDetailsScreen({super.key, required this.room});

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    isAdmin = widget.room.owner.contains(DataStore.userData['outlookEmail']);
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.room.roomName,
                    style: roomheadingStyle,
                  )),
                  if (isAdmin)
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditRoomScreen(
                              data: widget.room,
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
                  'Capacity: ${widget.room.roomCapacity}',
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
                  '${widget.room.instructions}',
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
                    await addMemberDialog(context, widget.room);
                  },
                ),
              const SizedBox(
                height: 12,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.room.owner.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MemberTile(
                          isAdmin: isAdmin,
                          index: index,
                          room: widget.room,
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
                  itemCount: widget.room.allowedUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        MemberTile(
                          isAdmin: isAdmin,
                          index: index,
                          room: widget.room,
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
}
