import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/models/booking_model.dart';
import 'package:flutter/material.dart';

class CalendarData{
  late String eventName;
  late DateTime startTime;
  late DateTime endTime;
  late String bookingId;
  late Color color;
  late String status;

  CalendarData({
    required this.bookingId,
    required this.endTime,
    required this.startTime,
    required this.eventName,
    required this.color,
    required this.status
  });

  CalendarData.fromBookingModel(BookingModel booking){
    eventName = booking.bookingPurpose;
    startTime = DateTime.parse(booking.inTime);
    endTime = DateTime.parse(booking.outTime);
    bookingId = booking.id;
    status = booking.status;
    color = booking.status == 'requested' 
      ? Themes.pendingColor 
      : booking.status == 'accepted' 
        ? Themes.approvedGreenColor
        : Themes.rejectedColor;
  }
}