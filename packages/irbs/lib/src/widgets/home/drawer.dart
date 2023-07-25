import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../functions/launch_phone.dart';
import '../../globals/styles.dart';
import '../../models/room_model.dart';
import '../../screens/room_details/room_details.dart';
import '../../store/data_store.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(31, 39, 51, 1),
          borderRadius: BorderRadius.circular(4)
        ),
        child: FutureBuilder(
            future: DataStore().getMyRooms(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Text('Error');
              }
              List<RoomModel>? rooms = snapshot.data;
              return Stack(
                children: [
                  ListView(
                    children: [
                      Container(
                        width: 240,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(31, 39, 51, 1),
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            SvgPicture.asset(
                              'packages/irbs/assets/images/person.svg',
                              color: Colors.white,
                            ),
                            Text(
                              DataStore.userData["name"] ?? "Name",
                              style: sideDrawerStyle,
                            ),
                            Text(
                              DataStore.userData["rollNo"] ?? "RollNumber",
                              style: sideDrawerStyle,
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
                                  style: addmemberStyle.copyWith(
                                      color: Colors.white.withOpacity(0.5)),
                                ),
                              ],
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: rooms?.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                String? roomName = rooms?[index].roomName;
                                return InkWell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6),
                                    child: Text(
                                      roomName!,
                                      style: sideDrawerRoomStyle,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RoomDetailsScreen(room: rooms![index],),
                                      ),
                                    );
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
                                color: Colors.white.withOpacity(0.2),
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
                                    style: cancelButtonStyle.copyWith(
                                        color: Colors.white, height: 2),
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
                                      style: cancelButtonStyle.copyWith(
                                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )),
                ],
              );
            }),
      ),
    );
  }
}
