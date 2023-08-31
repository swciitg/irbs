import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../globals/colors.dart';
import '../../globals/my_fonts.dart';
import '../roomBookingDetails/upcoming_booking_widget.dart';
import 'package:shimmer/shimmer.dart';

class RoomBookingDetailsShimmer extends StatelessWidget {
  const RoomBookingDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Themes.allRequestShimmerHighlight,
      baseColor: Themes.allRequestShimmerBase,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16),
            height: 60,
            //color: const Color.fromRGBO(39, 49, 65, 1),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Themes.backgroundColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                  )
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Divider(
            height: 0.5,
            color: Colors.white.withOpacity(0.2),
          ),
          ExpansionTile(
            childrenPadding: const EdgeInsets.only(bottom: 12),
            title: Text(
              'Upcoming Bookings',
              style: MyFonts.w400.setColor(Themes.kSubHeading),
            ),
            collapsedIconColor:Themes.regentGrey,
            iconColor:Themes.regentGrey,
            children: [].map(
              (e) => UpcomingBookingsWidget(
                name: e.userInfo.name ?? '',
                startTime: DateFormat("hh:mm a").format(DateTime.parse(e.inTime)),
                endTime: DateFormat("hh:mm a").format(DateTime.parse(e.outTime)),
                date: DateFormat("dd MMMM").format(DateTime.parse(e.inTime)),
                status: e.status == 'requested' ? 1 : e.status == 'accepted' ? 2 : 0,
              )
            ).toList(),
          ),
          Divider(
            height: 0.5,
            color: Colors.white.withOpacity(0.2),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: SizedBox(
                  height: 20,
                  width: 76,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Themes.backgroundColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    )
                  ),
                ),
              ),
              SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 20, 20),
                        child: SizedBox(
                          height: 28,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Themes.backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 50,
                              ),
                              const SizedBox(width: 8,),
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Center(
                                  child: SizedBox(
                                    height: 9,
                                    width: 16,
                                    child: Image.asset(
                                      'assets/images/chevron.png',
                                      fit: BoxFit.contain,
                                      package: 'irbs',
                                    ),
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 20, 20),
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: Image.asset(
                              'assets/images/calendar.png',
                              fit: BoxFit.contain,
                              package: 'irbs',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(child: Container(color: Themes.backgroundColor,))
        ]
      ),
    );
  }
}