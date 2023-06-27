import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/screens/myrooms/myRooms.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({Key? key}) : super(key: key);
  static const name = "Aditya Pandey";
  var roll = "210206006";
  var rooms = {
    "Robotics": "Secretary",
    "Aero": "Member",
    "Coding": "Overall Coordinator"
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: 240,
          // height: 720,
          decoration: BoxDecoration(
              color: Color.fromRGBO(39, 49, 65, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), bottomLeft: Radius.circular(4))),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: 240,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(31, 39, 51, 1),
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        SvgPicture.asset(
                          'packages/irbs/assets/images/person.svg',
                          color: Colors.white,
                        ),
                        Text(
                          name,
                          style: sideDrawerStyle,
                        ),
                        Text(
                          roll,
                          style: sideDrawerStyle,
                        ),
                        SizedBox(
                          height: 28,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          itemCount: rooms.length,
                          itemBuilder: (BuildContext context, int index) {
                            String key = rooms.keys.elementAt(index);
                            return Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 0.5,
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 112,
                                      child: Text(
                                        '$key Club',
                                        style: dialogCancelStyle.copyWith(
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                        width: 80,
                                        child: Text(
                                          '${rooms[key]}',
                                          style: dialogCancelStyle.copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                        ))
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 240,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "My Rooms",
                            style: addmemberStyle.copyWith(
                                color: Colors.white.withOpacity(0.5)),
                          ),
                          // SizedBox(height: 14,),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: rooms.length,
                            itemBuilder: (BuildContext context, int index) {
                              String key = rooms.keys.elementAt(index);
                              return InkWell(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  child: Text(
                                    '$key Room',
                                    style: sideDrawerRoomStyle,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MyRooms(isAdmin: true),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 0.5,
                            color: Colors.white.withOpacity(0.2),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                              ),
                              Text(
                                "Need Help?",
                                style: cancelButtonStyle.copyWith(
                                    color: Colors.white, height: 2),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Contact Us',
                                  style: cancelButtonStyle.copyWith(
                                      color: Colors.white,
                                      height: 2,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          )
                        ],
                      ))
                ],
              ),
              Positioned(
                  left: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
            ],
          )),
    );
  }
}
