import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/widgets/home/respond_dialog.dart';
import 'package:irbs/src/models/owned_room_booking.dart';

class Request extends StatelessWidget {
  final OwnedRoomBooking bookingData;
  const Request({required this.bookingData, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenWidth*167/360,
      width: screenWidth*304/360,
      decoration: BoxDecoration(
        color: Themes.requestTile,
        borderRadius: BorderRadius.circular(screenWidth*4/360)
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16*screenWidth/360,
            top: 10*screenWidth/360,
            child: Container(
              alignment: Alignment.centerLeft,
              height: screenWidth*24/360,
              child: Text(
                bookingData.roomDetails.roomName,
                style: permanentTextStyle.copyWith(color: Colors.white, fontSize: 14*screenWidth/360),
              ),
            ),
          ),
          Positioned(
            left: 16*screenWidth/360,
            top: 42*screenWidth/360,
            child: SizedBox(
              height: 27*screenWidth/360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Request by -',
                      style: labelTextStyle.copyWith(
                        fontSize: 10*screenWidth/360, color: Colors.white60,
                        height: 1
                      ),
                    ),
                  ),
                  Container(
                    height: 12*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bookingData.user,
                      style: labelTextStyle.copyWith(
                        fontSize: 10*screenWidth/360, color: Colors.white,
                        height: 1
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 168*screenWidth/360,
            top: 42*screenWidth/360,
            child: SizedBox(
              height: 27*screenWidth/360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Purpose -',
                      style: labelTextStyle.copyWith(
                        fontSize: 10*screenWidth/360, color: Colors.white60,
                        height: 1
                      ),
                    ),
                  ),
                  Container(
                    height: 12*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bookingData.bookingPurpose,
                      style: labelTextStyle.copyWith(
                        fontSize: 10*screenWidth/360, color: Colors.white,
                        height: 1
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 16*screenWidth/360,
            top: 77*screenWidth/360,
            child: SizedBox(
              height: 30*screenWidth/360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Time Slot -',
                      style: labelTextStyle.copyWith(
                        fontSize: 10*screenWidth/360, color: Colors.white60,
                        height: 1
                      ),
                    ),
                  ),
                  Container(
                    height: 16*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${DateFormat('hh:mm a').format(DateTime.parse(bookingData.inTime))} - ${DateFormat('hh:mm a').format(DateTime.parse(bookingData.outTime))}',
                      // '10:00 AM - 02:00 PM',
                      style: labelTextStyle.copyWith(
                        fontSize: 10*screenWidth/360, color: Colors.white,
                        height: 1
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 168*screenWidth/360,
            top: 77*screenWidth/360,
            child: SizedBox(
              height: 30*screenWidth/360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Date -',
                      style: labelTextStyle.copyWith(
                        fontSize: 10*screenWidth/360, color: Colors.white60,
                        height: 1
                      ),
                    ),
                  ),
                  Container(
                    height: 16*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('MMMM dd, yyyy').format(DateTime.parse(bookingData.inTime)),
                      style: labelTextStyle.copyWith(
                        fontSize: 10*screenWidth/360, color: Colors.white,
                        height: 1
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 12*screenWidth/360,
            left: 16*screenWidth/360,
            child: SizedBox(
              width: 272*screenWidth/360,
              height: 32*screenWidth/360,
              child: ElevatedButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        content: RespondDialog(bookingData: bookingData,),
                      );
                    },
                  );
                },
                style: elevatedButtonStyle.copyWith(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                    ),
                  ),
                ),
                child: const Text('Respond')
              ),
            ),
          )
        ],
      ),
    );
  }
}