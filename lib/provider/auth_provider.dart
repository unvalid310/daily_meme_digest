import 'package:flutter/cupertino.dart';
import 'package:daily_meme_digest/data/model/response/base/api_response.dart';
import 'package:daily_meme_digest/data/model/response/response_model.dart';
import 'package:daily_meme_digest/data/repository/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({@required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(Map<String, dynamic> data) async {
    _isLoading = true;
    ResponseModel responseModel;
    ApiResponse apiResponse = await authRepo.registration(data);
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    }
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> login(String username, String password) async {
    _isLoading = true;
    ApiResponse apiResponse = await authRepo.login(username, password);
    ResponseModel responseModel;
    if (apiResponse.response.data['success']) {
      Map<String, dynamic> data = apiResponse.response.data['data'];

      authRepo.saveUserData(
        idUser: data['id'],
        name: data['name'],
        userName: data['username'],
        profilePicture: data['image'],
        createdAt: data['created_at'],
      );

      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isLoading = false;
    }

    notifyListeners();
    return responseModel;
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> logout() async {
    bool status = false;
    status = await authRepo.clearSharedData().then((value) {
      return value;
    });
    return status;
  }
}
