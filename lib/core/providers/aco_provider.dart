import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/aco_service.dart';

/// Provider for ACO service
final acoServiceProvider = Provider<AcoService>((ref) {
  return AcoService();
});
