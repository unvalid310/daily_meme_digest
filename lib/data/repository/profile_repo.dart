import 'package:daily_meme_digest/data/datasource/remote/dio/dio_client.dart';
import 'package:daily_meme_digest/data/datasource/remote/exception/api_error_handler.dart';
import 'package:daily_meme_digest/data/model/response/base/api_response.dart';
import 'package:daily_meme_digest/util/app_constants.dart';
import 'package:daily_meme_digest/util/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  ProfileRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getProfile() async {
    try {
      Response response = await dioClient.get(
        AppConstants.USER_URI,
        queryParameters: {
          'user_id': sharedPreferences.getString(
            AppConstants.ID_USER,
          )
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> updateProfile(FormData data) async {
    try {
      Response response = await dioClient.post(
        AppConstants.USER_UPDATE_URI,
        queryParameters: {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER),
        },
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<void> saveUserData(
      {@required int idUser,
      String profilePicture,
      String userName,
      String name,
      String createdAt}) async {
    await sharedPreferences.remove(AppConstants.PROFILE_PICTURE);

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
}
