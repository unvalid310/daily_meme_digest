import 'package:intl/intl.dart';

String getCustomDateFormat(DateTime date, String format) {
  final dateFormat = DateFormat(format, "id_ID").format(date);
  return dateFormat.toString();
}

String getFormattedDate(DateTime date) {
  final dateFormat = DateFormat('d MMM yyyy', "id_ID").format(date);
  return dateFormat.toString();
}

String getShortDate(DateTime date) {
  final dateFormat = DateFormat('yyyy-MM-dd', "id_ID").format(date);
  return dateFormat.toString();
}

String getTime(DateTime date) {
  final dateFormat = DateFormat('hh:mm', 'id_id').format(date);
  return dateFormat.toString();
}
