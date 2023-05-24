import 'package:flutter/material.dart';
import 'my_colors.dart';
import 'room_list_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:mobx/mobx.dart';
class RoomTile extends StatelessWidget {
  final String name;
  final bool pinned;
  const RoomTile({Key? key, required this.name, required this.pinned}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Provider(
        create: (_) => RoomListStore(),
        builder: (context,_) {
          var roomliststore = context.read<RoomListStore>();
          return Container(
              height: 48,
              width: 328,

              decoration: BoxDecoration(
                color: kBlueGrey,
                borderRadius: BorderRadius.circular(8), // Set the radius here
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 9,horizontal: 16),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4), // Set the radius here
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 16),
                        child: Text(name,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily:'Montserrat'
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children:  [
                      IconButton(
                        icon: const Icon(Icons.add),
                        // icon: Image.asset('assets/images/pinned.svg',
                        //   height: 20,
                        //   width: 20,
                        // ),
                        onPressed: () {
                          roomliststore.addPinnedRoom(name);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 20),
                        child: IconButton(
                          icon: const Icon(Icons.minimize),
                          // icon: Image.asset('assets/images/pinned.svg',
                          //   height: 20,
                          //   width: 20,
                          // ),
                          onPressed: () {
                            roomliststore.removePinnedRoom(name);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              )
          );
        }
    );
  }
}
// class RoomTile extends StatelessWidget {
//   final String name;
//   final bool pinned;
//   const RoomTile({Key? key, required this.name, required this.pinned}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Observer(
//       builder: (context) {
//         var roomliststore = context.read<RoomListStore>();
//         return Container(
//             height: 48,
//             width: 328,
//
//             decoration: BoxDecoration(
//               color: kBlueGrey,
//               borderRadius: BorderRadius.circular(8), // Set the radius here
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 9,horizontal: 16),
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(4), // Set the radius here
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 15,bottom: 16),
//                       child: Text(name,
//                         style: const TextStyle(
//                             fontSize: 14,
//                             color: Colors.white,
//                             fontFamily:'Montserrat'
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children:  [
//                     GestureDetector(
//                         onTap: (){
//                           roomliststore.addPinnedRoom(name);
//                         },
//                         child:  IconButton(
//                           icon: const Icon(Icons.add),
//                           // icon: Image.asset('assets/images/pinned.svg',
//                           //   height: 20,
//                           //   width: 20,
//                           // ),
//                           onPressed: () {
//
//                           },
//                         )
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 20),
//                       child: GestureDetector(
//                         onTap: (){
//
//                         },
//                         // child: const Icon(Icons.more_vert,
//                         //   color: Colors.white,
//                         //   size: 20,
//                         // ),
//                           child:  IconButton(
//                             icon: const Icon(Icons.minimize),
//                             // icon: Image.asset('assets/images/pinned.svg',
//                             //   height: 20,
//                             //   width: 20,
//                             // ),
//                             onPressed: () {
//                               roomliststore.removePinnedRoom(name);
//                             },
//                           )
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             )
//         );
//       }
//     );
//   }
// }