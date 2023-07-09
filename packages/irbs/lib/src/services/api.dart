import 'package:dio/dio.dart';
import 'package:irbs/src/models/room_model.dart';
import '../functions/auth_helper_functions.dart';
import '../functions/snackbar.dart';
import '../globals/endpoints.dart';

class APIService {

  final dio = Dio(BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: Endpoints.getHeader()));

  APIService() {

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      print("THIS IS TOKEN");
      print(await AuthUserHelpers.getAccessToken());
      print(options.path);
      options.headers["Authorization"] =
      "Bearer ${await AuthUserHelpers.getAccessToken()}";
      handler.next(options);
    },
        onError: (error, handler) async {
      var response = error.response;
      if (response != null && response.statusCode == 401) {
        if((await AuthUserHelpers.getAccessToken()).isEmpty){
          showSnackBar("Login to continue!!");
        }
        else{
          print(response.requestOptions.path);
          bool couldRegenerate = await AuthUserHelpers().regenerateAccessToken();
          print(couldRegenerate);
          // ignore: use_build_context_synchronously
          if (couldRegenerate) {
            // retry
            return handler.resolve(await AuthUserHelpers().retryRequest(response));
          } else {
            showSnackBar("Your session has expired!! Login again.");
          }
        }
      }
      else if(response != null && response.statusCode == 403){
        showSnackBar("Access not allowed in guest mode");
      }
      else if(response != null && response.statusCode == 400){
        showSnackBar(response.data["message"]);
      }
      // admin user with expired tokens
      return handler.next(error);
    }
    ));
  }

  Future<Map<String,List<RoomModel>>> getAllRooms() async {

    try{
      var response = await dio.get(Endpoints.getAllRooms);
      print(response.statusCode);
      if(response.statusCode == 200)
        {
          List<RoomModel> clubRooms = [];
          List<RoomModel> commonRooms = [];
          List<RoomModel> boardRooms = [];
          var roomList = response.data;
          print(roomList);
          for (var room in roomList)
          {
            print(room);
            if(room['roomType'] == 'club')
              {
                clubRooms.add(RoomModel.fromJson(room));
              }
            else if(room['roomType'] == 'common')
              {
                commonRooms.add((RoomModel.fromJson(room)));
              }
            else
              {
                boardRooms.add(RoomModel.fromJson(room));
              }
          }
          print('exiting successfully');
          return
              {
                'club': clubRooms,
                'common': commonRooms,
                'board': boardRooms
              };
        }
      else
        {
          throw Exception(response.statusMessage);
        }
    }catch(e)
    {
      throw Exception(e.toString());
    }
  }
  Future<List<RoomModel>> getMyRooms() async {

    try{
      var response = await dio.get(Endpoints.getMyRooms,
      );
      if(response.statusCode == 200)
      {
        var myRooms = response.data;
        List<RoomModel> ans = [];
        print(myRooms);
        for (var room in myRooms)
        {
          print("HERE");
          ans.add(RoomModel.fromJson(room));
          print("HERE 2");
        }
        return ans;
      }
      else
      {
        throw Exception(response.statusMessage);
      }
    }catch(e)
    {
      throw Exception(e.toString());
    }
  }

  Future<Map<String,dynamic>> createBooking(String details) async {
    try{
      var response = await dio.post(Endpoints.createBooking,data: details);
      if(response.statusCode==201){
        var booking=response.data;
        print(booking);
        return booking;
        // return BookingModel.fromJson(booking);
      }
      else
      {
        throw Exception(response.statusMessage);
      }
    }catch(e)
    {
      throw Exception(e.toString());
    }
  }

}