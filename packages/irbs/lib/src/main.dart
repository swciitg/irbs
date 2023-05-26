import 'package:flutter/material.dart';
import 'package:irbs/src/screens/home/home.dart';
import 'package:irbs/src/screens/onboarding/onboarding.dart';

class IRBS extends StatefulWidget {
  const IRBS({Key? key}) : super(key: key);

  @override
  State<IRBS> createState() => _IRBSState();
}

class _IRBSState extends State<IRBS> {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
