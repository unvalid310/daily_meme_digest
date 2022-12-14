import 'package:daily_meme_digest/util/strings.dart';
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

  Future<ApiResponse> registration(Map<String, dynamic> data) async {
    try {
      Response response = await dioClient.post(
        AppConstants.REGISTER_URI,
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(String username, String password) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: FormData.fromMap({
          "username": username,
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
      String profilePicture,
      String userName,
      String name,
      String createdAt}) async {
    await sharedPreferences.setString(AppConstants.ID_USER, idUser.toString());
    await sharedPreferences.setString(AppConstants.USERNAME, userName);

    if (name != null || name != '') {
      await sharedPreferences.setString(AppConstants.NAME, name);
    }

    if (profilePicture != null || profilePicture != '') {
      await sharedPreferences.setString(
          AppConstants.PROFILE_PICTURE, profilePicture);
    }

    await sharedPreferences.setString(
      AppConstants.CREATED_AT,
      getCustomDateFormat(DateTime.parse(createdAt), 'MMM YYYY'),
    );
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.ID_USER);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.clear();
    return true;
  }
}
