import 'package:flutter/material.dart';

import '../globals/styles.dart';
import '../services/api.dart';

class BookingDailogueBox extends StatefulWidget {
  final String purpose;
  final String bookingId;
  const BookingDailogueBox({super.key, required this.bookingId, required this.purpose});

  @override
  State<BookingDailogueBox> createState() => _BookingDailogueBoxState();
}

class _BookingDailogueBoxState extends State<BookingDailogueBox> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.fromLTRB(
          16, 24, 16, 16),
      backgroundColor:
      const Color.fromRGBO(39, 49, 65, 1),
      children: [
         Align(
          alignment: Alignment.center,
          child: Text(
            "Are you sure you want to ${widget.purpose} this booking ?",
            style: sentRequestStyle,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment:
          MainAxisAlignment
              .spaceEvenly,
          children: [
            InkWell(
              child: Container(
                height: 32,
                width: 144,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(
                        62, 71, 88, 1),
                    borderRadius:
                    BorderRadius
                        .circular(4)),
                child: const Center(
                    child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Text(
                          "No",
                          style:
                          dialogCancelStyle,
                        ))),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            InkWell(
                child: Container(
                  height: 32,
                  width: 144,
                  decoration: BoxDecoration(
                      color:
                      const Color.fromRGBO(
                          118,
                          172,
                          255,
                          1),
                      borderRadius:
                      BorderRadius
                          .circular(
                          4)),
                  child: const Center(
                      child: SizedBox(
                          height: 20,
                          child: Text(
                            "Yes",
                            style:
                            dialogConfirmStyle,
                          ))),
                ),
                onTap: () async {
                  if(widget.purpose == "delete")
                    {
                      String res = await APIService().deleteBooking(widget.bookingId);
                      if(res == "Success")
                      {
                        Navigator.of(context).pop();
                      }
                    }
                  else
                    {

                    }

                }),
          ],
        )
      ],
    );
  }
}
