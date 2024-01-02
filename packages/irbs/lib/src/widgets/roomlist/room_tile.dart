import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import '../../globals/my_fonts.dart';
import '../../models/room_model.dart';
import '../../screens/room_booking_details.dart';
import '../../store/common_store.dart';
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
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.75,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 16, left: 15),
                    child: Text(
                      widget.room.roomName,
                      overflow: TextOverflow.ellipsis,
                      style: MyFonts.w500.size(14).setColor(Themes.white),
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
                          child: SizedBox(
                            height: 48,
                            width: 20,
                            child: SvgPicture.asset(
                              "packages/irbs/assets/images/pinned.svg",
                              height: 20,
                              width: 20,
                            ),
                          ),
                          onTap: () async {
                            await cs.removePinnedRooms(widget.room.id);
                          },
                        )
                      : GestureDetector(
                          child: SizedBox(
                            height: 48,
                            width: 20,
                            child: SvgPicture.asset(
                              "packages/irbs/assets/images/unpinned.svg",
                              height: 20,
                              width: 20,
                            ),
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
