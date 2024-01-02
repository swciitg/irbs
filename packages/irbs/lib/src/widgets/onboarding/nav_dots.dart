import 'package:flutter/material.dart';

import '../../globals/colors.dart';

class NavDot extends StatefulWidget {
  final bool isActive;
  const NavDot({required this.isActive, super.key});

  @override
  State<NavDot> createState() => _NavDotState();
}

class _NavDotState extends State<NavDot> {

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: widget.isActive ? 24 : 6,
      height: 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: widget.isActive ? Themes.white : Themes.inactiveNavDotsColor,
      ),
    );
  }
}