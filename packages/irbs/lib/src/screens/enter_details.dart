import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';

import '../models/booking_model.dart';
import '../models/room_model.dart';
import '../services/api.dart';
import '../store/room_detail_store.dart';
import '../widgets/roomBookingDetails/booking_success_dailogue.dart';
import '../widgets/roomBookingDetails/date_picker_modal.dart';
import '../widgets/roomBookingDetails/time_picker_modal.dart';

class EnterDetailsScreen extends StatefulWidget {
  final RoomModel room;

  const EnterDetailsScreen({super.key, required this.room});

  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  final TextEditingController _reasonCtl = TextEditingController();
  bool _isLoading = false;
  List<BookingModel> _bookingsForDate = [];

  String get _dateDisplay {
    if (_selectedDate == null) return 'Value';
    return DateFormat('d MMMM yyyy').format(_selectedDate!);
  }

  String get _timeDisplay {
    if (_startTime == null || _endTime == null) return 'Value';
    final start = _formatTimeOfDay(_startTime!);
    final end = _formatTimeOfDay(_endTime!);
    return '$start - $end';
  }

  String _formatTimeOfDay(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _openDatePicker() async {
    final result = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DatePickerModal(
            roomId: widget.room.id,
            initialDate: _selectedDate,
          ),
    );
    if (result != null) {
      setState(() => _selectedDate = result);
      await _fetchBookingsForDate();
    }
  }

  Future<void> _fetchBookingsForDate() async {
    if (_selectedDate == null) return;
    try {
      final bookings = await APIService().getMonthWiseRoomBookings(
        roomId: widget.room.id,
        month: _selectedDate!.month.toString(),
        year: _selectedDate!.year.toString(),
      );
      _bookingsForDate =
          bookings.where((b) {
            final bDate = DateTime.parse(b.inTime);
            return bDate.year == _selectedDate!.year &&
                bDate.month == _selectedDate!.month &&
                bDate.day == _selectedDate!.day;
          }).toList();
    } catch (_) {
      _bookingsForDate = [];
    }
  }

  Future<void> _openTimePicker() async {
    if (_selectedDate == null) {
      Fluttertoast.showToast(
        msg: "Please select a date first",
        backgroundColor: OColor.gray800,
      );
      return;
    }

    final result = await showModalBottomSheet<Map<String, TimeOfDay>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TimePickerModal(bookingsForDate: _bookingsForDate),
    );
    if (result != null) {
      setState(() {
        _startTime = result['startTime'];
        _endTime = result['endTime'];
      });
    }
  }

  Future<void> _submitBooking() async {
    if (_selectedDate == null || _startTime == null || _endTime == null) {
      Fluttertoast.showToast(
        msg: "Please select date and time",
        backgroundColor: OColor.gray800,
      );
      return;
    }

    if (_reasonCtl.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter a reason for booking",
        backgroundColor: OColor.gray800,
      );
      return;
    }

    var inTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _startTime!.hour,
      _startTime!.minute,
    );
    var outTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _endTime!.hour,
      _endTime!.minute,
    );

    if (inTime.isBefore(DateTime.now())) {
      Fluttertoast.showToast(
        msg: "Start time has passed",
        backgroundColor: OColor.gray800,
      );
      return;
    }

    if (outTime.isBefore(inTime) || outTime.isAtSameMomentAs(inTime)) {
      Fluttertoast.showToast(
        msg: "Please enter a valid time range",
        backgroundColor: OColor.gray800,
      );
      return;
    }

    setState(() => _isLoading = true);

    var details = jsonEncode({
      "roomId": widget.room.id.toString(),
      "inTime": inTime.toIso8601String(),
      "outTime": outTime.toIso8601String(),
      "bookingPurpose": _reasonCtl.text,
    });

    var response = await APIService().createBooking(details);
    if (response == "Success") {
      if (!mounted) return;
      var rd = context.read<RoomDetailStore>();
      await rd.setUpcomingBookings();
      if (!mounted) return;
      await showSuccessDialog(context);
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      setState(() => _isLoading = false);
      if (response.contains('400')) {
        Fluttertoast.showToast(
          msg: "Slot already booked",
          backgroundColor: OColor.gray800,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Some error occurred, try again later",
          backgroundColor: OColor.gray800,
        );
      }
    }
  }

  @override
  void dispose() {
    _reasonCtl.dispose();
    super.dispose();
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
          icon: Icon(TablerIcons.arrow_left, color: OColor.gray800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.room.roomName,
          style: OTextStyle.headingSmall.copyWith(color: OColor.gray800),
        ),
        backgroundColor: OColor.gray200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Enter details',
                      style: OTextStyle.headingLarge.copyWith(
                        color: OColor.gray800,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Select Date',
                      style: OTextStyle.labelSmall.copyWith(
                        color: OColor.gray800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildSelectorField(
                      value: _dateDisplay,
                      onTap: _openDatePicker,
                      hasValue: _selectedDate != null,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Select Time',
                      style: OTextStyle.labelSmall.copyWith(
                        color: OColor.gray800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildSelectorField(
                      value: _timeDisplay,
                      onTap: _openTimePicker,
                      hasValue: _startTime != null,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Reason for Booking',
                      style: OTextStyle.labelSmall.copyWith(
                        color: OColor.gray800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: OColor.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: OColor.gray200),
                      ),
                      child: TextField(
                        controller: _reasonCtl,
                        maxLines: 5,
                        style: OTextStyle.bodySmall.copyWith(
                          color: OColor.gray800,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Context',
                          hintStyle: OTextStyle.bodySmall.copyWith(
                            color: OColor.gray400,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: OColor.green600,
                  disabledBackgroundColor: OColor.gray200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                          'Select',
                          style: OTextStyle.labelMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectorField({
    required String value,
    required VoidCallback onTap,
    required bool hasValue,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: OColor.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasValue ? OColor.green600 : OColor.gray200,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: OTextStyle.bodySmall.copyWith(color: OColor.green600),
            ),
            Icon(TablerIcons.chevron_right, color: OColor.green600, size: 20),
          ],
        ),
      ),
    );
  }
}
