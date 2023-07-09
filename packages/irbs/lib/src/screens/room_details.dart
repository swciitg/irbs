import 'package:flutter/material.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/screens/myrooms/member_details.dart';
import 'package:irbs/src/widgets/myrooms/memberTile.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';
import 'myrooms/editRoom.dart';

class RoomDetails extends StatefulWidget {
  final RoomModel roomModel;
  bool isAdmin = false;
  RoomDetails({required this.isAdmin, required this.roomModel});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  var data = {
    "name": "Coding Club",
    "capacity": "25",
    "instructions":
        "Lorem ipsum dolor sit amet consectetur. Dolor in felis nec aliquam. Mauris sed odio morbi dignissim pulvinar nunc semper eu habitant. Eu at quisque libero ullamcorper. Luctus neque enim cras semper aliquam.",
  };
  var members = [
    {"name": "Kunal Pal", "designation": "Secretary"},
  ];
  var designations = {
    "Secretary": true,
    "Overall Coordinator": true,
    "Design Head": false,
    "App Dev Head": false,
    "Web Developer": false
  };
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
                    widget.roomModel.roomName,
                    style: roomheadingStyle,
                  )),
                  if (widget.isAdmin)
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditRoom(
                                data: data, designations: designations),
                          ),
                        );
                      },
                      child: const ImageIcon(
                      AssetImage(
                          'packages/irbs/assets/images/edit.png'),
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
                  'Capacity: ${widget.roomModel.roomCapacity}',
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
                  '${widget.roomModel.instructions}',
                  style: instrTextStyle,
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "See more",
                  style: seemoreStyle,
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
              if (widget.isAdmin)
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: const Color.fromRGBO(85, 95, 113, 1), width: 1),
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
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MemberDetails(isEdit: false),
                    ));
                  },
                ),
              const SizedBox(
                height: 12,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.roomModel.owner.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MemberTile(
                          isAdmin: widget.isAdmin,
                          member: widget.roomModel.owner[index],
                          designations: 'Admin',
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
                  itemCount: widget.roomModel.allowedUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        MemberTile(
                          isAdmin: widget.isAdmin,
                          member: widget.roomModel.allowedUsers[index],
                          designations: 'Member',
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
