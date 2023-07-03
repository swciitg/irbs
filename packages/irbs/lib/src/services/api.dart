import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:irbs/src/models/room_model.dart';
import '../functions/auth_helper_functions.dart';
import '../functions/snackbar.dart';
import '../globals/endpoints.dart';
import '../models/myroom_model.dart';

class APIService {

  final dio = Dio(BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: Endpoints.getHeader()));

  APIService() {

    // dio.interceptors
    //     .add(InterceptorsWrapper(onRequest: (options, handler) async {
    //   print("THIS IS TOKEN");
    //   print(await AuthUserHelpers.getAccessToken());
    //   print(options.path);
    //   options.headers["Authorization"] =
    //   "Bearer ${await AuthUserHelpers.getAccessToken()}";
    //   handler.next(options);
    // }, onError: (error, handler) async {
    //   var response = error.response;
    //   if (response != null && response.statusCode == 401) {
    //     if((await AuthUserHelpers.getAccessToken()).isEmpty){
    //       showSnackBar("Login to continue!!");
    //     }
    //     else{
    //       print(response.requestOptions.path);
    //       bool couldRegenerate = await AuthUserHelpers().regenerateAccessToken();
    //       print(couldRegenerate);
    //       // ignore: use_build_context_synchronously
    //       if (couldRegenerate) {
    //         // retry
    //         return handler.resolve(await AuthUserHelpers().retryRequest(response));
    //       } else {
    //         showSnackBar("Your session has expired!! Login again.");
    //       }
    //     }
    //   }
    //   else if(response != null && response.statusCode == 403){
    //     showSnackBar("Access not allowed in guest mode");
    //   }
    //   else if(response != null && response.statusCode == 400){
    //     showSnackBar(response.data["message"]);
    //   }
    //   // admin user with expired tokens
    //   return handler.next(error);
    // }));
  }

  Future<Map<String,List<RoomModel>>> getAllRooms() async {

    try{
      var response = await dio.get(Endpoints.getAllRooms);
      print(response.statusCode);
      if(response.statusCode == 200)
        {
          List<RoomModel> clubRooms = [];
          List<RoomModel> commonRooms = [];
          var roomList = response.data;
          print(roomList);
          for (var room in roomList)
          {
            print(room);
            if(room['roomType'] == 'club')
              {
                clubRooms.add(RoomModel.fromJson(room));
              }
            else
              {
                commonRooms.add((RoomModel.fromJson(room)));
              }
          }

          print('exiting successfully');
          return
              {
                'club': clubRooms,
                'common': commonRooms
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
  Future<List<MyRoomModel>> getMyRooms() async {

    try{
      dio.options.headers["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0YTAzYzQwOWIyOTlkMmNlMjZkMGI3MiIsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImlhdCI6MTY4ODIyMzQ0OH0.cvC4lgddKFUJnt7upO5eOqBt2m5Re4elgTKrRIAO-Iw";
      var response = await dio.get(Endpoints.getMyRooms,
      );
      //dio.options.headers["authorization"] = " ";
      if(response.statusCode == 200)
      {
        var myRooms = response.data;
        List<MyRoomModel> ans = [];
        print(myRooms);
        for (var room in myRooms)
        {
          ans.add(room);
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


}