import 'package:intl/intl.dart';

String convertDate(DateTime dateTime) {
  final dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSSZ");
  final date = dateFormat.parse(dateTime.toString());
  final outputFormat = DateFormat("MMM d HH:mm");
  final outputString = outputFormat.format(date);
  return outputString; // prints "May 13 17:36"
}
