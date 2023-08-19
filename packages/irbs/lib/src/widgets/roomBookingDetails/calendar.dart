import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import '../../globals/colors.dart';
import '../../globals/my_fonts.dart';
import '../../models/calendar_data.dart';
import '../../store/common_store.dart';
import '../shimmer/calendar_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
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
  String month = DateFormat('MMMM').format(DateTime.now());
  int monthDigits = DateTime.now().month;
  String year = DateTime.now().year.toString();

  final _calendarController = CalendarController();
  final _datePickerController = DateRangePickerController();

  double datePickerHeight = 0;

  List<Meeting> _getDataSource(List<CalendarData> data) {
    final List<Meeting> meetings = <Meeting>[];
    for(int i = 0; i < data.length; i++){
      if(data[i].status == 'requested' || data[i].status == 'accepted'){
        meetings.add(
            Meeting(
                eventName: data[i].eventName,
                from: data[i].startTime,
                to: data[i].endTime,
                background: data[i].color,
                isAllDay: false,
                booking: data[i].booking
            )
        );
      }
    }
    return meetings;
  }
  @override
  Widget build(BuildContext context) {
    var cs = context.read<CommonStore>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: SizedBox(
            height: 20,
            width: 76,
            child: Center(
              child: Text(
                  'Select Slot',
                  style: MyFonts.w400.setColor(Themes.kSubHeading)
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
                        month = DateFormat('MMMM').format(_datePickerController.selectedDate ?? DateTime.now());
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
                          style: MyFonts.w500.size(20).setColor(Themes.white),
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
                      color: Themes.red
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
              initialSelectedDate: DateTime.now(),
              onViewChanged: (DateRangePickerViewChangedArgs args){
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  if(datePickerHeight != 0){_datePickerController.selectedDate = args.visibleDateRange.startDate;}
                  month = DateFormat('MMMM').format(args.visibleDateRange.startDate!);
                });
              },
              monthCellStyle: const DateRangePickerMonthCellStyle(
                  cellDecoration: BoxDecoration(
                      color: Themes.backgroundColor
                  ),
                  textStyle: TextStyle(
                    color: Themes.white,
                  ),
                  weekendTextStyle: TextStyle(
                      color: Themes.red
                  ),
                  todayTextStyle: TextStyle(
                      color: Themes.primaryColor
                  )
              ),
            )
        ),
        Expanded(
          child: Observer(
            builder: (context) {
              return cs.pending > 0 ? FutureBuilder(
                future: APIService().getBookingsForCalendar(
                    roomId: widget.roomId,
                    month: monthDigits,
                    year: year
                ),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return const CalendarShimmer();
                  }else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),);
                  }else{
                    // print(snapshot.data!);
                    return SfCalendar(
                      onViewChanged: (viewChangedDetails)async{
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp){

                          if(mounted) {
                            setState(() {
                              if(datePickerHeight == 0){
                                month = DateFormat('MMMM').format(viewChangedDetails.visibleDates.first);
                                monthDigits = viewChangedDetails.visibleDates.first.month;
                                year = viewChangedDetails.visibleDates.first.year.toString();
                              }
                            });
                          }
                        });
                      },
                      onTap: (calendarTapDetails) {
                        // print(calendarTapDetails.appointments?[0].eventName);
                        // print(calendarTapDetails.appointments?[0].from);
                        if(calendarTapDetails.appointments?[0]!=null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>   BookingDetails(
                                booking: calendarTapDetails.appointments?[0].booking,
                              )
                              ));
                        }
                      },
                      showDatePickerButton: true,
                      initialDisplayDate: DateTime.now(),
                      firstDayOfWeek: 1,
                      view: CalendarView.week,
                      controller: _calendarController,
                      backgroundColor: Themes.calenderBgColor,
                      cellBorderColor: Themes.kSubHeading,
                      viewHeaderStyle: const ViewHeaderStyle(
                        backgroundColor: Themes.calenderBgColor,
                        dateTextStyle: TextStyle(color: Themes.kSubHeading,),
                        dayTextStyle: TextStyle(color: Themes.kSubHeading,),
                      ),
                      todayHighlightColor: Themes.primaryColor,
                      headerDateFormat: 'MMMM',
                      headerHeight: 0,
                      headerStyle: CalendarHeaderStyle(
                        backgroundColor: Themes.backgroundColor,
                        textStyle: MyFonts.w500.size(20).setColor(Themes.white),

                      ),
                      timeSlotViewSettings: const TimeSlotViewSettings(
                        timeTextStyle: TextStyle(color: Themes.kSubHeading,),
                      ),
                      allowDragAndDrop: false,
                      dataSource: MeetingDataSource(_getDataSource(
                          snapshot.data!.map(
                                  (e) => CalendarData.fromBookingModel(e)
                          ).toList())
                      ),
                    );
                  }
                },
              ) : Container();
            }
          ),
        ),
      ],
    );
  }
}


class MeetingDataSource extends CalendarDataSource {
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

class Meeting {
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
    required this.booking,
  });

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  BookingModel booking;

}