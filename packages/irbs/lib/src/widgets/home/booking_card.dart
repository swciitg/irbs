import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';

import '../../models/booking_model.dart';
import '../../services/api.dart';
import '../../store/data_store.dart';
import '../../store/room_detail_store.dart';

class BookingCard extends StatefulWidget {
  final BookingModel model;
  const BookingCard({super.key, required this.model});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  bool loading = false;

  Color get _statusColor {
    switch (widget.model.status) {
      case 'accepted':
        return OColor.green600;
      case 'rejected':
        return OColor.red500;
      default:
        return OColor.yellow500;
    }
  }

  Color get _statusBgColor {
    switch (widget.model.status) {
      case 'accepted':
        return OColor.green100;
      case 'rejected':
        return OColor.red100;
      default:
        return OColor.yellow100;
    }
  }

  String get _statusText {
    switch (widget.model.status) {
      case 'accepted':
        return 'APPROVED';
      case 'rejected':
        return 'REJECTED';
      default:
        return 'STATUS PENDING';
    }
  }

  bool get _isPending => widget.model.status == 'requested';

  @override
  Widget build(BuildContext context) {
    final inTime = DateTime.parse(widget.model.inTime);
    final outTime = DateTime.parse(widget.model.outTime);
    final date = DateFormat("d MMMM yyyy").format(inTime);
    final startTime = DateFormat("hh:mm a").format(inTime);
    final endTime = DateFormat("hh:mm a").format(outTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: OColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: OColor.gray200, width: 0.5),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: _statusColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.model.roomDetails.roomName,
                            style: OTextStyle.labelMedium.copyWith(
                              color: OColor.gray800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _statusBgColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _statusText,
                            style: OTextStyle.bodyXSmall.copyWith(
                              color: _statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          FluentIcons.calendar_ltr_20_regular,
                          size: 16,
                          color: OColor.gray500,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          date,
                          style: OTextStyle.bodyXSmall.copyWith(
                            color: OColor.gray600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          FluentIcons.clock_20_regular,
                          size: 16,
                          color: OColor.gray500,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$startTime - $endTime',
                          style: OTextStyle.bodyXSmall.copyWith(
                            color: OColor.gray600,
                          ),
                        ),
                      ],
                    ),
                    if (_isPending) ...[
                      const SizedBox(height: 12),
                      Center(
                        child: GestureDetector(
                          onTap: _cancelBooking,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FluentIcons.dismiss_20_regular,
                                size: 16,
                                color: OColor.red500,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Cancel Request',
                                style: OTextStyle.labelSmall.copyWith(
                                  color: OColor.red500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cancelBooking() async {
    if (loading) return;
    setState(() => loading = true);
    final store = context.read<RoomDetailStore>();
    String res = await APIService().deleteBooking(widget.model.id);
    if (res == "Success") {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking cancelled'), duration: Duration(seconds: 2)),
      );
      DataStore.upcomingFlag = false;
      await store.setUpcomingBookings();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res), duration: const Duration(seconds: 2)),
      );
      DataStore.upcomingFlag = false;
      await store.setUpcomingBookings();
    }
    if (mounted) setState(() => loading = false);
  }
}
