import 'package:flutter/foundation.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/schedule_by_group.dart';
import '../services/storage_service.dart';
import '../utils/extensions/date_time.dart';
import 'schedule_api_provider.dart';

final homePageProvider =
    ChangeNotifierProvider.autoDispose<HomePageNotifier>((ref) {
  return HomePageNotifier(
    scheduleApi: ref.read(scheduleApiProvider),
  );
}, name: 'homePageProvider');

class HomePageNotifier extends ChangeNotifier {
  final ScheduleApi scheduleApi;
  AsyncValue<ScheduleByGroup> scheduleAsync;

  HomePageNotifier({required this.scheduleApi})
      : scheduleAsync = const AsyncValue.loading() {
    init();
  }

  late DateTime now;
  late bool isEvenWeek;
  late int currentWeek;
  late int currentDayOfWeek;

  int selectedWeek = 0;

  void changeWeek(int n) {
    selectedWeek = n;

    notifyListeners();
  }

  void init() async {
    now = DateTime.now();

    isEvenWeek = now.isEvenWeek();
    currentWeek = isEvenWeek ? 1 : 0;
    selectedWeek = isEvenWeek ? 1 : 0;
    currentDayOfWeek = now.weekday;

    if (currentDayOfWeek == DateTime.sunday) {
      currentDayOfWeek = DateTime.monday;
      isEvenWeek = !isEvenWeek;
      currentWeek = isEvenWeek ? 1 : 0;
      selectedWeek = isEvenWeek ? 1 : 0;
    }

    scheduleAsync = await AsyncValue.guard(() async {
      final schedule = await scheduleApi.getScheduleByGroup(
        groupName: StorageService.instance.userGroup,
      );
      return schedule;
    });

    notifyListeners();
  }
}
