import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';

import '../models/booking_model.dart';
import '../models/room_model.dart';
import '../services/api.dart';
import 'booking_details.dart';

class RoomScheduleScreen extends StatefulWidget {
  final RoomModel room;
  const RoomScheduleScreen({super.key, required this.room});

  @override
  State<RoomScheduleScreen> createState() => _RoomScheduleScreenState();
}

class _RoomScheduleScreenState extends State<RoomScheduleScreen> {
  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;
  List<BookingModel> _allBookings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    setState(() => _loading = true);
    try {
      _allBookings = await APIService().getBookingsForCalendar(
        roomId: widget.room.id,
        month: _currentMonth,
        year: _currentYear,
      );
    } catch (_) {
      _allBookings = [];
    }
    if (mounted) setState(() => _loading = false);
  }

  List<CalendarEventData> _getEvents() {
    List<CalendarEventData> res = [];
    for (var booking in _allBookings) {
      if (booking.status == 'accepted') {
        res.add(
          CalendarEventData(
            title: booking.userInfo.name ?? booking.bookingPurpose,
            date: DateTime.parse(booking.inTime),
            startTime: DateTime.parse(booking.inTime),
            color: OColor.green600,
            endTime: DateTime.parse(booking.outTime),
            endDate: DateTime.parse(booking.outTime),
            description: jsonEncode(booking.toJson()),
          ),
        );
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColor.gray100,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(FluentIcons.arrow_left_24_regular, color: OColor.gray800),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "IRBS",
          style: OTextStyle.headingSmall.copyWith(color: OColor.gray800),
        ),
        backgroundColor: OColor.gray100,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator(color: OColor.green600))
          : _buildWeekView(),
    );
  }

  Widget _buildWeekView() {
    final ctrl = EventController();
    ctrl.addAll(_getEvents());
    return WeekView(
      weekNumberBuilder: (date) => const SizedBox(),
      hourIndicatorSettings: HourIndicatorSettings(
        color: OColor.gray200,
        height: 0.5,
      ),
      timeLineBuilder: (date) {
        return Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            DateFormat('hh a').format(date),
            style: OTextStyle.bodyXSmall.copyWith(color: OColor.gray500),
          ),
        );
      },
      weekDayBuilder: (date) {
        final isToday = date.year == DateTime.now().year &&
            date.month == DateTime.now().month &&
            date.day == DateTime.now().day;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          decoration: isToday
              ? BoxDecoration(
                  color: OColor.green600,
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('EEE').format(date),
                style: OTextStyle.bodyXSmall.copyWith(
                  color: isToday ? Colors.white : OColor.gray500,
                ),
              ),
              Text(
                date.day.toString(),
                style: OTextStyle.labelSmall.copyWith(
                  color: isToday ? Colors.white : OColor.gray800,
                ),
              ),
            ],
          ),
        );
      },
      weekPageHeaderBuilder: (startDate, endDate) {
        return Container(
          color: OColor.gray100,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${DateFormat('d MMM').format(startDate)} - ${DateFormat('d MMM yyyy').format(endDate)}',
                style: OTextStyle.labelMedium.copyWith(color: OColor.gray800),
              ),
            ],
          ),
        );
      },
      headerStyle: HeaderStyle(
        headerTextStyle: OTextStyle.labelMedium.copyWith(color: OColor.gray800),
        leftIconConfig: IconDataConfig(
          icon: (_) => Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: OColor.gray200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(FluentIcons.chevron_left_20_regular, color: OColor.gray600, size: 18),
          ),
        ),
        rightIconConfig: IconDataConfig(
          icon: (_) => Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: OColor.gray200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(FluentIcons.chevron_right_20_regular, color: OColor.gray600, size: 18),
          ),
        ),
        decoration: BoxDecoration(color: OColor.gray100),
      ),
      backgroundColor: OColor.white,
      controller: ctrl,
      onPageChange: (date, index) {
        if (_currentMonth != date.month) {
          _currentMonth = date.month;
          _currentYear = date.year;
          _fetchBookings();
        }
      },
      minDay: DateTime(2023),
      maxDay: DateTime(2050),
      eventTileBuilder: (date, events, boundary, startDuration, endDuration) {
        if (events.isEmpty) return const SizedBox();
        final event = events.first;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: OColor.green600.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
            border: Border(
              left: BorderSide(color: OColor.green600, width: 3),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                event.title,
                style: OTextStyle.bodyXSmall.copyWith(
                  color: OColor.green600,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (event.startTime != null && event.endTime != null)
                Text(
                  '${DateFormat('hh:mm a').format(event.startTime!)} - ${DateFormat('hh:mm a').format(event.endTime!)}',
                  style: OTextStyle.bodyXSmall.copyWith(
                    color: OColor.green600.withValues(alpha: 0.7),
                    fontSize: 9,
                  ),
                  maxLines: 1,
                ),
            ],
          ),
        );
      },
      onEventTap: (events, date) {
        if (events.isEmpty) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingDetails(
              booking: BookingModel.fromJson(
                jsonDecode(events.first.description!),
              ),
            ),
          ),
        );
      },
      initialDay: DateTime.now(),
      startDay: WeekDays.sunday,
    );
  }
}
