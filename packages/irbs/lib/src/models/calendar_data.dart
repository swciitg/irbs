import 'package:irbs/src/models/booking_model.dart';

class CalendarData{
  late String eventName;
  late DateTime startTime;
  late DateTime endTime;
  late String bookingId;

  CalendarData({
    required this.bookingId,
    required this.endTime,
    required this.startTime,
    required this.eventName
  });

  CalendarData.fromBookingModel(BookingModel booking){
    eventName = booking.bookingPurpose;
    startTime = DateTime.parse(booking.inTime);
    endTime = DateTime.parse(booking.outTime);
    bookingId = booking.id;
  }
}