import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UnitSystem {
  metric,
  imperial,
}

class UnitsNotifier extends StateNotifier<UnitSystem> {
  UnitsNotifier() : super(UnitSystem.metric) {
    _loadUnits();
  }

  static const String _key = 'unit_system';

  Future<void> _loadUnits() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUnit = prefs.getString(_key);
    if (savedUnit != null) {
      state = UnitSystem.values.firstWhere(
        (e) => e.name == savedUnit,
        orElse: () => UnitSystem.metric,
      );
    }
  }

  Future<void> setUnitSystem(UnitSystem system) async {
    state = system;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, system.name);
  }
}

final unitsProvider = StateNotifierProvider<UnitsNotifier, UnitSystem>((ref) {
  return UnitsNotifier();
});

// Helper extension for unit conversions
extension UnitConversion on double {
  // Distance conversions
  String toDistanceString(UnitSystem system) {
    if (system == UnitSystem.metric) {
      if (this < 1) {
        return '${(this * 1000).toStringAsFixed(0)} m';
      }
      return '${toStringAsFixed(1)} km';
    } else {
      // Convert km to miles
      final miles = this * 0.621371;
      if (miles < 0.1) {
        final feet = miles * 5280;
        return '${feet.toStringAsFixed(0)} ft';
      }
      return '${miles.toStringAsFixed(1)} mi';
    }
  }

  // Speed conversions
  String toSpeedString(UnitSystem system) {
    if (system == UnitSystem.metric) {
      return '${toStringAsFixed(0)} km/h';
    } else {
      final mph = this * 0.621371;
      return '${mph.toStringAsFixed(0)} mph';
    }
  }
}
