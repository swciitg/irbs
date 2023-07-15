import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:irbs/src/store/data_store.dart';
import 'package:irbs/src/widgets/home/common_rooms.dart';
import 'package:irbs/src/widgets/home/current_bookings_widget.dart';
import 'package:irbs/src/widgets/home/drawer.dart';
import 'package:irbs/src/widgets/home/request_list.dart';
import 'package:irbs/src/widgets/roomlist/list_display.dart';
import 'package:provider/provider.dart';

import 'all_requests.dart';

class Home extends StatefulWidget {
  final bool isAdmin;

  const Home({required this.isAdmin, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataStore().getUserData();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var cs = context.read<CommonStore>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
      endDrawer: (!widget.isAdmin) ? null : SideDrawer(),
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
          "IRBS",
          style: kAppBarTextStyle,
        ),
        actions: widget.isAdmin
            ? []
            : [
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/irbs/onboarding');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right:11.0),
                      child: Image.asset(
                        'assets/question_circle.png',
                        package: 'irbs',
                        height: 24,
                        width: 24,
                      ),
                    ))
              ],
        backgroundColor: Themes.kCommonBoxBackground,
      ),
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isAdmin)
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 16, bottom: 10),
                  child: Text(
                    'Requests',
                    style:
                        kSubHeadingStyle.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              if (widget.isAdmin)
                SizedBox(
                    height: 167 * screenWidth / 360,
                    child: const RequestList()),
              if (widget.isAdmin)
                GestureDetector(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Container(
                      height: 40,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Themes.kCommonBoxBackground,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Center(
                        child: Text(
                          'View all Requests',
                          style: kRequestedRoomStyle,
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> ViewAllRequests()
                      )
                    );
                  },
                ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 16, bottom: 7, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Bookings',
                      style: kSubHeadingStyle.copyWith(
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/irbs/bookingHistory');
                      },
                      child: const Text(
                        'View History',
                        style: kTextButtonStyle,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: cs.initialisePinnedRooms(),
                  builder: (context, snapshot){
                if(!snapshot.hasData){return SizedBox();}
                return Observer(
                  builder: (context) {
                    return ListDisplay(roomList: cs.pinnedRooms.values.toList(), type: 'Pinned Rooms');
                  }
                );
              }),
              const CommonRooms(),
              const SizedBox(
                height: 108,
              )
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(children: [
              Container(
                height: 24,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromRGBO(28, 28, 30, 0),
                      Color.fromRGBO(28, 28, 30, 1)
                    ])),
              ),
              Container(
                color: const Color.fromRGBO(28, 28, 30, 1),
                child: Container(
                  height: 52,
                  margin: const EdgeInsets.fromLTRB(17, 0, 16, 36),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(118, 172, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/irbs/roomList');
                      },
                      child: const Center(
                          child: Text(
                        'Book a Room',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            package: 'irbs',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ))),
                ),
              ),
            ]))
      ]),
    );
  }
}
