import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:irbs/src/widgets/home/request.dart';

class RequestList extends StatelessWidget {
  const RequestList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        CarouselSlider(
            items: const [
              Request(),
              Request(),
              Request(),
              Request(),
            ],
            options: CarouselOptions(
              height: (167 * MediaQuery.of(context).size.width) / 360,
              padEnds: true,
              enlargeCenterPage: false,
              autoPlay: false,
              enableInfiniteScroll: false,
              viewportFraction: 0.9,
            ))
      ],
    );
  }
}
