import 'dart:convert';

import 'package:daily_meme_digest/data/model/response/base/api_response.dart';
import 'package:daily_meme_digest/data/model/response/response_model.dart';
import 'package:daily_meme_digest/data/model/response/user_model.dart';
import 'package:daily_meme_digest/data/repository/profile_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepo profileRepo;

  ProfileProvider({@required this.profileRepo});

  bool _isLoading;
  UserModel _userModel;

  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;

  Future<UserModel> getProfile() async {
    _isLoading = true;
    UserModel user;
    ApiResponse apiResponse = await profileRepo.getProfile();
    if (apiResponse.response.statusCode == 200) {
      final jsonData = apiResponse.response.data;
      bool success = jsonData['success'];

      if (success) {
        final data = json.decode(json.encode(jsonData['data']));
        print('map >> $data');
        user = UserModel.fromJson(data);
        print('user_id >> ${user.username}');
      }
      _isLoading = false;
    }
    notifyListeners();
    return user;
  }

  Future<ResponseModel> updateProfile(FormData data) async {
    _isLoading = true;
    ResponseModel responseModel;
    ApiResponse apiResponse = await profileRepo.updateProfile(data);
    if (apiResponse.response.statusCode == 200) {
      Map<String, dynamic> data = apiResponse.response.data['data'];
      print('response >>$data');

      profileRepo.saveUserData(
        idUser: data['id'],
        name: data['name'],
        userName: data['username'],
        profilePicture: data['image'],
        createdAt: data['created_at'],
      );

      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    }

    notifyListeners();
    return responseModel;
  }
}
