import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/network_service.dart';

final networkProvider = Provider<NetworkService>((ref) {
  final cacheStore = ref.watch(dioCacheStroreProvider);

  return DioNetworkService(cacheStore: cacheStore);
}, name: 'networkProvider');

final dioCacheStroreProvider = Provider<HiveCacheStore>(
  (ref) => throw UnimplementedError(),
  name: 'dioCacheStroreProvider',
);
