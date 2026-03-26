import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onestop_ui/index.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import '../../store/data_store.dart';
import '../../store/room_detail_store.dart';
import '../../widgets/myrooms/add_member_dailogue.dart';
import '../../widgets/myrooms/member_tile.dart';
import 'edit_room_details.dart';

class RoomDetailsScreen extends StatefulWidget {
  const RoomDetailsScreen({super.key});

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    var rd = context.read<RoomDetailStore>();
    isAdmin = rd.currentRoom.owner.contains(DataStore.userData['outlookEmail']);
    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: OColor.gray100,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: Icon(FluentIcons.arrow_left_24_regular, color: OColor.gray800),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              "IRBS",
              style: OTextStyle.headingSmall.copyWith(color: OColor.gray800),
            ),
            backgroundColor: OColor.gray100,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRoomHeader(rd),
                const SizedBox(height: 24),
                _buildCapacitySection(rd),
                const SizedBox(height: 24),
                _buildInstructionsSection(rd),
                const SizedBox(height: 24),
                _buildMembersSection(rd),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoomHeader(RoomDetailStore rd) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: OColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: OColor.gray200, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: OColor.green100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(FluentIcons.building_20_regular, color: OColor.green600, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              rd.currentRoom.roomName,
              style: OTextStyle.headingMedium.copyWith(color: OColor.gray800),
            ),
          ),
          if (isAdmin)
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditRoomScreen(data: rd.currentRoom),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: OColor.gray200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(FluentIcons.edit_20_regular, color: OColor.green600, size: 20),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCapacitySection(RoomDetailStore rd) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: OColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: OColor.gray200, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(FluentIcons.people_20_regular, color: OColor.gray500, size: 20),
          const SizedBox(width: 8),
          Text('Capacity', style: OTextStyle.bodySmall.copyWith(color: OColor.gray500)),
          const Spacer(),
          Text(
            '${rd.currentRoom.roomCapacity} Members',
            style: OTextStyle.labelMedium.copyWith(color: OColor.gray800),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsSection(RoomDetailStore rd) {
    final instructions = rd.currentRoom.instructions;
    if (instructions == null || instructions.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Instructions', style: OTextStyle.bodySmall.copyWith(color: OColor.gray500)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: OColor.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: OColor.gray200, width: 0.5),
          ),
          child: Text(
            instructions,
            style: OTextStyle.bodySmall.copyWith(color: OColor.gray800, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildMembersSection(RoomDetailStore rd) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Members', style: OTextStyle.bodySmall.copyWith(color: OColor.gray500)),
            if (isAdmin)
              GestureDetector(
                onTap: () async => await addMemberDialog(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: OColor.green600),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(FluentIcons.add_20_regular, color: OColor.green600, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Add Member',
                        style: OTextStyle.labelXSmall.copyWith(color: OColor.green600),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (rd.currentRoom.owner.isNotEmpty) ...[
          Text(
            'Admins',
            style: OTextStyle.labelXSmall.copyWith(color: OColor.gray400, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: rd.currentRoom.owner.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: MemberTile(
                  isAdmin: isAdmin,
                  index: index,
                  room: rd.currentRoom,
                  isPersonAdmin: true,
                ),
              );
            },
          ),
        ],
        if (rd.currentRoom.allowedUsers.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'Members',
            style: OTextStyle.labelXSmall.copyWith(color: OColor.gray400, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: rd.currentRoom.allowedUsers.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: MemberTile(
                  isAdmin: isAdmin,
                  index: index,
                  room: rd.currentRoom,
                  isPersonAdmin: false,
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
