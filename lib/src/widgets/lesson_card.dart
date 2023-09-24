import 'package:flutter/material.dart';

import '../models/lesson_time.dart';
import '../models/schedule_by_group.dart';
import '../utils/extensions/buildcontext.dart';
import 'custom_info_chip.dart';

class LessonCard extends StatelessWidget {
  final ScheduleLesson lesson;
  final LessonTime time;
  final bool current;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.time,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final lessonNumber = lesson.lessonNumber ?? 1;
    final isLecture = lesson.isLecture ?? false;
    final disciplineName = lesson.discipline ?? 'disciplineName';
    final teachers = lesson.teachers!.join(', ');
    final audiences = lesson.audiences!.join(', ');

    return Card(
      color: current ? context.colorScheme.primaryContainer : null,
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    '$lessonNumber пара (${time.toFormattedString()})',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                if (isLecture)
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: CustomInfoChip(
                      label: 'Лекция',
                    ),
                  ),
              ],
            ),
            Divider(
              color: context.colorScheme.outline.withOpacity(
                0.5,
              ),
            ),
            Text(
              disciplineName,
              style: context.textTheme.labelMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              '$audiences • $teachers',
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
