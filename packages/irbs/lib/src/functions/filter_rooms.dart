import '../models/room_model.dart';

List<RoomModel> filterRooms(
    List<RoomModel> roomList, String text) {

  if(text == '')
    {
      return roomList;
    }
  else
    {
      List<RoomModel> answer = [];
      for(RoomModel room in roomList)
        {
          if(room.roomName.toLowerCase().contains(text.toLowerCase()))
            {
              answer.add(room);
            }
        }
      return answer;
    }
}
