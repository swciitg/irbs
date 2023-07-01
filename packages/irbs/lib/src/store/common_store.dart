// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';
part 'common_store.g.dart';

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {

  @observable
  String searchText = '';

  @action
  void setSearchText(String txt){
    searchText = txt;
  }

  @action
  void clearSearch()
  {
    searchText = '';
  }

}
