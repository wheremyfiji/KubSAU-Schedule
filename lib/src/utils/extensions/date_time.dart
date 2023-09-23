extension DateTimeExt on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  bool isBetween(DateTime a, DateTime b) {
    final now = DateTime.now();

    if (a.isBefore(now) && b.isAfter(now)) {
      return true;
    } else {
      return false;
    }
  }

  bool isEvenWeek() {
    int currentWeekOfMonth = ((day - 1) / 7).ceil();

    return currentWeekOfMonth % 2 == 0;
  }
}
