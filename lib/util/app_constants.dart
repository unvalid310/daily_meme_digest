import 'package:daily_meme_digest/data/model/response/language_model.dart';

class AppConstants {
  static const String BASE_URL = 'https://notes.sacm.web.id/';

  static const String REGISTER_URI = 'auth/register';
  static const String LOGIN_URI = 'auth/login';
  static const String MEMBERS_URI = 'user';
  static const String PROJECT_URI = 'project';
  static const String DELETE_PROJECT_URI = 'project/delete';
  static const String PINNED_PROJECT_URI = 'project/pinned';
  static const String UNPINNED_PROJECT_URI = 'project/unpinned';
  static const String TASK_URI = 'task';
  static const String UPDATE_TASK_URI = 'task/update';
  static const String UPLOAD_TASK_FIlE_URI = 'task/file';

  // Shared Key
  static const String ID_USER = 'id_user';
  static const String EMAIL = 'email';
  static const String USERNAME = 'username';
  static const String PASSWORD = 'password';
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
