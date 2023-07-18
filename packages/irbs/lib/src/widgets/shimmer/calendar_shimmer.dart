import 'package:flutter/material.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/widgets/roomBookingDetails/calendar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarShimmer extends StatelessWidget {
  const CalendarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: const Color.fromRGBO(68, 71, 79, 1),
      baseColor: const Color.fromRGBO(47, 48, 51, 1),
      child: SfCalendar(
        showDatePickerButton: true,
        initialDisplayDate: DateTime.now(),
        firstDayOfWeek: 1,
        view: CalendarView.week,
        backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
        cellBorderColor: const Color.fromRGBO(135, 145, 165, 1),
        viewHeaderStyle: const ViewHeaderStyle(
          backgroundColor: Color.fromRGBO(35, 35, 35, 1),
          dateTextStyle: TextStyle(color: Color.fromRGBO(135, 145, 165, 1),),
          dayTextStyle: TextStyle(color: Color.fromRGBO(135, 145, 165, 1),),
        ),
        todayHighlightColor: Themes.primaryColor,
        headerDateFormat: 'MMMM',
        headerHeight: 0,            
        headerStyle: const CalendarHeaderStyle(
          backgroundColor: Themes.backgroundColor,
          textStyle: appBarStyle,
      
        ),
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeTextStyle: TextStyle(color: Color.fromRGBO(135, 145, 165, 1),),
        ),
        allowDragAndDrop: false,
        dataSource: MeetingDataSource([]),
      ),
    );
  }
}