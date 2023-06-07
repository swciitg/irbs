import 'package:flutter/material.dart';
import '../../globals/styles.dart';

import '../../globals/colors.dart';

class CurrentBookingsWidget extends StatefulWidget {
  final double status;
  final String startTime;
  final String endTime;
  final String date;
  final String roomName;
  final String? data;
  const CurrentBookingsWidget({Key? key, required this.status, required this.startTime, required this.endTime, required this.date, required this.roomName, this.data}) : super(key: key);

  @override
  State<CurrentBookingsWidget> createState() => _CurrentBookingsWidgetState();
}

class _CurrentBookingsWidgetState extends State<CurrentBookingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: [0.0125, 0.0125],
                colors: [widget.status==0 ? Color.fromRGBO(179, 38, 30, 1) : widget.status==1 ? Color.fromRGBO(83, 172, 75, 1) : Color.fromRGBO(147, 144, 148, 1), Themes.kCommonBoxBackground]
            ),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            ListTile(
              tileColor: Themes.kCommonBoxBackground,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
              ),
              title: Text(
                widget.roomName,
                style: kRequestedRoomStyle,
              ),
              subtitle: RichText(
                text: TextSpan(
                    style: kHeading3DescStyle,
                    children: [
                      TextSpan(
                        text: widget.startTime,
                      ),
                      TextSpan(
                        text: ' - ',
                      ),
                      TextSpan(
                        text: widget.endTime,
                      ),
                      TextSpan(
                        text: ' · ',
                      ),
                      TextSpan(
                        text: widget.date,
                      )
                    ]
                ),
              ),
              trailing: InkWell(
                onTap: (){

                },
                child: Container(
                  width: 88,
                  height: 24,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(42),
                  //   color: widget.status==0 ? Color.fromRGBO(179, 38, 30, 1) : Color.fromRGBO(147, 144, 148, 1),
                  // ),
                  child: Center(
                    child: Text(
                      widget.status==0 ? 'Rejected' : widget.status==1 ? 'Approved' : 'Pending',
                      style: widget.status==0 ? kRejectedStyle : widget.status==1 ? kApprovedStyle : kPendingStyle,
                    ),
                  ),
                ),
              ),
            ),
            widget.data==null ? Container()
                : Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 12),
              child: Container(
                // padding: EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 12),
                child: InputDecorator(
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.zero,
                      labelText: widget.status==0 ? 'Reason' : 'Instructions',
                      labelStyle: kLabelStyle,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.56,
                              color: Color.fromRGBO(85, 95, 113, 1)
                          ),
                          borderRadius: BorderRadius.circular(4.46)
                      )
                  ),
                  child: Text(
                    widget.data ?? '',
                    style: kReasonStyle,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
