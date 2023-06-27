import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../globals/colors.dart';
import '../../store/room_list_store.dart';

class RoomSearchBar extends StatelessWidget {
  const RoomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final roomListProvider = Provider.of<RoomListProvider>(context);
    return Container(
        margin: const EdgeInsets.fromLTRB(16,29,16,8,),
        decoration: BoxDecoration(
          color: Themes.darkSlateGrey,
          borderRadius: BorderRadius.circular(4), // Set the radius here
        ),
        width: MediaQuery.of(context).size.width,
        height: 32,
        child: Row(
          children:  [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 11),
              child: Icon(Icons.search,
                color: Colors.white,
                size: 16,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: MediaQuery.of(context).size.width-80,
              child:  TextField(
                onChanged: (value){
                  roomListProvider.searchResult(value);
                },
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLines: 1,
                scrollPhysics: const ClampingScrollPhysics(),
                cursorColor: Themes.comet,
                decoration:  const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintText: 'Search Keyword (name,position etc.)',
                    hintStyle: TextStyle(
                      color: Themes.comet,
                      fontSize: 12,
                    ),
                  // suffixIcon: GestureDetector(
                  //   child: const Icon(
                  //       Icons.close,
                  //       size: 16,
                  //       color: Colors.white,
                  //   ),
                  //   onTap: (){
                  //     roomListProvider.searchResults.clear();
                  //   },
                  // ),
                ),

              ),
            )
          ],
        )
    );
  }
}