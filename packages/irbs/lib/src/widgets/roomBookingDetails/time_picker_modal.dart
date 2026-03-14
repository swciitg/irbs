import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';

import '../../models/booking_model.dart';

class TimePickerModal extends StatefulWidget {
  final List<BookingModel> bookingsForDate;

  const TimePickerModal({
    super.key,
    required this.bookingsForDate,
  });

  @override
  State<TimePickerModal> createState() => _TimePickerModalState();
}

class _TimePickerModalState extends State<TimePickerModal> {
  int _startHour = 9;
  int _startMinute = 0;
  bool _isAM = true;

  int _endHour = 10;
  int _endMinute = 0;
  bool _endIsAM = true;

  int? _selectedDurationIndex;
  bool _isCustom = false;

  final List<Map<String, dynamic>> _durations = [
    {'label': '30 mins', 'minutes': 30},
    {'label': '1 hr', 'minutes': 60},
    {'label': '2 hrs', 'minutes': 120},
    {'label': '3 hrs', 'minutes': 180},
    {'label': '4 hrs', 'minutes': 240},
    {'label': 'Custom', 'minutes': 0},
  ];

  List<String> get _bookedTimings {
    return widget.bookingsForDate
        .where((b) => b.status == 'accepted')
        .map((b) {
      final inTime = DateFormat("HH:mm").format(DateTime.parse(b.inTime));
      final outTime = DateFormat("HH:mm").format(DateTime.parse(b.outTime));
      return '$inTime - $outTime';
    }).toList();
  }

  void _incrementStartHour() {
    setState(() {
      _startHour = (_startHour % 12) + 1;
    });
  }

  void _decrementStartHour() {
    setState(() {
      _startHour = _startHour <= 1 ? 12 : _startHour - 1;
    });
  }

  void _incrementStartMinute() {
    setState(() {
      _startMinute = (_startMinute + 15) % 60;
    });
  }

  void _decrementStartMinute() {
    setState(() {
      _startMinute = _startMinute < 15 ? 45 : _startMinute - 15;
    });
  }

  void _toggleStartAMPM() {
    setState(() => _isAM = !_isAM);
  }

  void _incrementEndHour() {
    setState(() {
      _endHour = (_endHour % 12) + 1;
    });
  }

  void _decrementEndHour() {
    setState(() {
      _endHour = _endHour <= 1 ? 12 : _endHour - 1;
    });
  }

  void _incrementEndMinute() {
    setState(() {
      _endMinute = (_endMinute + 15) % 60;
    });
  }

  void _decrementEndMinute() {
    setState(() {
      _endMinute = _endMinute < 15 ? 45 : _endMinute - 15;
    });
  }

  void _toggleEndAMPM() {
    setState(() => _endIsAM = !_endIsAM);
  }

  void _selectDuration(int index) {
    setState(() {
      _selectedDurationIndex = index;
      if (index == 5) {
        _isCustom = true;
      } else {
        _isCustom = false;
        // Calculate end time from start + duration
        final durationMinutes = _durations[index]['minutes'] as int;
        int start24Hour = _isAM ? (_startHour == 12 ? 0 : _startHour) : (_startHour == 12 ? 12 : _startHour + 12);
        int totalMinutes = start24Hour * 60 + _startMinute + durationMinutes;
        int endHour24 = (totalMinutes ~/ 60) % 24;
        int endMin = totalMinutes % 60;
        _endIsAM = endHour24 < 12;
        _endHour = endHour24 == 0 ? 12 : (endHour24 > 12 ? endHour24 - 12 : endHour24);
        _endMinute = endMin;
      }
    });
  }

  TimeOfDay _getStartTime() {
    int hour24 = _isAM ? (_startHour == 12 ? 0 : _startHour) : (_startHour == 12 ? 12 : _startHour + 12);
    return TimeOfDay(hour: hour24, minute: _startMinute);
  }

  TimeOfDay _getEndTime() {
    int hour24 = _endIsAM ? (_endHour == 12 ? 0 : _endHour) : (_endHour == 12 ? 12 : _endHour + 12);
    return TimeOfDay(hour: hour24, minute: _endMinute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: OColor.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            Text(
              'START TIME',
              style: OTextStyle.bodyXSmall.copyWith(
                color: OColor.gray500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            _buildTimeSpinner(
              hour: _startHour,
              minute: _startMinute,
              isAM: _isAM,
              onIncrementHour: _incrementStartHour,
              onDecrementHour: _decrementStartHour,
              onIncrementMinute: _incrementStartMinute,
              onDecrementMinute: _decrementStartMinute,
              onToggleAMPM: _toggleStartAMPM,
            ),
            const SizedBox(height: 24),
            Text(
              'BOOKING DURATION',
              style: OTextStyle.bodyXSmall.copyWith(
                color: OColor.gray500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            _buildDurationButtons(),
            if (_isCustom) ...[
              const SizedBox(height: 24),
              Text(
                'END TIME',
                style: OTextStyle.bodyXSmall.copyWith(
                  color: OColor.gray500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              _buildTimeSpinner(
                hour: _endHour,
                minute: _endMinute,
                isAM: _endIsAM,
                onIncrementHour: _incrementEndHour,
                onDecrementHour: _decrementEndHour,
                onIncrementMinute: _incrementEndMinute,
                onDecrementMinute: _decrementEndMinute,
                onToggleAMPM: _toggleEndAMPM,
              ),
            ],
            if (_bookedTimings.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                'ALREADY BOOKED FOR THESE TIMINGS',
                style: OTextStyle.bodyXSmall.copyWith(
                  color: OColor.gray500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _bookedTimings
                    .map((t) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: OColor.gray100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            t,
                            style: OTextStyle.bodyXSmall.copyWith(color: OColor.gray600),
                          ),
                        ))
                    .toList(),
              ),
            ],
            const SizedBox(height: 24),
            _buildSelectButton(),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(FluentIcons.clock_24_regular, color: OColor.green600, size: 28),
        const SizedBox(width: 12),
        Text(
          'Select Time',
          style: OTextStyle.labelMedium.copyWith(color: OColor.gray800),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(FluentIcons.dismiss_24_regular, color: OColor.gray500),
        ),
      ],
    );
  }

  Widget _buildTimeSpinner({
    required int hour,
    required int minute,
    required bool isAM,
    required VoidCallback onIncrementHour,
    required VoidCallback onDecrementHour,
    required VoidCallback onIncrementMinute,
    required VoidCallback onDecrementMinute,
    required VoidCallback onToggleAMPM,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSpinnerColumn(
          value: hour.toString().padLeft(2, '0'),
          aboveValue: ((hour % 12) == 0 ? 11 : hour - 1).toString().padLeft(2, '0'),
          belowValue: ((hour % 12) + 1).toString().padLeft(2, '0'),
          onIncrement: onIncrementHour,
          onDecrement: onDecrementHour,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            ':',
            style: OTextStyle.displayXSmall.copyWith(color: OColor.gray800),
          ),
        ),
        _buildSpinnerColumn(
          value: minute.toString().padLeft(2, '0'),
          aboveValue: ((minute - 15 + 60) % 60).toString().padLeft(2, '0'),
          belowValue: ((minute + 15) % 60).toString().padLeft(2, '0'),
          onIncrement: onIncrementMinute,
          onDecrement: onDecrementMinute,
        ),
        const SizedBox(width: 16),
        _buildSpinnerColumn(
          value: isAM ? 'AM' : 'PM',
          aboveValue: isAM ? 'PM' : 'AM',
          belowValue: isAM ? 'PM' : 'AM',
          onIncrement: onToggleAMPM,
          onDecrement: onToggleAMPM,
          isText: true,
        ),
      ],
    );
  }

  Widget _buildSpinnerColumn({
    required String value,
    required String aboveValue,
    required String belowValue,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
    bool isText = false,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onDecrement,
          child: Icon(FluentIcons.chevron_up_24_regular, color: OColor.gray400, size: 24),
        ),
        Text(
          aboveValue,
          style: OTextStyle.bodySmall.copyWith(color: OColor.gray300),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: OTextStyle.displayXSmall.copyWith(color: OColor.gray800),
        ),
        const SizedBox(height: 4),
        Text(
          belowValue,
          style: OTextStyle.bodySmall.copyWith(color: OColor.gray300),
        ),
        GestureDetector(
          onTap: onIncrement,
          child: Icon(FluentIcons.chevron_down_24_regular, color: OColor.gray400, size: 24),
        ),
      ],
    );
  }

  Widget _buildDurationButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_durations.length, (index) {
        final isSelected = _selectedDurationIndex == index;
        return GestureDetector(
          onTap: () => _selectDuration(index),
          child: Container(
            width: (MediaQuery.of(context).size.width - 48) / 3 - 6,
            height: 36,
            decoration: BoxDecoration(
              color: isSelected ? OColor.green600 : OColor.white,
              border: Border.all(
                color: isSelected ? OColor.green600 : OColor.gray200,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                _durations[index]['label'],
                style: OTextStyle.bodySmall.copyWith(
                  color: isSelected ? Colors.white : OColor.gray800,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSelectButton() {
    final bool canSelect = _selectedDurationIndex != null;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: canSelect
            ? () {
                Navigator.pop(context, {
                  'startTime': _getStartTime(),
                  'endTime': _getEndTime(),
                });
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: OColor.green600,
          disabledBackgroundColor: OColor.gray200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Select',
          style: OTextStyle.labelMedium.copyWith(
            color: canSelect ? Colors.white : OColor.gray400,
          ),
        ),
      ),
    );
  }
}
