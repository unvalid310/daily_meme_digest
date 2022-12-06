import 'package:flutter/material.dart';
import 'package:daily_meme_digest/localization/app_localization.dart';

String getTranslated(String key, BuildContext context) {
  return AppLocalization.of(context).translate(key);
}
