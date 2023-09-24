import 'package:flutter/material.dart';

import '../utils/extensions/time_of_day.dart';

class LessonTime {
  final int number; // 1-6
  final TimeOfDay start;
  final TimeOfDay end;

  LessonTime({
    required this.number,
    required this.start,
    required this.end,
  });

  String toFormattedString() {
    return '${start.toFormattedString()} - ${end.toFormattedString()}';
    //return '${start.toFormattedString()}\n${end.toFormattedString()}';
  }
}

final List<LessonTime> lessonTimeList = [
  LessonTime(
    number: 1,
    start: const TimeOfDay(hour: 8, minute: 0),
    end: const TimeOfDay(hour: 9, minute: 30),
  ),
  LessonTime(
    number: 2,
    start: const TimeOfDay(hour: 9, minute: 45),
    end: const TimeOfDay(hour: 11, minute: 15),
  ),
  LessonTime(
    number: 3,
    start: const TimeOfDay(hour: 11, minute: 30),
    end: const TimeOfDay(hour: 13, minute: 0),
  ),
  LessonTime(
    number: 4,
    start: const TimeOfDay(hour: 13, minute: 50),
    end: const TimeOfDay(hour: 15, minute: 20),
  ),
  LessonTime(
    number: 5,
    start: const TimeOfDay(hour: 15, minute: 35),
    end: const TimeOfDay(hour: 17, minute: 5),
    // start: const TimeOfDay(hour: 0, minute: 0),
    // end: const TimeOfDay(hour: 23, minute: 59),
  ),
  LessonTime(
    number: 6,
    start: const TimeOfDay(hour: 17, minute: 20),
    end: const TimeOfDay(hour: 18, minute: 50),
  ),
];

final List<LessonTime> lessonSaturdayTimeList = [
  LessonTime(
    number: 1,
    start: const TimeOfDay(hour: 8, minute: 0),
    end: const TimeOfDay(hour: 9, minute: 30),
  ),
  LessonTime(
    number: 2,
    start: const TimeOfDay(hour: 9, minute: 45),
    end: const TimeOfDay(hour: 11, minute: 15),
  ),
  LessonTime(
    number: 3,
    start: const TimeOfDay(hour: 11, minute: 30),
    end: const TimeOfDay(hour: 13, minute: 0),
  ),
  LessonTime(
    number: 4,
    start: const TimeOfDay(hour: 13, minute: 15),
    end: const TimeOfDay(hour: 14, minute: 45),
  ),
  LessonTime(
    number: 5,
    start: const TimeOfDay(hour: 15, minute: 0),
    end: const TimeOfDay(hour: 16, minute: 30),
  ),
  LessonTime(
    number: 6,
    start: const TimeOfDay(hour: 16, minute: 45),
    end: const TimeOfDay(hour: 18, minute: 15),
  ),
];
