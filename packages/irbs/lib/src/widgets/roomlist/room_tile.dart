import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irbs/src/models/room_model.dart';
import 'package:irbs/src/screens/room_booking_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';

class RoomTile extends StatefulWidget {
  final RoomModel room;
  const RoomTile({Key? key, required this.room}) : super(key: key);

  @override
  State<RoomTile> createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  @override
  Widget build(BuildContext context) {
    var cs = context.read<CommonStore>();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RoomBookingDetails(
                    room: widget.room,
                  )),
        );
        // Navigator.pushNamed(context, '/irbs/roomBookingDetails', arguments: widget.room);
      },
      child: Container(
        height: 48,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 6),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Themes.tileColor,
          borderRadius: BorderRadius.circular(8), // Set the radius here
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row(
            //   children: [
                // Container(
                //   margin:
                //       const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
                //   height: 30,
                //   width: 30,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius:
                //         BorderRadius.circular(4), // Set the radius here
                //   ),
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.75,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 16, left: 15),
                    child: Text(
                      widget.room.roomName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
            //   ],
            // ),
            Observer(builder: (context) {
              return Row(
                children: [
                  cs.pinnedRooms.keys.contains(widget.room.id)
                      ? GestureDetector(
                          child: SvgPicture.asset(
                            "packages/irbs/assets/images/pinned.svg",
                            height: 20,
                            width: 20,
                          ),
                          onTap: () async {
                            await cs.removePinnedRooms(widget.room.id);
                          },
                        )
                      : GestureDetector(
                          child: SvgPicture.asset(
                            "packages/irbs/assets/images/unpinned.svg",
                            height: 20,
                            width: 20,
                          ),
                          onTap: () async {
                            await cs.addPinnedRooms(widget.room);
                          },
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
