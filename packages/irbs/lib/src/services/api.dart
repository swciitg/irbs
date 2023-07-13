import 'package:dio/dio.dart';
import 'package:irbs/src/models/booking_model.dart';
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
    }, onError: (error, handler) async {
      var response = error.response;
      if (response != null && response.statusCode == 401) {
        if ((await AuthUserHelpers.getAccessToken()).isEmpty) {
          showSnackBar("Login to continue!!");
        } else {
          print(response.requestOptions.path);
          bool couldRegenerate =
              await AuthUserHelpers().regenerateAccessToken();
          print(couldRegenerate);
          // ignore: use_build_context_synchronously
          if (couldRegenerate) {
            // retry
            return handler
                .resolve(await AuthUserHelpers().retryRequest(response));
          } else {
            showSnackBar("Your session has expired!! Login again.");
          }
        }
      } else if (response != null && response.statusCode == 403) {
        showSnackBar("Access not allowed in guest mode");
      } else if (response != null && response.statusCode == 400) {
        showSnackBar(response.data["message"]);
      }
      // admin user with expired tokens
      return handler.next(error);
    }));
  }

  Future<Map<String, List<RoomModel>>> getAllRooms() async {
    try {
      var response = await dio.get(Endpoints.getAllRooms);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<RoomModel> clubRooms = [];
        List<RoomModel> commonRooms = [];
        List<RoomModel> boardRooms = [];
        var roomList = response.data;
        print(roomList);
        for (var room in roomList) {
          print(room);
          if (room['roomType'] == 'club') {
            clubRooms.add(RoomModel.fromJson(room));
          } else if (room['roomType'] == 'common') {
            commonRooms.add((RoomModel.fromJson(room)));
          } else {
            boardRooms.add(RoomModel.fromJson(room));
          }
        }
        print('exiting successfully');
        return {'club': clubRooms, 'common': commonRooms, 'board': boardRooms};
      } else {
        showSnackBar(response.statusMessage.toString());
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      showSnackBar(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<String> getRoomFromId(String roomId)async{
    try {
      Response res = await dio.get('${Endpoints.getSpecificRoom}/$roomId');

      if(res.statusCode == 200){
        return res.data['roomName'];
      }
      else{
        throw Exception(res.statusMessage);
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<List<BookingModel>> getRoomBookings(String roomId)async{
    try{
      Response res = await dio.get(
        Endpoints.getRoomBookings,
        queryParameters: {
          'roomId': roomId
        }
      );
      
      if(res.statusCode == 200){
        var bookingMapList = res.data;

        List<BookingModel> bookingList = [];

        for(var booking in bookingMapList){
          bookingList.add(
            BookingModel.fromJson(booking)
          );
        }

        return bookingList;
      }
      else{
        throw Exception(res.statusMessage.toString());
      }
    }catch(e){
      print(e);
      throw Exception(e.toString());
    }
  }
  
  Future<List<BookingModel>> getMonthWiseRoomBookings({
    required String roomId,
    required String month,
    required String year
  })async{
    try{
      Response res = await dio.get(
        Endpoints.baseUrl + Endpoints.getRoomBookings,
        queryParameters: {
          'roomId': roomId, 
          'month': month, 
          'year': year
        }        
      );
      
      if(res.statusCode == 200){
        var bookingMapList = res.data;
        

        List<BookingModel> bookingList = [];

        for(var booking in bookingMapList){
          bookingList.add(
            BookingModel.fromJson(booking)
          );
        }

        return bookingList;
      }
      else{
        throw Exception(res.statusMessage);
      }
    }catch(e){
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<BookingModel>> getBookingsForCalendar({
    required String roomId,
    required int month,
    required String year
  })async{
    List<BookingModel> bookings = await getMonthWiseRoomBookings(
      roomId: roomId, 
      month: month.toString(), 
      year: year
    );
    List<BookingModel> nextMonthBookings = await getMonthWiseRoomBookings(
      roomId: roomId, 
      month: (month+1).toString(), 
      year: year
    );

    bookings.addAll(nextMonthBookings);

    return bookings;
  }

  Future<List<RoomModel>> getMyRooms() async {

    try{
      var response = await dio.get(Endpoints.getMyRooms);
      if(response.statusCode == 200)
      {
        var myRooms = response.data;
        List<RoomModel> ans = [];
        print(myRooms);
        for (var room in myRooms) {
          print("HERE");
          ans.add(RoomModel.fromJson(room));
          print("HERE 2");
        }
        return ans;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> createBooking(String details) async {
    try {
      var response = await dio.post(Endpoints.createBooking, data: details);
      if (response.statusCode == 201) {
        var booking = response.data;
        print(booking);
        return booking;
        // return BookingModel.fromJson(booking);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<List<List<BookingModel>>> getBookingHistory()async{
    try{
      Response res = await dio.get(Endpoints.getRoomBookings);

  

      if(res.statusCode == 200){
        var bookingMapList = res.data;
        List<BookingModel> currentBooking = [];
        List<BookingModel> pastBooking = [];
        DateTime a =DateTime.now();
        for(var booking in bookingMapList){
          DateTime b = DateTime.parse(booking['outTime']);
          if(a.isBefore(b)){
            currentBooking.add(
                BookingModel.fromJson(booking),
            );
          }else{
            print(booking['outTime']);
            pastBooking.add(
              BookingModel.fromJson(booking),
            );
          }
        }
        List<List<BookingModel>> answer = [];
        sortByParameter(currentBooking, (a, b) => a.inTime.compareTo(b.inTime));
        sortByParameter(currentBooking, (a, b) => b.outTime.compareTo(a.outTime));
        answer.add(currentBooking);
        answer.add(pastBooking);
        return answer;
      }
      else{
        throw Exception(res.statusMessage);
      }
    }catch(e){
      print(e.toString());
      throw Exception(e.toString());
    }
  }
  Future<void> deleteBooking(String id) async {
    try {
      Response response = await dio.delete('${Endpoints.deleteBooking}/$id');
      if (response.statusCode == 200) {
        print('deleted');
      } else {
        print('failed___ ${response.statusCode}');
      }
    } catch (error) {
      print('ERROR: $error');
    }
  }
  Future<void> endBooking(String id) async{
    try {
      Response response = await dio.patch('${Endpoints.deleteBooking}/$id', data: {
        "outTime": DateTime.now().toString(),
      },
      );
      if (response.statusCode == 200) {
        print('updated');
      } else {
        print('failed___ ${response.statusCode}');
      }
    } catch (error) {
      print('ERROR: $error');
    }
  }
  Future<RoomModel> editRoomDetails(String roomId, String details) async {
    try {
      var response =
          await dio.patch('${Endpoints.editRoom}/$roomId', data: details);
      print(response.statusCode);
      print(response.data);
      print(response.statusMessage);
      if (response.statusCode == 201 || response.statusCode == 200) {
        var room = response.data;
        print(room);
        print(room.runtimeType);
        if (room['errors'] != null) {
          print("exc");
          throw Exception('Email doesn\'t Exist');
        }
        print('hi');
        return RoomModel.fromJson(room);
      } else if (response.statusCode == 404) {
        print("exception");
        throw Exception('Email doesn\'t Exist');
      } else {
        print("excep");
        showSnackBar(response.statusMessage.toString());
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      showSnackBar(e.toString());
      throw Exception(e.toString());
    }
  }
}
void sortByParameter<BookingModel>(List<BookingModel> list, int Function(BookingModel a,BookingModel b) compare) {
  list.sort(compare);
}
  
