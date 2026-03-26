import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';

import '../../models/booking_model.dart';
import '../../models/room_model.dart';
import '../../screens/enter_details.dart';
import '../../screens/room_schedule.dart';
import '../../screens/room_details/room_details.dart';
import '../../services/api.dart';
import '../../store/common_store.dart';
import '../../store/data_store.dart';
import '../../store/room_detail_store.dart';
import './contact_dialog.dart';

Future<void> showRoomDetailPopup(BuildContext context, RoomModel room) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return _RoomDetailContent(
              room: room,
              scrollController: scrollController,
            );
          },
        ),
  );
}

class _RoomDetailContent extends StatefulWidget {
  final RoomModel room;
  final ScrollController scrollController;

  const _RoomDetailContent({
    required this.room,
    required this.scrollController,
  });

  @override
  State<_RoomDetailContent> createState() => _RoomDetailContentState();
}

class _RoomDetailContentState extends State<_RoomDetailContent> {
  List<BookingModel> _currentBookings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    try {
      final bookings = await APIService().getBookingsForCalendar(
        roomId: widget.room.id,
        month: DateTime.now().month,
        year: DateTime.now().year,
      );
      final now = DateTime.now();
      _currentBookings =
          bookings
              .where(
                (b) =>
                    b.status == 'accepted' &&
                    DateTime.parse(b.outTime).isAfter(now),
              )
              .toList()
            ..sort((a, b) => a.inTime.compareTo(b.inTime));
      if (_currentBookings.length > 2) {
        _currentBookings = _currentBookings.sublist(0, 2);
      }
    } catch (_) {
      _currentBookings = [];
    }
    if (mounted) setState(() => _loading = false);
  }

  bool get _isAdmin {
    final userEmail = DataStore.userData['outlookEmail'];
    return userEmail != null && widget.room.owner.contains(userEmail);
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.read<CommonStore>();
    return Container(
      decoration: BoxDecoration(
        color: OColor.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: ListView(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildImagePlaceholder(),
          const SizedBox(height: 16),
          _buildActionButtons(cs),
          const SizedBox(height: 24),
          _buildCapacity(),
          const SizedBox(height: 24),
          _buildInstructions(),
          const SizedBox(height: 24),
          _buildCurrentBookings(),
          const SizedBox(height: 24),
          _buildPOCs(),
          if (_isAdmin) ...[const SizedBox(height: 24), _buildAdminControls()],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.room.roomName,
            style: OTextStyle.headingMedium.copyWith(color: OColor.gray800),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(FluentIcons.dismiss_24_regular, color: OColor.gray500),
        ),
      ],
    );
  }

  Widget _buildImagePlaceholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 200,
        width: double.infinity,
        color: OColor.gray200,
        child: Center(
          child: Icon(
            FluentIcons.image_24_regular,
            size: 48,
            color: OColor.gray400,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(CommonStore cs) {
    return Observer(
      builder: (context) {
        final isFavourite = cs.pinnedRooms.keys.contains(widget.room.id);
        return Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => EnterDetailsScreen(room: widget.room),
                    ),
                  );
                },
                icon: Icon(
                  FluentIcons.bookmark_20_regular,
                  color: Colors.white,
                  size: 18,
                ),
                label: Text(
                  'Book Room',
                  style: OTextStyle.labelSmall.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: OColor.green600,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  if (isFavourite) {
                    await cs.removePinnedRooms(widget.room.id);
                  } else {
                    await cs.addPinnedRooms(widget.room);
                  }
                },
                icon: Icon(
                  isFavourite
                      ? FluentIcons.star_20_filled
                      : FluentIcons.star_20_regular,
                  color: OColor.green600,
                  size: 18,
                ),
                label: Text(
                  isFavourite ? 'Remove' : 'Add to Favourite',
                  style: OTextStyle.labelSmall.copyWith(color: OColor.green600),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: OColor.green600),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCapacity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Capacity',
          style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
        ),
        const SizedBox(height: 4),
        Text(
          '${widget.room.roomCapacity} Members',
          style: OTextStyle.labelMedium.copyWith(color: OColor.gray800),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    if (widget.room.instructions == null || widget.room.instructions!.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
        ),
        const SizedBox(height: 4),
        Text(
          widget.room.instructions ?? '',
          style: OTextStyle.bodySmall.copyWith(
            color: OColor.gray800,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentBookings() {
    if (_loading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CircularProgressIndicator(color: OColor.green600),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Current Booking',
              style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RoomScheduleScreen(room: widget.room),
                  ),
                );
              },
              child: Text("view all", style: TextStyle(color: OColor.green600)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_currentBookings.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'No upcoming bookings',
              style: OTextStyle.bodySmall.copyWith(color: OColor.gray400),
            ),
          )
        else
          ..._currentBookings.map((booking) => _buildBookingTile(booking)),
      ],
    );
  }

  Widget _buildBookingTile(BookingModel booking) {
    final inTime = DateTime.parse(booking.inTime);
    final outTime = DateTime.parse(booking.outTime);
    final name = booking.userInfo.name ?? 'Unknown';

    return GestureDetector(
      onTap: () => showContactProfileSheet(context, details: booking.userInfo),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: OColor.gray100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: OColor.green600,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: OTextStyle.labelSmall.copyWith(
                              color: OColor.gray800,
                            ),
                          ),
                          Icon(
                            FluentIcons.chevron_right_20_regular,
                            color: OColor.gray400,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            FluentIcons.calendar_ltr_16_regular,
                            size: 14,
                            color: OColor.gray500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat("d MMMM yyyy").format(inTime),
                            style: OTextStyle.bodyXSmall.copyWith(
                              color: OColor.gray600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                FluentIcons.clock_16_regular,
                                size: 14,
                                color: OColor.gray500,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${DateFormat("hh:mm a").format(inTime)} - ${DateFormat("hh:mm a").format(outTime)}',
                                style: OTextStyle.bodyXSmall.copyWith(
                                  color: OColor.gray600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: OColor.green100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'APPROVED',
                              style: OTextStyle.bodyXSmall.copyWith(
                                color: OColor.green600,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPOCs() {
    final ownerInfoList = widget.room.ownerInfo;
    if (ownerInfoList.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'POCs',
          style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                ownerInfoList.map((owner) {
                  final hasPhone = owner.phoneNumber != null;
                  return GestureDetector(
                    onTap:
                        () => showContactProfileSheet(context, details: owner),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: OColor.gray100,
                                child: Icon(
                                  FluentIcons.person_24_regular,
                                  size: 28,
                                  color: OColor.gray400,
                                ),
                              ),
                              if (hasPhone)
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: OColor.green600,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: OColor.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      FluentIcons.call_16_filled,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            owner.name ?? 'Unknown',
                            style: OTextStyle.labelXSmall.copyWith(
                              color: OColor.gray800,
                            ),
                          ),
                          if (owner.rollNo != null)
                            Text(
                              owner.rollNo!,
                              style: OTextStyle.bodyXSmall.copyWith(
                                color: OColor.gray500,
                                fontSize: 10,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAdminControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: OColor.gray200, height: 1),
        const SizedBox(height: 16),
        Text(
          'Admin Controls',
          style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              final rd = context.read<RoomDetailStore>();
              rd.setSelectedRoom(widget.room);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RoomDetailsScreen(),
                ),
              );
            },
            icon: Icon(
              FluentIcons.settings_20_regular,
              color: OColor.green600,
              size: 18,
            ),
            label: Text(
              'Manage Room',
              style: OTextStyle.labelSmall.copyWith(color: OColor.green600),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: OColor.green600),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
