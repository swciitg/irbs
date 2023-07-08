import 'package:flutter/material.dart';
import 'package:irbs/src/widgets/home/request.dart';

import '../globals/colors.dart';
import '../globals/styles.dart';
class ViewAllRequests extends StatelessWidget {
  const ViewAllRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Pending Requests",
          style: kAppBarTextStyle,
        ),

        backgroundColor: Themes.kCommonBoxBackground,
      ),
      body: const SafeArea(
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
                  child: Request(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
                  child: Request(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
                  child: Request(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
                  child: Request(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
                  child: Request(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 12),
                  child: Request(),
                ),
              ],
            ),
          )
      ),
    );
  }
}
