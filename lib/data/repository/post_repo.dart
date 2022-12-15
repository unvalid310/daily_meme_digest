import 'dart:io';

import 'package:daily_meme_digest/data/datasource/remote/dio/dio_client.dart';
import 'package:daily_meme_digest/data/datasource/remote/exception/api_error_handler.dart';
import 'package:daily_meme_digest/data/model/response/base/api_response.dart';
import 'package:daily_meme_digest/util/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  PostRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getPost(
      {bool idUser = false, int postId, String filter}) async {
    Map<String, dynamic> data = {};
    try {
      if (filter != null) {
        data = {'filter': filter};
      }
      if (idUser) {
        data = {'user_id': sharedPreferences.getString(AppConstants.ID_USER)};
      }

      if (postId != null) {
        data = {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER),
          'post_id': postId,
        };
      }
      print('queryParameters >> $data');
      Response response = await dioClient.get(
        AppConstants.POST_URI,
        queryParameters: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> post(File file) async {
    try {
      String fileName = file.path.split('/').last;
      print(await file.length());
      FormData formData = FormData.fromMap(
        {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER),
          'file': MultipartFile.fromFileSync(
            file.path,
            filename: fileName,
          ),
        },
      );
      Response response = await dioClient.post(
        AppConstants.POST_URI,
        data: formData,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> like(Map<String, dynamic> data) async {
    try {
      data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);

      Response response =
          await dioClient.post(AppConstants.LIKE_URI, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> comment(Map<String, dynamic> data) async {
    try {
      data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);

      Response response =
          await dioClient.post(AppConstants.COMMENT_URI, data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> commentLike(Map<String, dynamic> data) async {
    try {
      data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);

      Response response = await dioClient.post(
        AppConstants.COMMENT_LIKE_URI,
        data: FormData.fromMap(
          data,
        ),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }
}
