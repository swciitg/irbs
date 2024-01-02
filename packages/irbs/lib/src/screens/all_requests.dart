import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';
import '../globals/my_fonts.dart';
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
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Pending Requests",
          style: MyFonts.w500.size(20).setColor(Themes.white),
        ),
        backgroundColor: Themes.tileColor,
      ),
      body: SafeArea(
        child: Observer(builder: (context) {
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
                            child: RequestTile(
                              bookingData: snapshot.data![index],
                              commonStore: cs,
                            ),
                          ),
                        );
                      },
                    );
                  })
              : Container();
        }),
      ),
    );
  }
}
