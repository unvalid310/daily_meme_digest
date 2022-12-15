import 'package:daily_meme_digest/data/model/response/language_model.dart';

class AppConstants {
  static const String BASE_URL = 'https://meme.sacm.web.id/';

  static const String REGISTER_URI = 'auth/register';
  static const String LOGIN_URI = 'auth/login';
  static const String POST_URI = 'post';
  static const String LEADERBOARD_URI = 'leaderboard';
  static const String USER_URI = 'user';
  static const String USER_UPDATE_URI = 'user/update';
  static const String COMMENT_URI = 'comment';
  static const String COMMENT_LIKE_URI = 'comment/like';
  static const String LIKE_URI = 'like';

  // Shared Key
  static const String ID_USER = 'id_user';
  static const String NAME = 'name';
  static const String PROFILE_PICTURE = 'profile_picture';
  static const String USERNAME = 'username';
  static const String CREATED_AT = 'created_at';
  static const String PRIVATE = 'private';
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(
        languageName: 'Indonesian', countryCode: 'ID', languageCode: 'id'),
  ];
}
