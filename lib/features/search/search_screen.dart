import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/providers/api_providers.dart';
import '../../core/providers/language_provider.dart';
import '../../core/services/search_history_service.dart';
import '../../models/city.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SearchHistoryService _historyService = SearchHistoryService();
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSearchHistory() async {
    final history = await _historyService.getHistory();
    setState(() {
      _searchHistory = history;
    });
  }

  void _onCitySelected(City city) async {
    // Save to history
    await _historyService.addToHistory(city.name);
    await _loadSearchHistory();
    
    ref.read(selectedCityProvider.notifier).state = city;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CityPlacesScreen(city: city),
      ),
    );
  }

  void _onHistoryItemTap(String query) {
    _searchController.text = query;
    ref.read(citySearchQueryProvider.notifier).state = query;
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(citySearchResultsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for a city...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                ref.read(citySearchQueryProvider.notifier).state = value;
                setState(() {}); // Rebuild to show/hide clear button
              },
            ),
          ),
          
          // Results section
          if (_searchController.text.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                'Cities',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            
            Expanded(
              child: searchResults.when(
                data: (cities) {
                  if (cities.isEmpty) {
                    return Center(
                      child: Text(
                        'No cities found',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      return _buildCityItem(context, cities[index]);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text('Error: ${error.toString()}'),
                ),
              ),
            ),
          ] else ...[
            // Search history
            if (_searchHistory.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Searches',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    TextButton(
                      onPressed: () async {
                        await _historyService.clearHistory();
                        await _loadSearchHistory();
                      },
                      child: Text('Clear'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: _searchHistory.length,
                itemBuilder: (context, index) {
                  final query = _searchHistory[index];
                  return ListTile(
                    leading: Icon(
                      Icons.history,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(query),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () async {
                        await _historyService.removeFromHistory(query);
                        await _loadSearchHistory();
                      },
                    ),
                    onTap: () => _onHistoryItemTap(query),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
            
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 64,
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Search for a city to explore',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCityItem(BuildContext context, City city) {
    final currentLanguage = ref.watch(languageProvider);
    final translationService = ref.watch(translationServiceProvider);
    
    final translatedCityName = city.getTranslatedName(currentLanguage, translationService);
    final translatedCountryName = city.getTranslatedCountry(currentLanguage, translationService);
    
    return InkWell(
      onTap: () => _onCitySelected(city),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Row(
          children: [
            Container(
              width: AppSpacing.avatarMd,
              height: AppSpacing.avatarMd,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                Icons.location_city,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translatedCityName,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    translatedCountryName,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

// City Places Screen
class CityPlacesScreen extends ConsumerWidget {
  final City city;

  const CityPlacesScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(cityPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: placesAsync.when(
        data: (places) {
          if (places.isEmpty) {
            return Center(
              child: Text(
                'No places found in ${city.name}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppSpacing.avatarMd,
                      height: AppSpacing.avatarMd,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: Icon(
                        Icons.place,
                        size: 24,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place.name,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            place.category,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          if (place.address != null)
                            Text(
                              place.address!,
                              style: Theme.of(context).textTheme.labelSmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error loading places'),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
