import 'package:flutter/material.dart';
import 'package:irbs/widgets/home/common_rooms.dart';
import 'package:irbs/widgets/home/pinned_rooms.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 28, 30, 1),
      appBar: AppBar(
        title: Text('IRBS'),
      ),
      body: Stack(fit: StackFit.expand, children: [
        SingleChildScrollView(
          child: Column(
            children: [
              PinnedRooms(),
              CommonRooms(),
              SizedBox(
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
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromRGBO(28, 28, 30, 0),
                      Color.fromRGBO(28, 28, 30, 1)
                    ])),
              ),
              Container(
                color: Color.fromRGBO(28, 28, 30, 1),
                child: Container(
                  height: 52,
                  margin: EdgeInsets.fromLTRB(17, 0, 16, 36),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(118, 172, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: InkWell(
                      onTap: () {},
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
