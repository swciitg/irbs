import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';

import '../../models/booking_model.dart';
import '../../services/api.dart';

class DatePickerModal extends StatefulWidget {
  final String roomId;
  final DateTime? initialDate;

  const DatePickerModal({
    super.key,
    required this.roomId,
    this.initialDate,
  });

  @override
  State<DatePickerModal> createState() => _DatePickerModalState();
}

class _DatePickerModalState extends State<DatePickerModal> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;
  List<BookingModel> _bookings = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _currentMonth = widget.initialDate ?? DateTime.now();
    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    try {
      _bookings = await APIService().getMonthWiseRoomBookings(
        roomId: widget.roomId,
        month: _currentMonth.month.toString(),
        year: _currentMonth.year.toString(),
      );
    } catch (_) {
      _bookings = [];
    }
    if (mounted) setState(() {});
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
    _fetchBookings();
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
    _fetchBookings();
  }

  bool _dateHasBooking(int day) {
    final date = DateTime(_currentMonth.year, _currentMonth.month, day);
    return _bookings.any((b) {
      final bDate = DateTime.parse(b.inTime);
      return bDate.year == date.year &&
          bDate.month == date.month &&
          bDate.day == date.day;
    });
  }

  List<String> _getBookedTimingsForDate(DateTime? date) {
    if (date == null) return [];
    return _bookings
        .where((b) {
          final bDate = DateTime.parse(b.inTime);
          return bDate.year == date.year &&
              bDate.month == date.month &&
              bDate.day == date.day &&
              b.status == 'accepted';
        })
        .map((b) {
          final inTime = DateFormat("HH:mm").format(DateTime.parse(b.inTime));
          final outTime = DateFormat("HH:mm").format(DateTime.parse(b.outTime));
          return '$inTime - $outTime';
        })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final bookedTimings = _getBookedTimingsForDate(_selectedDate);

    return Container(
      decoration: BoxDecoration(
        color: OColor.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildMonthNav(),
          const SizedBox(height: 12),
          _buildDayHeaders(),
          const SizedBox(height: 4),
          _buildCalendarGrid(),
          const SizedBox(height: 24),
          if (bookedTimings.isNotEmpty) ...[
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
              children: bookedTimings
                  .map((t) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: OColor.gray100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          t,
                          style: OTextStyle.bodyXSmall.copyWith(
                            color: OColor.gray600,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
          ],
          _buildSelectButton(),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(FluentIcons.calendar_ltr_24_regular, color: OColor.green600, size: 28),
        const SizedBox(width: 12),
        Text(
          'Select Date',
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

  Widget _buildMonthNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _previousMonth,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: OColor.gray200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(FluentIcons.chevron_left_20_regular, color: OColor.gray600),
          ),
        ),
        Text(
          DateFormat('MMMM yyyy').format(_currentMonth),
          style: OTextStyle.labelMedium.copyWith(color: OColor.gray800),
        ),
        GestureDetector(
          onTap: _nextMonth,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: OColor.gray200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(FluentIcons.chevron_right_20_regular, color: OColor.gray600),
          ),
        ),
      ],
    );
  }

  Widget _buildDayHeaders() {
    const days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sat', 'Su'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map((d) => SizedBox(
                width: 40,
                child: Center(
                  child: Text(
                    d,
                    style: OTextStyle.bodyXSmall.copyWith(color: OColor.gray500),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    // Monday = 1, Sunday = 7
    int startWeekday = firstDay.weekday; // 1=Mon..7=Sun
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final prevMonthDays = DateTime(_currentMonth.year, _currentMonth.month, 0).day;

    final totalCells = ((startWeekday - 1) + daysInMonth);
    final rows = (totalCells / 7).ceil();

    return Column(
      children: List.generate(rows, (row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (col) {
              final cellIndex = row * 7 + col;
              final dayNum = cellIndex - (startWeekday - 1) + 1;

              if (dayNum < 1) {
                // Previous month days
                final prevDay = prevMonthDays + dayNum;
                return _buildDayCell(prevDay, isOutside: true);
              } else if (dayNum > daysInMonth) {
                // Next month days
                final nextDay = dayNum - daysInMonth;
                return _buildDayCell(nextDay, isOutside: true);
              } else {
                final date = DateTime(_currentMonth.year, _currentMonth.month, dayNum);
                final isSelected = _selectedDate != null &&
                    _selectedDate!.year == date.year &&
                    _selectedDate!.month == date.month &&
                    _selectedDate!.day == date.day;
                final hasBooking = _dateHasBooking(dayNum);
                final isPast = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

                return _buildDayCell(
                  dayNum,
                  isSelected: isSelected,
                  hasBooking: hasBooking,
                  isPast: isPast,
                  onTap: isPast
                      ? null
                      : () {
                          setState(() => _selectedDate = date);
                        },
                );
              }
            }),
          ),
        );
      }),
    );
  }

  Widget _buildDayCell(
    int day, {
    bool isOutside = false,
    bool isSelected = false,
    bool hasBooking = false,
    bool isPast = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: isSelected
                  ? BoxDecoration(
                      color: OColor.green600,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Center(
                child: Text(
                  '$day',
                  style: OTextStyle.bodySmall.copyWith(
                    color: isOutside || isPast
                        ? OColor.gray300
                        : isSelected
                            ? OColor.white
                            : OColor.gray800,
                  ),
                ),
              ),
            ),
            if (hasBooking && !isOutside)
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: OColor.green600,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _selectedDate != null
            ? () => Navigator.pop(context, _selectedDate)
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
            color: _selectedDate != null ? Colors.white : OColor.gray400,
          ),
        ),
      ),
    );
  }
}
