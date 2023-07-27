// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';
import 'package:irbs/src/models/booking_model.dart';
import 'package:mobx/mobx.dart';
import '../models/room_model.dart';
import '../services/api.dart';
part 'room_detail_store.g.dart';

class RoomDetailStore = _RoomDetailStore with _$RoomDetailStore;

abstract class _RoomDetailStore with Store {

  @observable
  ObservableMap<String, List<RoomModel>> rooms = ObservableMap<String, List<RoomModel>>.of({});

  @observable
  ObservableList<RoomModel> myRooms = ObservableList<RoomModel>.of({});

  @observable
  ObservableList<BookingModel> upcomingBookings = ObservableList<BookingModel>.of({});

  @action
  Future<List<RoomModel>> getMyrooms()
  async {
    if(myRooms.isEmpty)
    {
      myRooms = ObservableList<RoomModel>.of(await APIService().getMyRooms());
    }
    return  myRooms;
  }

  @action
  Future<List<BookingModel>> getBookings()
  async {
    if(myRooms.isEmpty)
    {
      upcomingBookings = ObservableList<BookingModel>.of(await APIService().getUpcomingBokings());
    }
    return upcomingBookings;
  }

  @action
  Future<Map<String, List<RoomModel>>> getAllRooms()
  async {
    if(rooms.isEmpty)
    {
      rooms = ObservableMap<String, List<RoomModel>>.of(await APIService().getAllRooms());
    }
    return rooms;
  }

  @action
  setMyrooms(List<RoomModel> input)
  {
    myRooms = ObservableList<RoomModel>.of(input);
  }

  @action
  setRooms(Map<String, List<RoomModel>> input)
  {
    rooms = ObservableMap<String, List<RoomModel>>.of(input);
  }

  @action
  setUpcomingBookings(List<BookingModel> input)
  {
    upcomingBookings = ObservableList<BookingModel>.of(input);
  }

}
