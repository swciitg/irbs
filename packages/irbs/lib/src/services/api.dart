import 'package:dio/dio.dart';
import '../functions/snackbar.dart';
import '../globals/endpoints.dart';
import '../models/booking_model.dart';
import '../models/room_model.dart';
import 'auth_helper.dart';

class APIService {
  final dio = Dio(BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: Endpoints.getHeader()));

  APIService() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // print("THIS IS TOKEN");
      // print(await AuthUserHelpers.getAccessToken());
      // print(options.path);
      options.headers["Authorization"] =
      "Bearer ${await AuthUserHelpers.getAccessToken()}";
      handler.next(options);
    }, onError: (error, handler) async {
      var response = error.response;
      if (response != null && response.statusCode == 401) {
        if ((await AuthUserHelpers.getAccessToken()).isEmpty) {
          showSnackBar("Login to continue!!");
        } else {
          // print(response.requestOptions.path);
          bool couldRegenerate =
          await AuthUserHelpers().regenerateAccessToken();
          // print(couldRegenerate);
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
        // print(response);
        // print("HEllo worldo");
        //showSnackBar(response.data["message"]);
      }
      // admin user with expired tokens
      return handler.next(error);
    }));
  }

  Future<List<BookingModel>> getOwnedRoomBookings()async{
    try {
      Response res = await dio.get(
        '${Endpoints.baseUrl}${Endpoints.getOwnedRoomBookings}',
        queryParameters: {
          'status': 'requested'
        }
      );

      if(res.statusCode == 200){
        List<BookingModel> bookings = [];
        for(var booking in res.data){
          bookings.add(BookingModel.fromJson(booking));
        }
        return bookings;
      }else{
        throw Exception(res.statusMessage);
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<Map<String, List<RoomModel>>> getAllRooms() async {
    try {
      var response = await dio.get(Endpoints.getAllRooms);
      if (response.statusCode == 200) {
        List<RoomModel> clubRooms = [];
        List<RoomModel> commonRooms = [];
        List<RoomModel> boardRooms = [];
        var roomList = response.data;
        for (var room in roomList) {
          if (room['roomType'] == 'club') {
            clubRooms.add(RoomModel.fromJson(room));
          } else if (room['roomType'] == 'common') {
            commonRooms.add((RoomModel.fromJson(room)));
          } else {
            boardRooms.add(RoomModel.fromJson(room));
          }
        }
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
      // print(e);
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
      // print(e.toString());
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
    bookings.removeWhere((element) => element.status == "requested");
    return bookings;
  }

  Future<List<RoomModel>> getMyRooms() async {

    try{
      var response = await dio.get(Endpoints.getMyRooms);
      if(response.statusCode == 200)
      {
        var myRooms = response.data;
        List<RoomModel> ans = [];
        // print(myRooms);
        for (var room in myRooms) {
          // print("HERE");
          ans.add(RoomModel.fromJson(room));
          // print("HERE 2");
        }
        return ans;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> createBooking(String details) async {
    Response? response;
    try {
      response = await dio.post(Endpoints.createBooking, data: details);
      if (response.statusCode == 201) {
        return "Success";
        // return BookingModel.fromJson(booking);
      } else {
        if(response.statusCode == 400)
          {
            return "Invalid Slot";
          }
        return "Some error occured";
      }
    } catch (e) {
      // print("Inside catch");
      return e.toString();
      //throw Exception(e.toString());
    }
  }
  
  Future<bool> rejectBooking(String bookingId, String rejectionReason)async{
    try {
      Response res = await dio.post(
        Endpoints.baseUrl+Endpoints.rejectBooking,
        data: {
          'id': bookingId,
          'reasonRejection': rejectionReason
        }
      );

      if(res.statusCode == 200){
        // print('Booking rejected');
        return true;
      }else{
        throw Exception(res.statusMessage);
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<bool> acceptBooking(String bookingId, String instructions)async{
    try {
      // print(instructions);
      Response res = await dio.post(
        Endpoints.baseUrl+Endpoints.acceptBooking,
        data: {
          'id': bookingId,
          'acceptInstructions': instructions == ""? "NONE": instructions
        }
      );

      if(res.statusCode == 200){
        // print('Booking accepted');
        return true;
      }else{
        throw Exception(res.statusMessage);
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<List<BookingModel>> getUpcomingBokings()async{
    try{
      Response res = await dio.get(Endpoints.getRoomBookings, queryParameters: {
        'isMy': true,
        'upcoming': true
      });
      if(res.statusCode == 200){
        var bookingMapList = res.data;
        List<BookingModel> currentBooking = [];
        DateTime a =DateTime.parse("${DateTime.now().toIso8601String()}Z");
        for(var booking in bookingMapList){
          DateTime b = DateTime.parse(booking['outTime']);
          if(!a.isAfter(b))
            {
              currentBooking.add(
                BookingModel.fromJson(booking),
              );
            }

        }
        sortByParameter(currentBooking, (a, b) => b.inTime.compareTo(a.inTime));
        sortByParameter(currentBooking, (a, b) => a.outTime.compareTo(b.outTime));
        return currentBooking;
      }
      else{
        throw Exception(res.statusMessage);
      }
    }catch(e){
      // print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<BookingModel>> getBookingHistory({int month = 1, int year = 2023})async{
    try{
      Response res = await dio.get(Endpoints.getRoomBookings, queryParameters: {
        'isMy': true,
        'upcoming': false,
        'month': month,
        'year': year
      });
      if(res.statusCode == 200){
        var bookingMapList = res.data;
        List<BookingModel> bookings = [];
        DateTime a =DateTime.parse("${DateTime.now().toIso8601String()}Z");
        for(var booking in bookingMapList){
          DateTime b = DateTime.parse(booking['outTime']);
          if(a.isAfter(b))
          {
            bookings.add(
              BookingModel.fromJson(booking),
            );}
        }
        sortByParameter(bookings, (a1, b1) => b1.outTime.compareTo(a1.outTime));
        return bookings;
      }
      else{
        throw Exception(res.statusMessage);
      }
    }catch(e){
      // print(e.toString());
      throw Exception(e.toString());
    }
  }
  
  Future<String> deleteBooking(String id) async {
    try {
      Response response = await dio.delete(Endpoints.deleteBooking, data: {
        "id": id
      });
      if (response.statusCode == 200) {
        // print('deleted');
        return "Success";
      } else {
        // print('failed___ ${response.statusCode}');
        return "Failed";
      }
    } catch (error) {
      return 'ERROR: $error';
      // return "Failed";
    }
  }


  Future<String> endBooking(String id) async{
    try {
      Response response = await dio.patch('${Endpoints.deleteBooking}/$id', data: {
        "outTime": DateTime.now().toString(),
      },
      );
      if (response.statusCode == 200) {
        // print('updated');
        return "Success";
      } else {
        // print('failed___ ${response.statusCode}');
        return response.statusMessage.toString();
      }
    } catch (error) {
      // print('ERROR: $error');
      return error.toString();
    }
  }
  
  Future<RoomModel> editRoomDetails(String roomId, String details) async {
    try {
      var response =
      await dio.patch('${Endpoints.editRoom}/$roomId', data: details);

      if (response.statusCode == 201 || response.statusCode == 200) {
        var room = response.data;
        // print(room.runtimeType);
        if (room['errors'] != null) {
          // print("exc");
          throw Exception('Email doesn\'t Exist');
        }
        return RoomModel.fromJson(room);
      } else if (response.statusCode == 404) {
        // print("exception");
        throw Exception('Email doesn\'t Exist');
      } else {
        // print("excep");
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