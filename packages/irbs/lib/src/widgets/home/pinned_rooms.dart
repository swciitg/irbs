import 'package:flutter/material.dart';
import 'package:irbs/src/globals/styles.dart';

class PinnedRooms extends StatefulWidget {
  const PinnedRooms({super.key});

  @override
  State<PinnedRooms> createState() => _PinnedRoomsState();
}

class _PinnedRoomsState extends State<PinnedRooms> {
  var pinnedRoom = [
    {
      'img':
          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      'name': 'SWC Room'
    },
    {
      'img':
          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      'name': 'TechBoard Room'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Text(
              'Pinned Rooms',
              style: subHeadingStyle,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: pinnedRoom.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Container(
                height: 48,
                padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        image: DecorationImage(
                            image: NetworkImage(pinnedRoom[index]['img']!),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        pinnedRoom[index]['name']!,
                        style: textStyle,
                      ),
                    ),
                    GestureDetector(
                      child: Image(
                        image: AssetImage('assets/pin.png', package: 'irbs'),
                        color: Colors.white,
                        height: 16,
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 14,
                    )
                  ],
                ),
              ),
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
}
