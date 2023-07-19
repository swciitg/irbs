import 'package:flutter/material.dart';

import '../../globals/styles.dart';

class CommonRooms extends StatefulWidget {
  const CommonRooms({super.key});

  @override
  State<CommonRooms> createState() => _CommonRoomsState();
}

class _CommonRoomsState extends State<CommonRooms> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Text(
              'Common Rooms',
              style: subHeadingStyle,
            ),
          ),
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          childAspectRatio: 99 / 72,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          mainAxisSpacing: 12,
          children: [
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: const Center(
                    child: Text(
                  "Conf. Room",
                  textAlign: TextAlign.center,
                  style: textStyle,
                )),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: const Center(
                    child: Text(
                  "TechBoard Room",
                  textAlign: TextAlign.center,
                  style: textStyle,
                )),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: const Center(
                    child: Text(
                  "Yoga Room",
                  textAlign: TextAlign.center,
                  style: textStyle,
                )),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: const Center(
                    child: Text(
                  "Alcher Room",
                  textAlign: TextAlign.center,
                  style: textStyle,
                )),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: const Center(
                    child: Text(
                  "Board Room",
                  textAlign: TextAlign.center,
                  style: textStyle,
                )),
              ),
              onTap: () {},
            ),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(39, 49, 65, 1),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: const Center(
                    child: Text(
                  "View All",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      package: 'irbs',
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline),
                )),
              ),
              onTap: () {},
            )
          ],
        ),
      ],
    );
  }
}
