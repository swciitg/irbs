import '../globals/colors.dart';
import 'booking_model.dart';
import 'package:flutter/material.dart';

class CalendarData {
  late String eventName;
  late DateTime startTime;
  late DateTime endTime;
  late String bookingId;
  late Color color;
  late String status;
  late BookingModel booking;
  CalendarData(
      {required this.bookingId,
      required this.endTime,
      required this.startTime,
      required this.eventName,
      required this.color,
      required this.status,
      required this.booking});

  CalendarData.fromBookingModel(this.booking) {
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
