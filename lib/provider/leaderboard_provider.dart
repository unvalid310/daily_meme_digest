import 'dart:convert';

import 'package:daily_meme_digest/data/model/response/base/api_response.dart';
import 'package:daily_meme_digest/data/model/response/leaderboard_model.dart';
import 'package:daily_meme_digest/data/repository/leaderboard_repo.dart';
import 'package:flutter/material.dart';

class LeaderboardProvider with ChangeNotifier {
  final LeaderboardRepo leaderboardRepo;

  LeaderboardProvider({@required this.leaderboardRepo});

  bool _isLoading;
  List<LeaderboardModel> _leaderboardList;

  bool get isLoading => _isLoading;
  List<LeaderboardModel> get leaderboardList => _leaderboardList;

  Future<void> getLeaderboard() async {
    _isLoading = true;
    _leaderboardList = [];

    ApiResponse apiResponse = await leaderboardRepo.getLeaderboard();
    if (apiResponse.response.statusCode == 200) {
      final jsonData = apiResponse.response.data;
      bool success = jsonData['success'];

      if (success) {
        List data = jsonDecode(jsonEncode(jsonData['data']));
        _leaderboardList = data
            .map(
              (leaderboard) => LeaderboardModel.fromJson(leaderboard),
            )
            .toList();
      }
      _isLoading = false;
    } else {
      _isLoading = false;
    }

    notifyListeners();
  }
}
