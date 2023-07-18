import 'package:flutter/material.dart';
import 'package:irbs/src/store/common_store.dart';
import 'package:irbs/src/widgets/home/request.dart';
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: requestedBookings.map((booking) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Request(bookingData: booking, commonStore: cs,),
              )).toList()
            ),
          ),
        ),
      ),
    );
  }
}
