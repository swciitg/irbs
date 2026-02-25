import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:onestop_ui/index.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';
import '../models/booking_model.dart';
import '../services/api.dart';
import '../store/common_store.dart';
import '../widgets/home/request_tile.dart';
import '../widgets/shimmer/all_requests_shimmer.dart';

class PendingRequestsScreen extends StatelessWidget {
  final List<BookingModel> requestedBookings;
  const PendingRequestsScreen({required this.requestedBookings, super.key});

  @override
  Widget build(BuildContext context) {
    var cs = context.read<CommonStore>();
    return Scaffold(
      backgroundColor: Themes.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(FluentIcons.arrow_left_24_regular, color: OColor.gray800),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Pending Requests",
          style: OTextStyle.headingMedium.copyWith(color: OColor.gray800),
        ),
        backgroundColor: OColor.gray100,
      ),
      body: SafeArea(
        child: Observer(
          builder: (context) {
            return cs.pending > 0
                ? FutureBuilder(
                  future: APIService().getOwnedRoomBookings(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const AllRequestsShimmer();
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error'));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: RequestTile(bookingData: snapshot.data![index], commonStore: cs),
                          ),
                        );
                      },
                    );
                  },
                )
                : Container();
          },
        ),
      ),
    );
  }
}
