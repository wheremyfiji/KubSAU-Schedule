import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/environment_service.dart';

final environmentProvider = Provider<EnvironmentService>(
  (ref) => throw UnimplementedError(),
  name: 'environmentProvider',
);
