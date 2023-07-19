import 'package:flutter/material.dart';
import 'package:irbs/src/functions/snackbar.dart';
import 'package:irbs/src/globals/colors.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/services/api.dart';
import 'package:irbs/src/store/common_store.dart';
import '../../models/booking_model.dart';
import 'package:intl/intl.dart';

class RespondDialog extends StatefulWidget {
  final BookingModel bookingData;
  final CommonStore commonStore;
  const RespondDialog({required this.commonStore, required this.bookingData, super.key});

  @override
  State<RespondDialog> createState() => _RespondDialogState();
}

class _RespondDialogState extends State<RespondDialog> {
  final TextEditingController textEditingController = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return isLoading ? Container(
      color: Themes.kCommonBoxBackground,
      height: 280,
      child: const Center(child: CircularProgressIndicator(),)
    ) : Container(
      padding: EdgeInsets.zero,
      color: Themes.kCommonBoxBackground,
      width: double.maxFinite,
      height: 280,
      child: Stack(children: [
        Positioned(
          right: 16,
          top: 16,
          child: GestureDetector(
            // constraints: BoxConstraints(),
            // padding: EdgeInsets.zero,
            // iconSize: 20,
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.clear,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0, top: 0, bottom: 12),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: 'Requested by  ', style: kHeading3Style),
                      TextSpan(style: kHeading3DescStyle, children: [
                        TextSpan(
                          text: widget.bookingData.userInfo.name,
                        ),
                        // TextSpan(
                        //   text: ' · ',
                        // ),
                        // TextSpan(
                        //   text: 'Design Head',
                        // )
                      ]),
                    ]),
                  ),
                ),
                RichText(
                    maxLines: 1,
                    text: TextSpan(children: [
                      TextSpan(
                        text: widget.bookingData.roomDetails.roomName,
                        style: kDialogRoomStyle,
                      ),
                      const TextSpan(text: '  ', style: kDialogRoomStyle),
                      TextSpan(text: widget.bookingData.roomDetails.roomType == 'club'
                        ? 'Club Room'
                        : widget.bookingData.roomDetails.roomName == 'board' ? 'Board Room' : 'Common Room',
                      style: kDialogSubRoomStyle)
                    ])),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 5,
                  shrinkWrap: true,
                  // primary: false,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 7.33),
                          child: Icon(
                            Icons.access_time,
                            color: Color.fromRGBO(162, 172, 192, 1),
                            size: 13.33,
                          ),
                        ),
                        RichText(
                          text: TextSpan(style: kDialogTimeStyle, children: [
                            TextSpan(
                              text: DateFormat('hh:mm a').format(DateTime.parse(widget.bookingData.inTime)),
                            ),
                            const TextSpan(
                              text: ' - ',
                            ),
                            TextSpan(
                              text: DateFormat('hh:mm a').format(DateTime.parse(widget.bookingData.outTime)),
                            )
                          ]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 7.33),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Color.fromRGBO(162, 172, 192, 1),
                            size: 13.33,
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy').format(DateTime.parse(widget.bookingData.inTime)),
                          style: kDialogTimeStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(text: 'Purpose - ', style: kDialogPurposeStyle),
                    TextSpan(
                      text: widget.bookingData.bookingPurpose, 
                      style: kDialogTimeStyle
                    ),
                  ]),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                      top: 12, bottom: 8, left: 0, right: 0),
                  child: Text(
                    'Instruction/Reason to reject -',
                    style: kDialogInstStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, top: 0, bottom: 0),
                  child: SizedBox(
                    height: 64,
                    width: double.maxFinite,
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'Reject reason cannot be empty';
                          }
                          return null;
                        },
                        maxLines: 3,
                        controller: textEditingController,
                        style: editRoomText,
                        decoration: InputDecoration(
                          hintText: 'Type Here...',
                          hintStyle: kDialogHintStyle,
                          // contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.white.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(4)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Colors.white.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(4)),
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
                              color: const Color.fromRGBO(62, 71, 88, 1),
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Text(
                              'Reject',
                              style:
                                  kRejectedStyle.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: ()async{
                          if(isLoading)
                            {
                              return;
                            }
                          if (!formKey.currentState!.validate()) {
                            print("Form not validated");
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            bool status = await APIService().rejectBooking(
                                widget.bookingData.id,
                                textEditingController.text
                            );
                            widget.commonStore.pending = widget.commonStore.pending + 1;
                            if (status)
                              {
                                showSnackBar('Booking rejected');
                              }
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                          }catch(e){
                            widget.commonStore.pending = widget.commonStore.pending + 1;
                            setState(() {
                              isLoading = false;
                            });
                            print(e);
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
                              color: const Color.fromRGBO(118, 172, 255, 1),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Center(
                            child: Text(
                              'Approve',
                              style: kApproveStyle,
                            ),
                          ),
                        ),
                        onTap: () async{
                          if(isLoading)
                          {
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            bool status = await APIService().acceptBooking(
                                widget.bookingData.id,
                                textEditingController.text ?? " "
                            );
                            widget.commonStore.pending = widget.commonStore.pending + 1;
                            if (status)
                            {
                              showSnackBar('Booking rejected');
                            }
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                          }catch(e){
                            widget.commonStore.pending = widget.commonStore.pending + 1;
                            setState(() {
                              isLoading = false;
                            });
                            print(e);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
