import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String month = DateFormat('MMMM').format(DateTime.now());

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting('HackStack', DateTime(2023, 6, 1, 14), DateTime(2023, 6, 1, 17), Colors.red, false));
    return meetings;
  }

  final _calendarController = CalendarController();
  final _datePickerController = DateRangePickerController();

  double datePickerHeight = 0;

  @override
  Widget build(BuildContext context) {
    List<Meeting> meetings = _getDataSource();
    MeetingDataSource source = MeetingDataSource(meetings);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: SizedBox(
            height: 20,
            width: 76,
            child: Center(
              child: Text(
                'Select Slot',
                style: subHeadingStyle
              ),
            ),
          ),
        ),
        SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  if(mounted){
                    setState(() {
                      if(datePickerHeight == 0){
                        month = DateFormat('MMMM').format(_datePickerController.selectedDate!);
                        datePickerHeight = 350;
                      }else{
                        month = DateFormat('MMMM').format(_calendarController.displayDate!);
                        datePickerHeight = 0;
                      }
                      
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 20, 20),
                  child: SizedBox(
                    height: 28,
                    child: Row(
                      children: [
                        Text(
                          month,
                          style: appBarStyle,
                        ),
                        const SizedBox(width: 8,),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Center(
                            child: SizedBox(
                              height: 9,
                              width: 16,
                              child: Image.asset(
                                'assets/images/chevron.png',
                                fit: BoxFit.contain,
                                package: 'irbs',
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(_calendarController.view == CalendarView.week){
                    _calendarController.view = CalendarView.month;
                  }
                  else if(_calendarController.view == CalendarView.month) {
                    _calendarController.view = CalendarView.week;
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 20, 20),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: Image.asset(
                        'assets/images/calendar.png',
                        fit: BoxFit.contain,
                        package: 'irbs',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        AnimatedContainer(
          height: datePickerHeight,
          duration: const Duration(milliseconds: 300),
          child: SfDateRangePicker(
            selectionColor: Themes.primaryColor,
            selectionRadius: 15,
            selectionTextStyle: const TextStyle(
              color: Themes.onPrimaryColor
            ),
            headerStyle: const DateRangePickerHeaderStyle(
              textStyle: TextStyle(
                color: Colors.red
              )
            ),
            headerHeight: 0,
            monthViewSettings: const DateRangePickerMonthViewSettings(
              firstDayOfWeek: 1,
              viewHeaderHeight: 40,
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: TextStyle(
                  color: Themes.blueGrey,
                )
              )
            ),
            controller: _datePickerController,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              _calendarController.displayDate = args.value;
            },
            onViewChanged: (DateRangePickerViewChangedArgs args){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                _datePickerController.selectedDate = args.visibleDateRange.startDate;
                month = DateFormat('MMMM').format(args.visibleDateRange.startDate!);
              });
            },
            monthCellStyle: const DateRangePickerMonthCellStyle(
              cellDecoration: BoxDecoration(
                color: Themes.backgroundColor
              ),
              textStyle: TextStyle(
                color: Colors.white,
              ),
              weekendTextStyle: TextStyle(
                color: Colors.red
              ),
              todayTextStyle: TextStyle(
                color: Themes.primaryColor
              )
            ),
          )
        ),
        Expanded(
          child: SfCalendar(
            onViewChanged: (viewChangedDetails){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp){
                if(mounted) {
                  setState(() {
                  if(datePickerHeight == 0){
                    month = DateFormat('MMMM').format(viewChangedDetails.visibleDates.first);
                  }
                });
                }
              });
            },
            showDatePickerButton: true,
            initialDisplayDate: DateTime.now(),
            firstDayOfWeek: 1,
            view: CalendarView.week,
            controller: _calendarController,
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
            dataSource: source,
          ),
        ),
      ],
    );
  }
}



/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}