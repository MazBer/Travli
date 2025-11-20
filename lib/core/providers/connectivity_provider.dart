import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Stream of connectivity changes (wifi/mobile/offline)
/// Note: connectivity_plus 6.x uses `Stream<List<ConnectivityResult>>`.
final connectivityStreamProvider =
    StreamProvider<List<ConnectivityResult>>((ref) {
  final connectivity = Connectivity();
  return connectivity.onConnectivityChanged;
});

/// Simple "is online" boolean derived from connectivity.
/// Falls back to true while the first value is loading to avoid flicker.
final isOnlineProvider = Provider<bool>((ref) {
  final asyncResult = ref.watch(connectivityStreamProvider);
  return asyncResult.maybeWhen(
    data: (results) =>
        results.any((result) => result != ConnectivityResult.none),
    orElse: () => true,
  );
});
