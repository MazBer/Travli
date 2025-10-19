import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const String _historyKey = 'search_history';
  static const int _maxHistory = 10;

  /// Get search history
  Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_historyKey) ?? [];
    return historyJson;
  }

  /// Add search to history
  Future<void> addToHistory(String query) async {
    if (query.trim().isEmpty) return;
    
    final prefs = await SharedPreferences.getInstance();
    var history = prefs.getStringList(_historyKey) ?? [];
    
    // Remove if already exists
    history.remove(query);
    
    // Add to beginning
    history.insert(0, query);
    
    // Keep only last N items
    if (history.length > _maxHistory) {
      history = history.sublist(0, _maxHistory);
    }
    
    await prefs.setStringList(_historyKey, history);
  }

  /// Clear search history
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  /// Remove specific item from history
  Future<void> removeFromHistory(String query) async {
    final prefs = await SharedPreferences.getInstance();
    var history = prefs.getStringList(_historyKey) ?? [];
    history.remove(query);
    await prefs.setStringList(_historyKey, history);
  }
}
