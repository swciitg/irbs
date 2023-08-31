import 'package:flutter/material.dart';
import '../../globals/my_fonts.dart';
import '../../globals/colors.dart';
import '../roomBookingDetails/calendar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarShimmer extends StatelessWidget {
  const CalendarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Themes.allRequestShimmerHighlight,
      baseColor: Themes.allRequestShimmerBase,
      child: SfCalendar(
        showDatePickerButton: true,
        initialDisplayDate: DateTime.now(),
        firstDayOfWeek: 1,
        view: CalendarView.week,
        backgroundColor: Themes.calenderBgColor,
        cellBorderColor: Themes.subHeadingColor,
        viewHeaderStyle: const ViewHeaderStyle(
          backgroundColor: Themes.calenderBgColor,
          dateTextStyle: TextStyle(color: Themes.subHeadingColor,),
          dayTextStyle: TextStyle(color: Themes.subHeadingColor,),
        ),
        todayHighlightColor: Themes.primaryColor,
        headerDateFormat: 'MMMM',
        headerHeight: 0,            
        headerStyle: CalendarHeaderStyle(
          backgroundColor: Themes.backgroundColor,
          textStyle: MyFonts.w500.size(20).setColor(Themes.white),
      
        ),
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeTextStyle: TextStyle(color: Themes.subHeadingColor,),
        ),
        allowDragAndDrop: false,
        dataSource: MeetingDataSource([]),
      ),
    );
  }
}