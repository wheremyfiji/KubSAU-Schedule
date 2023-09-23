import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/schedule_by_group.dart';
import '../services/network_service.dart';
import 'network_provider.dart';

final scheduleApiProvider = Provider<ScheduleApi>((ref) {
  final client = ref.watch(networkProvider);

  return ScheduleApi(client);
}, name: 'scheduleApiProvider');

class ScheduleApi {
  final NetworkService client;

  ScheduleApi(this.client);

  Future<ScheduleByGroup> getScheduleByGroup({
    required String groupName,
  }) async {
    final response = await client.get(
      'schedule/group/$groupName',
    );

    return ScheduleByGroup.fromJson(response);
  }
}
