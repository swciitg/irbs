import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irbs/src/screens/room_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals/colors.dart';

class RoomTile extends StatefulWidget {
  final String room;
  final bool pinned;
  final String roomId;
  const RoomTile({Key? key, required this.roomId, required this.room, required this.pinned})
      : super(key: key);

  @override
  State<RoomTile> createState() => _RoomTileState();
}

class _RoomTileState extends State<RoomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/irbs/RoomDetails', arguments: RoomDetailArguements(widget.roomId));
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
            Row(
              children: [
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
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 16, left: 15),
                  child: Text(
                    widget.room,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                widget.pinned
                    ? GestureDetector(
                        child: SvgPicture.asset(
                          "packages/irbs/assets/images/pinned.svg",
                          height: 20,
                          width: 20,
                        ),
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final List<String>? pinnedRooms =
                              prefs.getStringList('pinnedRooms');
                          pinnedRooms?.remove(widget.room);
                          await prefs.setStringList(
                              'pinnedRooms', pinnedRooms!);
                          prefs.reload();
                        },
                      )
                    : GestureDetector(
                        child: SvgPicture.asset(
                          "packages/irbs/assets/images/unpinned.svg",
                          height: 20,
                          width: 20,
                        ),
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final List<String> pinnedRooms =
                              prefs.getStringList('pinnedRooms') ?? [];
                          pinnedRooms.add(widget.room);
                          await prefs.setStringList(
                              'pinnedRooms', pinnedRooms);
                          prefs.reload();
                        },
                      ),
                const SizedBox(
                  width: 15,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
