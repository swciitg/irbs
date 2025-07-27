// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
import '../models/room_model.dart';
import '../models/booking_model.dart';
import '../services/api.dart';
part 'room_detail_store.g.dart';

class RoomDetailStore = _RoomDetailStore with _$RoomDetailStore;

abstract class _RoomDetailStore with Store {
  @observable
  ObservableMap<String, List<RoomModel>> rooms =
      ObservableMap<String, List<RoomModel>>.of({});

  @observable
  RoomModel currentRoom = RoomModel(
      owner: ['owner'],
      roomName: 'roomName',
      allowedUsers: [],
      roomType: 'common',
      roomCapacity: 1,
      id: 'id',
      ownerInfo: [],
      allowedUserInfo: []);

  @observable
  ObservableList<RoomModel> myRooms = ObservableList<RoomModel>.of({});

  @observable
  ObservableList<BookingModel> upcomingBookings =
      ObservableList<BookingModel>.of({});

  @action
  Future<List<RoomModel>> getMyrooms() async {
    myRooms = ObservableList<RoomModel>.of(await APIService().getMyRooms());
    return myRooms;
  }

  @action
  Future<List<BookingModel>> getBookings() async {
    upcomingBookings = ObservableList<BookingModel>.of(
        await APIService().getUpcomingBokings());
    return upcomingBookings;
  }

  @action
  Future<Map<String, List<RoomModel>>> getAllRooms() async {
    rooms = ObservableMap<String, List<RoomModel>>.of(
        await APIService().getAllRooms());
    return rooms;
  }

  @action
  Future<void> setMyrooms() async {
    await getMyrooms();
  }

  @action
  Future<void> setRooms() async {
    await getAllRooms();
  }

  @action
  Future<void> setUpcomingBookings() async {
    await getBookings();
  }

  @action
  void setSelectedRoom(RoomModel room) {
    currentRoom = room;
  }

  @action
  void updateRoom(RoomModel room) {
    setSelectedRoom(room);
    rooms[room.roomType]!.removeWhere((element) => element.id == room.id);
    myRooms.removeWhere((element) => element.id == room.id);
    myRooms.add(room);
    rooms[room.roomType]!.add(room);
  }

  @action
  RoomModel getRoomById(String id) {
    for (String key in rooms.keys) {
      for (RoomModel room in rooms[key]!) {
        if (room.id == id) {
          return room;
        }
      }
    }
    return RoomModel(
        owner: ['owner'],
        roomName: 'roomName',
        allowedUsers: [],
        roomType: 'common',
        roomCapacity: 1,
        id: 'id',
        ownerInfo: [],
        allowedUserInfo: []);
  }
}
