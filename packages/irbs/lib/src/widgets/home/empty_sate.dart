import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:irbs/src/globals/styles.dart';
import '../../globals/colors.dart';
class EmptyState extends StatelessWidget {
  final  String text;
  const EmptyState({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: Themes.white,
        strokeWidth: 1.2,
        dashPattern: const [5.5],
        radius: const Radius.circular(4),
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: Container(
          height: 18,
          width: MediaQuery.of(context).size.width,
          child:  Center(child: Text( text,
            style: textStyle)),
        ),
      ),
    )
    ;
  }
}

