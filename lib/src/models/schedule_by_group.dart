class ScheduleByGroup {
  final String group;
  final List<ScheduleWeek>? weeks;

  ScheduleByGroup({
    required this.group,
    required this.weeks,
  });

  factory ScheduleByGroup.fromJson(Map<String, dynamic> json) =>
      ScheduleByGroup(
        group: json["group"]["name"],
        weeks: json["weeks"] == null
            ? null
            : List<ScheduleWeek>.from(
                json["weeks"]!.map(
                  (x) => ScheduleWeek.fromJson(x),
                ),
              ),
      );
}

class ScheduleWeek {
  final int weekNumber;
  final List<ScheduleDay>? lessons;
  final DateTime? dtUpdated;
  final DateTime? dtChecked;

  ScheduleWeek({
    required this.weekNumber,
    this.lessons,
    this.dtUpdated,
    this.dtChecked,
  });

  factory ScheduleWeek.fromJson(Map<String, dynamic> json) {
    Map<int, List<ScheduleLesson>> groupedMap = {};

    for (var lessonsJson in json["lessons"]) {
      final lesson = ScheduleLesson.fromJson(lessonsJson);
      final day = lesson.dayOfWeek;

      if (day == null) {
        break;
      }

      if (!groupedMap.containsKey(day)) {
        groupedMap[day] = [];
      }

      groupedMap[day]!.add(lesson);
    }

    final groupedLessons = groupedMap.entries
        .map((entry) => ScheduleDay(dayOfWeek: entry.key, lessons: entry.value))
        .toList();

    return ScheduleWeek(
      weekNumber: json["week_number"],
      lessons: groupedLessons,
      dtUpdated: json["dt_updated"] == null
          ? null
          : DateTime.parse(json["dt_updated"]),
      dtChecked: json["dt_checked"] == null
          ? null
          : DateTime.parse(json["dt_checked"]),
    );
  }
}

class ScheduleDay {
  final int dayOfWeek;
  final List<ScheduleLesson>? lessons;

  ScheduleDay({
    required this.dayOfWeek,
    this.lessons,
  });
}

class ScheduleLesson {
  final int? dayOfWeek;
  final int? lessonNumber;
  final bool? isLecture;
  final String? discipline;
  final List<String>? teachers;
  final List<String>? audiences;

  ScheduleLesson({
    this.dayOfWeek,
    this.lessonNumber,
    this.isLecture,
    this.discipline,
    this.teachers,
    this.audiences,
  });

  factory ScheduleLesson.fromJson(Map<String, dynamic> json) => ScheduleLesson(
        dayOfWeek: json["day_of_week"],
        lessonNumber: json["lesson_number"],
        isLecture: json["is_lecture"],
        discipline:
            json["discipline"] == null ? null : json["discipline"]["name"],
        teachers: json["teachers"] == null
            ? null
            : List<String>.from(json["teachers"]!.map((x) => x["fio"])),
        audiences: json["audiences"] == null
            ? null
            : List<String>.from(json["audiences"]!.map((x) => x["name"])),
      );
}
