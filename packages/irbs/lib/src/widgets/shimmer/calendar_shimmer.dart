import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import '../../globals/colors.dart';
import 'package:shimmer/shimmer.dart';

class CalendarShimmer extends StatelessWidget {
  const CalendarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Themes.allRequestShimmerHighlight,
      baseColor: Themes.allRequestShimmerBase,
      child: WeekView(
        backgroundColor: Themes.calenderBgColor,
        controller: EventController(),
        showLiveTimeLineInAllDays:
        true, // To display live time line in all pages in week view.
        minDay: DateTime(2023),
        maxDay: DateTime(2050),
        initialDay: DateTime.now().toLocal(),
        heightPerMinute:
        0.6, // height occupied by 1 minute time span.
        startDay: WeekDays.monday, // To change the first day of the week.
      )

    );
  }
}