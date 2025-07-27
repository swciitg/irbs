import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:onestop_kit/onestop_kit.dart';
import '../../globals/colors.dart';

class EmptyListPlaceholder extends StatelessWidget {
  final String text;
  const EmptyListPlaceholder({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Themes.transparentColor,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: Themes.blueGrey,
          strokeWidth: 1.2,
          dashPattern: const [5.5],
          radius: const Radius.circular(4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        child: SizedBox(
          height: 18,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Text(
            text,
            style: OnestopFonts.w400.setColor(Themes.subHeadingColor),
          )),
        ),
      ),
    );
  }
}
