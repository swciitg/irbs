import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:irbs/src/globals/styles.dart';
import 'package:irbs/src/screens/myrooms/member_details.dart';

class MemberTile extends StatefulWidget {
  bool isAdmin = false;
  var member, designations;
  MemberTile(
      {required this.isAdmin,
      required this.member,
      required this.designations});

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  Future<void> _showDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.fromLTRB(16, 24, 16, 16),
            backgroundColor: Color.fromRGBO(39, 49, 65, 1),
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Remove memeber?',
                  style: sentRequestStyle,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    child: Container(
                      height: 32,
                      width: 144,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(62, 71, 88, 1),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: dialogCancelStyle,
                        ),
                      ),
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
                          color: Color.fromRGBO(118, 172, 255, 1),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          "Confirm",
                          style: dialogConfirmStyle,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 54,
      // width: 328,
      padding: EdgeInsets.fromLTRB(16, 8, 0, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color.fromRGBO(39, 49, 65, 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.member["name"]}",
                style: TextFormFieldStyle,
              ),
              Text(
                "${widget.member["designation"]}",
                style: designationStyle,
              )
            ],
          )),
          if (widget.isAdmin &&
              widget.designations[widget.member["designation"]])
            Text(
              'Admin',
              style: labelTextStyle,
            ),
          IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {},
            iconSize: 20,
            icon: ImageIcon(
              AssetImage('packages/irbs/assets/images/phone_icon.png'),
              color: Colors.white,
            ),
          ),
          if (widget.isAdmin)
            Theme(
              data: Theme.of(context)
                  .copyWith(cardColor: Color.fromRGBO(39, 49, 65, 1)),
              child: PopupMenuButton(
                // offset: Offset(0, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                constraints: BoxConstraints(minWidth: 160),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                // color: Color.fromRGBO(39, 49, 65, 1),
                itemBuilder: (ctx) => [
                  _buildPopupMenuItem(
                      "Edit", 'packages/irbs/assets/images/edit.svg', 1),
                  _buildPopupMenuItem("Remove",
                      'packages/irbs/assets/images/removeCross.svg', 2)
                ],
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MemberDetails(isEdit: true),
                    ));
                  } else if (value == 2) {
                    _showDialog();
                  }
                },
              ),
            )
        ],
      ),
    );
  }
}

PopupMenuItem _buildPopupMenuItem(String title, String iconAddress, int val) {
  return PopupMenuItem(
    value: val,
    child: Container(
      // width: 160,
      child: Row(
        children: [
          SvgPicture.asset(
            iconAddress,
            color: Colors.white,
            height: 12,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: popupMenuStyle,
          ),
        ],
      ),
    ),
  );
}
