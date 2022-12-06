import 'package:flutter/material.dart';
import 'package:daily_meme_digest/data/model/response/language_model.dart';
import 'package:daily_meme_digest/util/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return AppConstants.languages;
  }
}
