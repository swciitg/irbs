import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../functions/launch_phone.dart';
import '../../globals/colors.dart';
import '../../globals/my_fonts.dart';
import '../../screens/room_details/room_details.dart';
import '../../store/data_store.dart';
import '../../store/room_detail_store.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var rd = context.read<RoomDetailStore>();
    return SafeArea(
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: Themes.drawerBox,
          borderRadius: BorderRadius.circular(4)
        ),
        child: Observer(
          builder: (context) {
            return Stack(
              children: [
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      width: 240,
                      decoration: BoxDecoration(
                          color: Themes.drawerBox,
                          borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          SvgPicture.asset(
                            'packages/irbs/assets/images/person.svg',
                            color: Themes.white,
                          ),
                          Text(
                            DataStore.userData["name"] ?? "Name",
                            // style: sideDrawerStyle,
                            style: MyFonts.w600.size(14).setColor(Themes.white).setHeight(1.715).letterSpace(0.1),
                          ),
                          Text(
                            DataStore.userData["rollNo"] ?? "RollNumber",
                            // style: sideDrawerStyle,
                            style: MyFonts.w600.size(14).setColor(Themes.white).setHeight(1.715).letterSpace(0.1),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 240,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "My Rooms",
                              //   style: addmemberStyle.copyWith(
                              //       color: Themes.white.withOpacity(0.5)),
                              // ),
                                style: MyFonts.w500.size(14).setColor(Themes.primaryColor).copyWith(
                                    color: Themes.white.withOpacity(0.5)),
                              ),
                            ],
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: rd.myRooms.length,
                            itemBuilder:
                                (BuildContext context, int index) {
                              String? roomName = rd.myRooms[index].roomName;
                              return InkWell(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6),
                                  child: Text(
                                    roomName,
                                    // style: sideDrawerRoomStyle,
                                    style: MyFonts.w600.size(15).setColor(Themes.white).setHeight(1.333).letterSpace(0.1),
                                  ),
                                ),
                                onTap: () {
                                  rd.setSelectedRoom(rd.myRooms[index]);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RoomDetailsScreen(),
                                    ),
                                  ).then((value) => Navigator.of(context).pop());
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 0.5,
                              color: Themes.white.withOpacity(0.2),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 24,
                                ),
                                Text(
                                  "Need Help?",
                                  // style: cancelButtonStyle.copyWith(
                                  //     color: Themes.white, height: 2),
                                  style: MyFonts.w500.size(12).setColor(Themes.cancelButtonColor).copyWith(
                                      color: Themes.white, height: 2),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await launchEmail("swc@iitg.ac.in");
                                  },
                                  child: Text(
                                    'Contact Us',
                                    // style: cancelButtonStyle.copyWith(
                                    //     color: Themes.white,
                                    //     height: 2,
                                    //     decoration:
                                    //     TextDecoration.underline),
                                    style: MyFonts.w500.size(12).setColor(Themes.cancelButtonColor).copyWith(
                                        color: Themes.white,
                                        height: 2,
                                        decoration:
                                        TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            )
                          ],
                        ))
                  ],
                ),
                Positioned(
                    left: 16,
                    top: 16,
                    child: GestureDetector(
                      child: const Icon(
                        Icons.close,
                        color: Themes.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )),
              ],
            );
          }
        ),
      ),
    );
  }
}
