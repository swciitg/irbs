import 'package:flutter/material.dart';
import 'package:onestop_ui/index.dart';

import '../../globals/colors.dart';

class UpcomingBookingsWidget extends StatefulWidget {
  final int status;
  final String startTime;
  final String endTime;
  final String date;
  final String name;
  const UpcomingBookingsWidget({
    super.key,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.name,
  });

  @override
  State<UpcomingBookingsWidget> createState() => _UpcomingBookingsWidgetState();
}

class _UpcomingBookingsWidgetState extends State<UpcomingBookingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0.0125, 0.0125],
            colors: [
              (widget.status == 0)
                  ? Themes.rejectedColor
                  : (widget.status == 1)
                  ? Themes.pendingColor
                  : Themes.approvedColor,
              Themes.kCommonBoxBackground,
            ],
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListTile(
          tileColor: Themes.kCommonBoxBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: Text(
            widget.name,
            overflow: TextOverflow.ellipsis,
            style: OTextStyle.labelSmall.copyWith(color: Themes.white),
          ),
          subtitle: RichText(
            text: TextSpan(
              style: OTextStyle.bodyXSmall.copyWith(color: Themes.white),
              children: [
                TextSpan(text: widget.startTime),
                const TextSpan(text: ' - '),
                TextSpan(text: widget.endTime),
                const TextSpan(text: ' · '),
                TextSpan(text: widget.date),
              ],
            ),
          ),
          trailing: InkWell(
            onTap: () {},
            child: SizedBox(
              width: 88,
              height: 24,
              child: Center(
                child: Text(
                  (widget.status == 0)
                      ? 'Rejected'
                      : (widget.status == 1)
                      ? 'Pending'
                      : 'Approved',
                  style:
                      (widget.status == 0)
                          ? OTextStyle.labelXSmall.copyWith(color: Themes.white)
                          : (widget.status == 1)
                          ? OTextStyle.labelSmall.copyWith(color: Themes.pendingColor)
                          : OTextStyle.labelSmall.copyWith(color: Themes.approvedColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
