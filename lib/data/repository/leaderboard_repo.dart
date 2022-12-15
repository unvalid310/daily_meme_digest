import 'package:daily_meme_digest/data/datasource/remote/dio/dio_client.dart';
import 'package:daily_meme_digest/data/datasource/remote/exception/api_error_handler.dart';
import 'package:daily_meme_digest/data/model/response/base/api_response.dart';
import 'package:daily_meme_digest/util/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  LeaderboardRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getLeaderboard() async {
    try {
      Response response = await dioClient.get(AppConstants.LEADERBOARD_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
