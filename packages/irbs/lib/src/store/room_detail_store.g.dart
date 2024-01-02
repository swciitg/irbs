// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_detail_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RoomDetailStore on _RoomDetailStore, Store {
  late final _$roomsAtom =
      Atom(name: '_RoomDetailStore.rooms', context: context);

  @override
  ObservableMap<String, List<RoomModel>> get rooms {
    _$roomsAtom.reportRead();
    return super.rooms;
  }

  @override
  set rooms(ObservableMap<String, List<RoomModel>> value) {
    _$roomsAtom.reportWrite(value, super.rooms, () {
      super.rooms = value;
    });
  }

  late final _$currentRoomAtom =
      Atom(name: '_RoomDetailStore.currentRoom', context: context);

  @override
  RoomModel get currentRoom {
    _$currentRoomAtom.reportRead();
    return super.currentRoom;
  }

  @override
  set currentRoom(RoomModel value) {
    _$currentRoomAtom.reportWrite(value, super.currentRoom, () {
      super.currentRoom = value;
    });
  }

  late final _$myRoomsAtom =
      Atom(name: '_RoomDetailStore.myRooms', context: context);

  @override
  ObservableList<RoomModel> get myRooms {
    _$myRoomsAtom.reportRead();
    return super.myRooms;
  }

  @override
  set myRooms(ObservableList<RoomModel> value) {
    _$myRoomsAtom.reportWrite(value, super.myRooms, () {
      super.myRooms = value;
    });
  }

  late final _$upcomingBookingsAtom =
      Atom(name: '_RoomDetailStore.upcomingBookings', context: context);

  @override
  ObservableList<BookingModel> get upcomingBookings {
    _$upcomingBookingsAtom.reportRead();
    return super.upcomingBookings;
  }

  @override
  set upcomingBookings(ObservableList<BookingModel> value) {
    _$upcomingBookingsAtom.reportWrite(value, super.upcomingBookings, () {
      super.upcomingBookings = value;
    });
  }

  late final _$getMyroomsAsyncAction =
      AsyncAction('_RoomDetailStore.getMyrooms', context: context);

  @override
  Future<List<RoomModel>> getMyrooms() {
    return _$getMyroomsAsyncAction.run(() => super.getMyrooms());
  }

  late final _$getBookingsAsyncAction =
      AsyncAction('_RoomDetailStore.getBookings', context: context);

  @override
  Future<List<BookingModel>> getBookings() {
    return _$getBookingsAsyncAction.run(() => super.getBookings());
  }

  late final _$getAllRoomsAsyncAction =
      AsyncAction('_RoomDetailStore.getAllRooms', context: context);

  @override
  Future<Map<String, List<RoomModel>>> getAllRooms() {
    return _$getAllRoomsAsyncAction.run(() => super.getAllRooms());
  }

  late final _$setMyroomsAsyncAction =
      AsyncAction('_RoomDetailStore.setMyrooms', context: context);

  @override
  Future setMyrooms() {
    return _$setMyroomsAsyncAction.run(() => super.setMyrooms());
  }

  late final _$setRoomsAsyncAction =
      AsyncAction('_RoomDetailStore.setRooms', context: context);

  @override
  Future setRooms() {
    return _$setRoomsAsyncAction.run(() => super.setRooms());
  }

  late final _$setUpcomingBookingsAsyncAction =
      AsyncAction('_RoomDetailStore.setUpcomingBookings', context: context);

  @override
  Future setUpcomingBookings() {
    return _$setUpcomingBookingsAsyncAction
        .run(() => super.setUpcomingBookings());
  }

  late final _$_RoomDetailStoreActionController =
      ActionController(name: '_RoomDetailStore', context: context);

  @override
  dynamic setSelectedRoom(RoomModel room) {
    final _$actionInfo = _$_RoomDetailStoreActionController.startAction(
        name: '_RoomDetailStore.setSelectedRoom');
    try {
      return super.setSelectedRoom(room);
    } finally {
      _$_RoomDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRoom(RoomModel room) {
    final _$actionInfo = _$_RoomDetailStoreActionController.startAction(
        name: '_RoomDetailStore.updateRoom');
    try {
      return super.updateRoom(room);
    } finally {
      _$_RoomDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  RoomModel getRoomById(String id) {
    final _$actionInfo = _$_RoomDetailStoreActionController.startAction(
        name: '_RoomDetailStore.getRoomById');
    try {
      return super.getRoomById(id);
    } finally {
      _$_RoomDetailStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
rooms: ${rooms},
currentRoom: ${currentRoom},
myRooms: ${myRooms},
upcomingBookings: ${upcomingBookings}
    ''';
  }
}
