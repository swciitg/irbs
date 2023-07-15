import 'package:flutter/material.dart';
import 'package:irbs/src/screens/room_details/room_details.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/widgets/roomBookingDetails/calendar.dart';
import 'package:irbs/src/widgets/roomBookingDetails/request_modal.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';
import 'package:intl/intl.dart';
import '../widgets/roomBookingDetails/upcoming_booking_widget.dart';
import '../models/booking_model.dart';
import '../models/room_model.dart';


class RoomBookingDetails extends StatefulWidget {
  final RoomModel room;
  const RoomBookingDetails({super.key, required this.room});

  @override
  State<RoomBookingDetails> createState() => _RoomBookingDetailsState();
}

class _RoomBookingDetailsState extends State<RoomBookingDetails> {
  CalendarView view = CalendarView.month;
  late Future getRoomBookings;

  TextEditingController dateCtl = TextEditingController();
  _showModal(context)async {
    await showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return RequestModal(room: widget.room);
        });

    setState(() {
      getRoomBookings = APIService().getBookingsForCalendar(
        roomId: widget.room.id,
        month: DateTime.now().month,
        year: DateTime.now().year.toString()
      );      
    });    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoomBookings = APIService().getBookingsForCalendar(
      roomId: widget.room.id,
      month: DateTime.now().month,
      year: DateTime.now().year.toString()
    );
  }

  @override
  Widget build(BuildContext context) {
    List<BookingModel> allBookings = [];
    List<BookingModel> latestBookings = [];
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
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
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/irbs/onboarding');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 11.0),
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
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
          onPressed: () {
            _showModal(context);
          },
          child: Image.asset(
            'packages/irbs/assets/images/add.png',
            fit: BoxFit.contain,
          )),
      body: FutureBuilder(
        future: getRoomBookings,
        builder: (context, snapshot) {
          print('INSIDE BUILDER');
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasError){
            return const Text('Error');
          }
          else {
            allBookings = [];
            latestBookings = [];
            for(var booking in snapshot.data!){
              if(DateTime.parse(booking.outTime).toIso8601String().compareTo(
                DateTime.now().toLocal().toIso8601String()) == 1){
                allBookings.add(booking);
              }
            }

            allBookings.sort((a, b) => a.inTime.compareTo(b.inTime),);
            if(allBookings.length <= 2){
              latestBookings = allBookings;
            }
            else{
              latestBookings = [allBookings[0], allBookings[1]];
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 60,
                  //color: const Color.fromRGBO(39, 49, 65, 1),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        widget.room.roomName,
                        style: roomheadingStyle,
                      )),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => RoomDetails(room: widget.room,)),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Divider(
                  height: 0.5,
                  color: Colors.white.withOpacity(0.2),
                ),
                ExpansionTile(
                  childrenPadding: const EdgeInsets.only(bottom: 12),
                  title: const Text(
                    'Upcoming Bookings',
                    style: subHeadingStyle,
                  ),
                  collapsedIconColor:const Color.fromRGBO(135, 145, 165, 1),
                  iconColor:const Color.fromRGBO(135, 145, 165, 1),
                  children: latestBookings.map(
                    (e) => UpcomingBookingsWidget(
                      name: e.userInfo.name ?? '',
                      startTime: DateFormat("hh:mm a").format(DateTime.parse(e.inTime)),
                      endTime: DateFormat("hh:mm a").format(DateTime.parse(e.outTime)),
                      date: DateFormat("dd MMMM").format(DateTime.parse(e.inTime)),
                      status: e.status == 'requested' ? 1 : e.status == 'accepted' ? 2 : 0,
                    )
                  ).toList(),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.white.withOpacity(0.2),
                ),
                Expanded(child: Calendar(roomId: widget.room.id,),),
              ]
            );
          }
        },
      ),
    );
  }
}
