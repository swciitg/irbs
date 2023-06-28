import 'package:flutter/material.dart';
import 'package:irbs/src/screens/myrooms/member_details.dart';
import 'package:irbs/src/widgets/myrooms/memberTile.dart';

import '../../globals/colors.dart';
import '../../globals/styles.dart';
import 'editRoom.dart';

class MyRooms extends StatefulWidget {
  bool isAdmin = false;
  MyRooms({required this.isAdmin});

  @override
  State<MyRooms> createState() => _MyRoomsState();
}

class _MyRoomsState extends State<MyRooms> {
  var data = {
    "name": "Coding Club",
    "capacity": "25",
    "instructions":
        "Lorem ipsum dolor sit amet consectetur. Dolor in felis nec aliquam. Mauris sed odio morbi dignissim pulvinar nunc semper eu habitant. Eu at quisque libero ullamcorper. Luctus neque enim cras semper aliquam.",
  };
  var members = [
    {"name": "Kunal Pal", "designation": "Secretary"},
    {"name": "Punal Kal", "designation": "Overall Coordinator"},
    {"name": "Punal Kal", "designation": "Overall Coordinator"},
    {"name": "Punal Kal", "designation": "Overall Coordinator"},
    {"name": "Punal Kal", "designation": "Overall Coordinator"},
    {"name": "Punal Kal", "designation": "Overall Coordinator"},
    {"name": "Punal Kal", "designation": "Overall Coordinator"},
    {"name": "Punal Kal", "designation": "Web Developer"}
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
          margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "${data['name']}",
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
                      child: ImageIcon(
                      AssetImage(
                          'packages/irbs/assets/images/edit.png'),
                      color: Colors.white,
                    ),
                    )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Capacity: ${data['capacity']}',
                  style: kRequestedRoomStyle,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Instructions',
                  style: instrHeadingStyle,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${data["instructions"]}',
                  style: instrTextStyle,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "See more",
                  style: seemoreStyle,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Members',
                  style: instrHeadingStyle,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (widget.isAdmin)
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: Color.fromRGBO(85, 95, 113, 1), width: 1),
                    ),
                    child: Row(
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
                      builder: (context) => MemberDetails(isEdit: false),
                    ));
                  },
                ),
              SizedBox(
                height: 12,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: members != Null ? members.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        MemberTile(
                          isAdmin: widget.isAdmin,
                          member: members[index],
                          designations: designations,
                        ),
                        SizedBox(
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
