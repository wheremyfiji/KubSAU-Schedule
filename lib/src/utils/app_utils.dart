import 'package:flutter/material.dart';

import '../models/lesson_time.dart';
import 'extensions/buildcontext.dart';

class AppUtils {
  bool timeIsBetween(TimeOfDay current, TimeOfDay start, TimeOfDay end) {
    //final now = TimeOfDay.now();

    final currentMinutes = current.hour * 60 + current.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
  }

  LessonTime getLessonTime(int number) {
    return lessonTimeList[number - 1];
  }

  void showSnackBar(
    BuildContext context, {
    required String content,
    Duration? duration,
  }) {
    final snackBar = SnackBar(
      content: Text(
        content,
        style: TextStyle(
          color: context.colorScheme.onSurfaceVariant,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.colorScheme.surfaceVariant,
      dismissDirection: DismissDirection.horizontal,
      duration: duration ?? const Duration(seconds: 1),
    );

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(snackBar);
  }

  void showErrorSnackBar(
    BuildContext context, {
    required String content,
    Duration? duration,
  }) {
    final snackBar = SnackBar(
      content: Text(
        content,
        style: TextStyle(
          color: context.colorScheme.onErrorContainer,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.colorScheme.errorContainer,
      dismissDirection: DismissDirection.horizontal,
      duration: duration ?? const Duration(seconds: 3),
    );

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(snackBar);
  }
}
