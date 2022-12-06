import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:daily_meme_digest/data/datasource/remote/dio/dio_client.dart';
import 'package:daily_meme_digest/data/datasource/remote/exception/api_error_handler.dart';
import 'package:daily_meme_digest/data/model/response/base/api_response.dart';
import 'package:daily_meme_digest/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> login(String email, String password) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: FormData.fromMap({
          "email": email,
          "password": password,
        }),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<void> saveUserData(
      {@required int idUser,
      String email,
      String username,
      String password}) async {
    try {
      sharedPreferences.setString(AppConstants.ID_USER, idUser.toString());
      sharedPreferences.setString(AppConstants.EMAIL, email);
      sharedPreferences.setString(AppConstants.USERNAME, username);
      sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {}
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.EMAIL);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.clear();
    return true;
  }
}
