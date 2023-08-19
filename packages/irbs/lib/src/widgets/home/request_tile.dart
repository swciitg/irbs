import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../globals/colors.dart';
import '../../globals/styles.dart';
import '../../globals/my_fonts.dart';
import '../../models/booking_model.dart';
import '../../store/common_store.dart';
import '../../widgets/home/respond_dialog.dart';

class RequestTile extends StatefulWidget {
  final BookingModel bookingData;
  final CommonStore commonStore;
  const RequestTile({required this.bookingData, required this.commonStore, super.key});

  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
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
                widget.bookingData.roomDetails.roomName,
                style: MyFonts.w500.size(14).setColor(Themes.permanentTextColor).copyWith(color: Themes.white, fontSize: 14*screenWidth/360),
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
                      overflow: TextOverflow.ellipsis,
                      style: MyFonts.w400.size(12).setColor(Themes.permanentTextColor).setHeight(1.33).letterSpace(0.4).copyWith(
                          fontSize: 10*screenWidth/360, color: Themes.white60,
                          height: 1
                      ),
                    ),
                  ),
                  Container(
                    height: 12*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.bookingData.userInfo.name.toString(),
                      style: MyFonts.w400.size(12).setColor(Themes.permanentTextColor).setHeight(1.33).letterSpace(0.4).copyWith(
                          fontSize: 10*screenWidth/360, color: Themes.white,
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
                      overflow: TextOverflow.ellipsis,
                      style: MyFonts.w400.size(12).setColor(Themes.permanentTextColor).setHeight(1.33).letterSpace(0.4).copyWith(
                          fontSize: 10*screenWidth/360, color: Themes.white60,
                          height: 1
                      ),
                    ),
                  ),
                  Container(
                    height: 12*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.bookingData.bookingPurpose,
                      style: MyFonts.w400.size(12).setColor(Themes.permanentTextColor).setHeight(1.33).letterSpace(0.4).copyWith(
                          fontSize: 10*screenWidth/360, color: Themes.white60,
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
                      style: MyFonts.w400.size(12).setColor(Themes.permanentTextColor).setHeight(1.33).letterSpace(0.4).copyWith(
                          fontSize: 10*screenWidth/360, color: Themes.white60,
                          height: 1
                      ),
                    ),
                  ),
                  Container(
                    height: 16*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${DateFormat('hh:mm a').format(DateTime.parse(widget.bookingData.inTime))} - ${DateFormat('hh:mm a').format(DateTime.parse(widget.bookingData.outTime))}',
                      // '10:00 AM - 02:00 PM',
                      style: MyFonts.w400.size(12).setColor(Themes.permanentTextColor).setHeight(1.33).letterSpace(0.4).copyWith(
                          fontSize: 10*screenWidth/360, color: Themes.white,
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
                      style: MyFonts.w400.size(12).setColor(Themes.permanentTextColor).setHeight(1.33).letterSpace(0.4).copyWith(
                          fontSize: 10*screenWidth/360, color: Themes.white60,
                          height: 1
                      ),
                    ),
                  ),
                  Container(
                    height: 16*screenWidth/360,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('MMMM dd, yyyy').format(DateTime.parse(widget.bookingData.inTime)),
                      style: MyFonts.w400.size(12).setColor(Themes.permanentTextColor).setHeight(1.33).letterSpace(0.4).copyWith(
                          fontSize: 10*screenWidth/360, color: Themes.white,
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
                        content: RespondDialogue(bookingData: widget.bookingData, commonStore: widget.commonStore),
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