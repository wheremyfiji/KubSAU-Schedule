import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/network_service.dart';

final networkProvider = Provider<NetworkService>((ref) {
  return DioNetworkService();
}, name: 'networkProvider');
