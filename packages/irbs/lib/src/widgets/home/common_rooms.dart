import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:provider/provider.dart';

import '../../globals/colors.dart';

import '../../models/room_model.dart';
import '../../screens/room_booking_details.dart';
import '../../store/room_detail_store.dart';
import '../shimmer/room_list_shimmer.dart';
import 'empty_sate.dart';

class CommonRooms extends StatefulWidget {
  const CommonRooms({super.key});

  @override
  State<CommonRooms> createState() => _CommonRoomsState();
}

class _CommonRoomsState extends State<CommonRooms> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    var rd = context.read<RoomDetailStore>();
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Common Rooms',
              style: OnestopFonts.w400.size(14).setColor(Themes.kSubHeading).letterSpace(0.5),
            ),
          ),
        ),
        FutureBuilder(
            future: rd.getAllRooms(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const RoomListShimmer();
              } else if (snapshot.hasError) {
                return const EmptyListPlaceholder(text: 'Some error occured, try again');
              }
              return Observer(builder: (context) {
                List<RoomModel> commonRooms = snapshot.data!['common']!;
                count = commonRooms.length;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Number of columns in the grid
                          crossAxisSpacing: 16,
                          childAspectRatio: 99 / 72,
                          mainAxisSpacing: 12),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: commonRooms.length > 6 ? 6 : commonRooms.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 6) return const GridWidget(name: "View All");
                        return GridWidget(
                          name: commonRooms[index].roomName,
                          room: commonRooms[index],
                        );
                      },
                    ),
                  ),
                );
              });
            }),
      ],
    );
  }
}

class CommonRoomGrid extends StatefulWidget {
  final List<RoomModel> commonRooms;
  const CommonRoomGrid({super.key, required this.commonRooms});

  @override
  State<CommonRoomGrid> createState() => _CommonRoomGridState();
}

class _CommonRoomGridState extends State<CommonRoomGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns in the grid
          crossAxisSpacing: 16,
          childAspectRatio: 99 / 72,
          mainAxisSpacing: 12),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.commonRooms.length,
      itemBuilder: (BuildContext context, int index) {
        return GridWidget(name: widget.commonRooms[index].roomName);
      },
    );
  }
}

class GridWidget extends StatelessWidget {
  final String name;
  final RoomModel? room;
  const GridWidget({super.key, required this.name, this.room});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Themes.tileColor, borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Center(
            child: Text(
          name,
          textAlign: TextAlign.center,
          style: OnestopFonts.w400.size(14).setColor(Themes.white),
        )),
      ),
      onTap: () {
        if (room != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RoomBookingDetails(
                      room: room!,
                    )),
          );
        }
      },
    );
  }
}
