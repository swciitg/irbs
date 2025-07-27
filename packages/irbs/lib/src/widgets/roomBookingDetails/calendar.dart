import 'dart:convert';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import 'package:onestop_kit/onestop_kit.dart';
import '../../globals/colors.dart';
import '../../store/common_store.dart';
import '../shimmer/calendar_shimmer.dart';
import 'package:provider/provider.dart';
import '../../models/booking_model.dart';
import '../../screens/booking_details.dart';
import '../../services/api.dart';

class Calendar extends StatefulWidget {
  final String roomId;
  const Calendar({required this.roomId, super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String month = DateFormat('MMMM').format(DateTime.now().toLocal());
  int currentMonth = DateTime.now().toLocal().month;
  int currentYear = DateTime.now().toLocal().year;

  List<CalendarEventData> getEvents(List<BookingModel> bookings) {
    List<CalendarEventData> res = [];
    for (var booking in bookings) {
      if (booking.status == 'accepted') {
        res.add(
          CalendarEventData(
            title: booking.bookingPurpose,
            date: DateTime.parse(booking.inTime),
            startTime: DateTime.parse(booking.inTime),
            color: Colors.green,
            endTime: DateTime.parse(booking.outTime),
            endDate: DateTime.parse(booking.outTime),
            description: jsonEncode(booking.toJson()),
          ),
        );
      }
    }
    return res;
  }

  EventController ctrl = EventController();
  @override
  Widget build(BuildContext context) {
    var cs = context.read<CommonStore>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Observer(
            builder: (context) {
              return cs.pending > 0
                  ? FutureBuilder(
                    future: APIService().getBookingsForCalendar(
                      roomId: widget.roomId,
                      month: currentMonth,
                      year: currentYear,
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CalendarShimmer();
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        ctrl.addAll(getEvents(snapshot.data!));
                        return WeekView(
                          weekNumberBuilder: (date) {
                            return Container();
                          },
                          hourIndicatorSettings: const HourIndicatorSettings(
                            color: Themes.subHeadingColor,
                            height: 0.7,
                          ),
                          timeLineBuilder: (date) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                DateFormat('hh a').format(date),
                                style: OnestopFonts.w500.setColor(Themes.subHeadingColor),
                              ),
                            );
                          },
                          weekDayBuilder: (date) {
                            return Column(
                              children: [
                                Text(
                                  DateFormat('EEEE').format(date).substring(0, 3),
                                  style: OnestopFonts.w500.setColor(Themes.subHeadingColor),
                                ),
                                Text(
                                  date.day.toString(),
                                  style: OnestopFonts.w500.setColor(Themes.subHeadingColor),
                                ),
                              ],
                            );
                          },
                          headerStyle: HeaderStyle(
                            headerTextStyle: TextStyle(color: Themes.white),
                            leftIconConfig: IconDataConfig(
                              icon: (_) => Icon(Icons.chevron_left, color: Themes.white),
                            ),
                            rightIconConfig: IconDataConfig(
                              icon: (_) => Icon(Icons.chevron_right, color: Themes.white),
                            ),
                            decoration: BoxDecoration(color: Themes.calenderBgColor),
                          ),
                          backgroundColor: Themes.calenderBgColor,
                          controller: ctrl,
                          onPageChange: (date, index) {
                            if (currentMonth != date.month) {
                              setState(() {
                                currentMonth = date.month;
                                currentYear = date.year;
                              });
                            }
                          },
                          minDay: DateTime(2023),
                          maxDay: DateTime(2050),
                          onEventTap: (events, date) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => BookingDetails(
                                      booking: BookingModel.fromJson(
                                        jsonDecode(events.first.description!),
                                      ),
                                    ),
                              ),
                            );
                          },
                          initialDay: DateTime.now().toLocal(),
                          startDay: WeekDays.sunday,
                        );
                      }
                    },
                  )
                  : Container();
            },
          ),
        ),
      ],
    );
  }
}
