import 'package:intl/intl.dart';

String formatPublishedDate(String? value) {
  if (value == null || value.isEmpty) return '';
  final date = DateTime.tryParse(value)?.toLocal();
  if (date == null) return '';
  return DateFormat('MMM d, yyyy • h:mm a').format(date);
}
