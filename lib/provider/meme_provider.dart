import 'dart:convert';
import 'dart:io';

import 'package:daily_meme_digest/data/model/response/base/api_response.dart';
import 'package:daily_meme_digest/data/model/response/meme_model.dart';
import 'package:daily_meme_digest/data/model/response/response_model.dart';
import 'package:daily_meme_digest/data/repository/post_repo.dart';
import 'package:flutter/material.dart';

class MemeProvider with ChangeNotifier {
  final PostRepo memeRepo;

  MemeProvider({@required this.memeRepo});

  bool _isLoading;
  MemeModel _detailMeme;
  List<MemeModel> _memeList;

  bool get isLoading => _isLoading;
  List<MemeModel> get memeList => _memeList;
  MemeModel get detailMeme => _detailMeme;

  Future<void> getMeme(
      {bool collection = false,
      bool refresh = false,
      String filter = '0'}) async {
    if (!refresh) _isLoading = true;
    _memeList = [];

    ApiResponse response =
        await memeRepo.getPost(idUser: collection, filter: filter);
    if (response.response.statusCode == 200) {
      final jsonData = response.response.data;
      bool success = jsonData['success'];

      if (success) {
        List data = jsonDecode(jsonEncode(jsonData['data']));

        _memeList = data
            .map((meme) => MemeModel.fromJson(meme as Map<String, dynamic>))
            .toList();
      }
      _isLoading = false;
    } else {
      _isLoading = false;
    }

    notifyListeners();
  }

  Future<void> getDetailPost(
      {@required int postId, bool refresh = false}) async {
    if (!refresh) _isLoading = true;
    print('post_id >> $postId');
    ApiResponse response = await memeRepo.getPost(postId: postId);
    if (response.response.statusCode == 200) {
      final jsonData = response.response.data;
      bool success = jsonData['success'];

      if (success) {
        List data = jsonDecode(jsonEncode(jsonData['data']));

        data
            .map(
              (meme) => _detailMeme =
                  MemeModel.fromJson(meme as Map<String, dynamic>),
            )
            .toList();
      }
      _isLoading = false;
    } else {
      _isLoading = false;
    }

    notifyListeners();
  }

  Future<ResponseModel> postMeme(File file) async {
    ApiResponse apiResponse = await memeRepo.post(file);
    ResponseModel responseModel;

    if (apiResponse.response.statusCode == 200) {
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

  Future<ResponseModel> like(Map<String, dynamic> data) async {
    ApiResponse apiResponse = await memeRepo.like(data);
    ResponseModel responseModel;
    if (apiResponse.response.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response.data['is_like'],
          apiResponse.response.data['message']);
      _isLoading = false;
    } else {
      responseModel = ResponseModel(false, 'Terjadi Kesalahan');
      _isLoading = false;
    }

    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> comment(Map<String, dynamic> data) async {
    ApiResponse apiResponse = await memeRepo.comment(data);
    ResponseModel responseModel;
    if (apiResponse.response.statusCode == 200) {
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

  Future<ResponseModel> commentLike(Map<String, dynamic> data) async {
    ApiResponse apiResponse = await memeRepo.commentLike(data);
    ResponseModel responseModel;
    if (apiResponse.response.statusCode == 200) {
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
