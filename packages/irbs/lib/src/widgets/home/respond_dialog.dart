import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:onestop_kit/onestop_kit.dart';
import '../../functions/snackbar.dart';
import '../../globals/colors.dart';

import '../../models/booking_model.dart';
import '../../services/api.dart';
import '../../store/common_store.dart';

class RespondDialogue extends StatefulWidget {
  final BookingModel bookingData;
  final CommonStore commonStore;
  const RespondDialogue({required this.commonStore, required this.bookingData, super.key});

  @override
  State<RespondDialogue> createState() => _RespondDialogueState();
}

class _RespondDialogueState extends State<RespondDialogue> {
  final TextEditingController textEditingController = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  Future<void> showApproveDialogue(BuildContext context, int approve) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Themes.darkSlateGrey,
          children: [
            const SizedBox(height: 20),
            approve == 1
                ? SvgPicture.asset('packages/irbs/assets/rejected.svg', height: 50)
                : SvgPicture.asset('packages/irbs/assets/approved.svg', height: 50),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: Text(
                approve == 1 ? 'Approved' : 'Rejected',
                style: OnestopFonts.w600.size(16).setColor(Themes.white),
              ),
            ),
            const SizedBox(height: 4),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
          color: Themes.kCommonBoxBackground,
          height: 280,
          child: const Center(child: CircularProgressIndicator()),
        )
        : Container(
          padding: EdgeInsets.zero,
          color: Themes.kCommonBoxBackground,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Requested by  ',
                          // style: kHeading3Style,
                          style: OnestopFonts.w400
                              .size(10)
                              .setColor(Themes.white.withValues(alpha: 0.6))
                              .letterSpace(0.5),
                        ),
                        Text(
                          widget.bookingData.userInfo.name.toString(),
                          // style: kHeading3DescStyle,
                          style: OnestopFonts.w500.size(10).setColor(Themes.white).letterSpace(0.5),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.clear, size: 20, color: Themes.white),
                    ),
                  ],
                ),
                RichText(
                  maxLines: 1,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.bookingData.roomDetails.roomName,
                        // style: kDialogRoomStyle,
                        style: OnestopFonts.w600.size(16).setColor(Themes.white).letterSpace(0.5),
                      ),
                      TextSpan(
                        text: '  ',
                        // style: kDialogRoomStyle,
                        style: OnestopFonts.w600.size(16).setColor(Themes.white).letterSpace(0.5),
                      ),
                      TextSpan(
                        text:
                            widget.bookingData.roomDetails.roomType == 'club'
                                ? 'Club Room'
                                : widget.bookingData.roomDetails.roomName == 'board'
                                ? 'Board Room'
                                : 'Common Room',
                        // style: kDialogSubRoomStyle,
                        style: OnestopFonts.w400
                            .size(12)
                            .setColor(Themes.dialogSubRoomColor)
                            .letterSpace(0.5),
                      ),
                    ],
                  ),
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 5,
                  shrinkWrap: true,
                  // primary: false,
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 7.33),
                          child: Icon(Icons.access_time, color: Themes.iconColor, size: 13.33),
                        ),
                        RichText(
                          text: TextSpan(
                            // style: kDialogTimeStyle,
                            style: OnestopFonts.w500
                                .size(11)
                                .setColor(Themes.roomHeadingColor)
                                .letterSpace(0.5),
                            children: [
                              TextSpan(
                                text: DateFormat(
                                  'hh:mm a',
                                ).format(DateTime.parse(widget.bookingData.inTime)),
                              ),
                              const TextSpan(text: ' - '),
                              TextSpan(
                                text: DateFormat(
                                  'hh:mm a',
                                ).format(DateTime.parse(widget.bookingData.outTime)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 7.33),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Themes.iconColor,
                            size: 13.33,
                          ),
                        ),
                        Text(
                          DateFormat(
                            'MMM dd, yyyy',
                          ).format(DateTime.parse(widget.bookingData.inTime)),
                          // style: kDialogTimeStyle,
                          style: OnestopFonts.w500
                              .size(11)
                              .setColor(Themes.roomHeadingColor)
                              .letterSpace(0.5),
                        ),
                      ],
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Purpose - ',
                        // style: kDialogPurposeStyle,
                        style: OnestopFonts.w500
                            .size(11)
                            .setColor(Themes.iconColor)
                            .letterSpace(0.5),
                      ),
                      TextSpan(
                        text: widget.bookingData.bookingPurpose,
                        // style: kDialogTimeStyle
                        style: OnestopFonts.w500
                            .size(11)
                            .setColor(Themes.roomHeadingColor)
                            .letterSpace(0.5),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8, left: 0, right: 0),
                  child: Text(
                    'Instruction/Reason to reject -',
                    // style: kDialogInstStyle,
                    style: OnestopFonts.w400.size(11).setColor(Themes.iconColor).letterSpace(0.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0, left: 0, top: 0, bottom: 0),
                  child: SizedBox(
                    height: 64,
                    width: double.maxFinite,
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Reject reason cannot be empty';
                          }
                          return null;
                        },
                        maxLines: 3,
                        controller: textEditingController,
                        // style: editRoomText,
                        style: OnestopFonts.w400
                            .size(16)
                            .setColor(Themes.white)
                            .setHeight(1.5)
                            .letterSpace(0.1),
                        decoration: InputDecoration(
                          hintText: 'Type Here...',
                          // hintStyle: kDialogHintStyle,
                          hintStyle: OnestopFonts.w400
                              .size(12)
                              .setColor(Themes.comet)
                              .letterSpace(0.5),
                          // contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Themes.white.withValues(alpha: 0.5),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Themes.white.withValues(alpha: 0.5),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.75,
                  shrinkWrap: true,
                  // primary: false,
                  crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InkWell(
                        child: Container(
                          height: 24,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Themes.disabledButtonBackground,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'Reject',
                              // style:
                              //     kRejectedStyle.copyWith(color: Themes.white),
                              style: OnestopFonts.w500
                                  .size(12)
                                  .setColor(Themes.rejectedBooking)
                                  .letterSpace(0.5)
                                  .copyWith(color: Themes.white),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (isLoading) {
                            return;
                          }
                          if (!formKey.currentState!.validate()) {
                            // print("Form not validated");
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            bool status = await APIService().rejectBooking(
                              widget.bookingData.id,
                              textEditingController.text,
                            );
                            widget.commonStore.pending = widget.commonStore.pending + 1;
                            setState(() {
                              isLoading = false;
                            });
                            if (!mounted) return;
                            Navigator.of(context).pop();
                            if (status) {
                              showSnackBar('Booking rejected');
                              showApproveDialogue(context, 0);
                            }
                          } catch (e) {
                            widget.commonStore.pending = widget.commonStore.pending + 1;
                            setState(() {
                              isLoading = false;
                            });
                            // print(e);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InkWell(
                        child: Container(
                          height: 24,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Themes.primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'Approve',
                              // style: kApproveStyle,
                              style: OnestopFonts.w600
                                  .size(14)
                                  .setColor(Themes.onPrimaryColor)
                                  .letterSpace(0.5),
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (isLoading) {
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            bool status = await APIService().acceptBooking(
                              widget.bookingData.id,
                              textEditingController.text,
                            );
                            widget.commonStore.pending = widget.commonStore.pending + 1;

                            setState(() {
                              isLoading = false;
                            });
                            if (!mounted) return;
                            Navigator.of(context).pop();
                            if (status) {
                              showSnackBar('Booking Approved');
                              showApproveDialogue(context, 1);
                            }
                          } catch (e) {
                            DioException x = e as DioException;
                            var res = x.response!.statusCode;
                            if (res == 400) {
                              Fluttertoast.showToast(msg: "Slot already booked");
                            }
                            Navigator.of(context).pop();
                            widget.commonStore.pending = widget.commonStore.pending + 1;
                            setState(() {
                              isLoading = false;
                            });
                            // print(e);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
