// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommonStore on _CommonStore, Store {
  late final _$searchTextAtom =
      Atom(name: '_CommonStore.searchText', context: context);

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  late final _$pinnedRoomsAtom =
      Atom(name: '_CommonStore.pinnedRooms', context: context);

  @override
  ObservableMap<String, RoomModel> get pinnedRooms {
    _$pinnedRoomsAtom.reportRead();
    return super.pinnedRooms;
  }

  @override
  set pinnedRooms(ObservableMap<String, RoomModel> value) {
    _$pinnedRoomsAtom.reportWrite(value, super.pinnedRooms, () {
      super.pinnedRooms = value;
    });
  }

  late final _$initialisePinnedRoomsAsyncAction =
      AsyncAction('_CommonStore.initialisePinnedRooms', context: context);

  @override
  Future initialisePinnedRooms() {
    return _$initialisePinnedRoomsAsyncAction
        .run(() => super.initialisePinnedRooms());
  }

  late final _$addPinnedRoomsAsyncAction =
      AsyncAction('_CommonStore.addPinnedRooms', context: context);

  @override
  Future<void> addPinnedRooms(RoomModel room) {
    return _$addPinnedRoomsAsyncAction.run(() => super.addPinnedRooms(room));
  }

  late final _$removePinnedRoomsAsyncAction =
      AsyncAction('_CommonStore.removePinnedRooms', context: context);

  @override
  Future<void> removePinnedRooms(String id) {
    return _$removePinnedRoomsAsyncAction
        .run(() => super.removePinnedRooms(id));
  }

  late final _$_CommonStoreActionController =
      ActionController(name: '_CommonStore', context: context);

  @override
  void setSearchText(String txt) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setSearchText');
    try {
      return super.setSearchText(txt);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearch() {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.clearSearch');
    try {
      return super.clearSearch();
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchText: ${searchText},
pinnedRooms: ${pinnedRooms}
    ''';
  }
}
