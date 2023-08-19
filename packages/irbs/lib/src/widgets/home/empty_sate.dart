import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../globals/colors.dart';
import '../../globals/my_fonts.dart';

class EmptyListPlaceholder extends StatelessWidget {
  final String text;
  const EmptyListPlaceholder({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Themes.transparentColor,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: Themes.blueGrey,
        strokeWidth: 1.2,
        dashPattern: const [5.5],
        radius: const Radius.circular(4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SizedBox(
          height: 18,
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Text(
                text,
                // style: subHeadingStyle
                style: MyFonts.w400.setColor(Themes.subHeadingColor),
              )
          ),
        ),
      ),
    );
  }
}
