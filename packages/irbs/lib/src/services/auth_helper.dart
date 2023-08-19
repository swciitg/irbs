import 'package:shared_preferences/shared_preferences.dart';
import '../globals/database_strings.dart';
import '../globals/endpoints.dart';
import 'package:dio/dio.dart';

class AuthUserHelpers{

  Future<Response<dynamic>> retryRequest(Response response) async {
    // print(response);
    // print("INSIDE RETRY REQUEST");
    RequestOptions requestOptions = response.requestOptions;
    response.requestOptions.headers[BackendHelper.authorization] = "Bearer ${await AuthUserHelpers.getAccessToken()}";
    try{
    final options = Options(method: requestOptions.method, headers: requestOptions.headers);
    Dio retryDio = Dio(BaseOptions(
        baseUrl: Endpoints.oneStopbaseURL,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          'Security-Key': Endpoints.apiSecurityKey
        }));
    if (requestOptions.method == "GET") {
      return retryDio.request(requestOptions.path,
          queryParameters: requestOptions.queryParameters, options: options);
    } else {
      return retryDio.request(requestOptions.path,
          queryParameters: requestOptions.queryParameters,
          data: requestOptions.data,
          options: options);
    }
  }
  catch(e){
      // print("error adarahooo");
      // print(e);
      throw Exception(e);
  }
  }

  Future<bool> regenerateAccessToken() async {
    String refreshToken = await AuthUserHelpers.getRefreshToken();
    // print("REFRESH TOKEN");
    // print(refreshToken);
    try {
      Dio regenDio = Dio(BaseOptions(
          baseUrl: Endpoints.oneStopbaseURL,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5)));
      Response resp = await regenDio.post(
          "/user/accesstoken",
          options: Options(headers: {'Security-Key': Endpoints.apiSecurityKey,"authorization": "Bearer $refreshToken"}));
      // print(resp);
      var data = resp.data!;
      // print(data);
      // print("REGENRATED ACCESS TOKEN");
      await AuthUserHelpers.setAccessToken(data[BackendHelper.accesstoken]);
      return true;
    } catch (err) {
      // print("ERROR OCCURED");
      // print(err.toString());
      return false;
    }
  }

  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(BackendHelper.accesstoken) ?? " ";
  }

  static Future<void> setAccessToken(String value) async {
    // print(value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(BackendHelper.accesstoken, value);
  }

  static Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(BackendHelper.refreshtoken) ?? " ";
  }

  static Future<void> setRefreshToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(BackendHelper.refreshtoken, value);
  }
}