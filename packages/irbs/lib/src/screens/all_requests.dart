import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:irbs/src/widgets/home/request.dart';
import 'package:irbs/src/widgets/shimmer/all_requests_shimmer.dart';
import 'package:provider/provider.dart';
import '../globals/colors.dart';
import '../globals/styles.dart';
import '../models/booking_model.dart';
class ViewAllRequests extends StatelessWidget {
  final List<BookingModel> requestedBookings;
  const ViewAllRequests({required this.requestedBookings, super.key});

  @override
  Widget build(BuildContext context) {
    var cs = context.read<CommonStore>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 28, 30, 1),
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Pending Requests",
          style: kAppBarTextStyle,
        ),

        backgroundColor: Themes.kCommonBoxBackground,
      ),
      body: SafeArea(
        child: Observer(
          builder: (context) {
            return cs.pending > 0 ? FutureBuilder(
              future: APIService().getOwnedRoomBookings(),
              builder: (context, snapshot) {
                if(!snapshot.hasData)return const AllRequestsShimmer();
                if(snapshot.hasError)return const Center(child: Text('Error'));
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Request(bookingData: snapshot.data![index], commonStore: cs,),
                      ),
                    );
                  },
                );
              }
            ) : Container();
          }
        ),
      ),
    );
  }
}
