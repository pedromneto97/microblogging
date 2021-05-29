bool isToday(DateTime dateTime) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

  return date == today;
}
