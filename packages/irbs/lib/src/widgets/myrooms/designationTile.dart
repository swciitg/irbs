import 'package:flutter/material.dart';
import 'package:irbs/src/globals/styles.dart';

class DesignationTile extends StatefulWidget {
  var name;
  bool isAdmin;
  DesignationTile({required this.isAdmin, required this.name});

  @override
  State<DesignationTile> createState() => _DesignationTileState();
}

class _DesignationTileState extends State<DesignationTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.fromLTRB(16, 2, 16, 2),
      decoration: BoxDecoration(
          color: Color.fromRGBO(39, 49, 65, 1),
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Expanded(
              child: Text(
            widget.name,
            style: editRoomText,
          )),
          if (widget.isAdmin)
            Text(
              "Admin",
              style: adminTileText,
            ),
          SizedBox(
            width: 24,
          ),
          GestureDetector(
            onTap: () {},
            child: ImageIcon(
              AssetImage('packages/irbs/assets/images/remove_cross.png'),
              size: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 8,
          )
        ],
      ),
    );
  }
}
