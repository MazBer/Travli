import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final searchResults = ref.watch(citySearchResultsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.search),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchForCity,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(citySearchQueryProvider.notifier).state = '';
                          setState(() {});
                        },
                      )
                    : null,
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50), // Circular/pill shape
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
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
                l10n.searchResults,
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
                        l10n.noCitiesFound,
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
                      l10n.recentSearches,
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

// Selected places provider
final selectedPlacesProvider = StateProvider<Set<int>>((ref) => {});

// City Places Screen
class CityPlacesScreen extends ConsumerStatefulWidget {
  final City city;

  const CityPlacesScreen({super.key, required this.city});

  @override
  ConsumerState<CityPlacesScreen> createState() => _CityPlacesScreenState();
}

class _CityPlacesScreenState extends ConsumerState<CityPlacesScreen> {
  int _displayCount = 15; // Initial number of places to show
  static const int _loadMoreIncrement = 10; // Load 10 more each time
  
  @override
  void initState() {
    super.initState();
    // Clear selection when entering this screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedPlacesProvider.notifier).state = {};
      _displayCount = 15; // Reset display count
    });
  }
  
  void _loadMore() {
    setState(() {
      _displayCount += _loadMoreIncrement;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final placesAsync = ref.watch(cityPlacesProvider);
    final selectedPlaces = ref.watch(selectedPlacesProvider);
    final currentLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city.name),
        actions: [
          if (selectedPlaces.isNotEmpty)
            TextButton(
              onPressed: () {
                // Clear selection
                ref.read(selectedPlacesProvider.notifier).state = {};
              },
              child: Text(
                l10n.clearSelection,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Selection info capsule
          if (selectedPlaces.isNotEmpty)
            Center(
              child: Container(
                margin: const EdgeInsets.only(
                  top: AppSpacing.md,
                  bottom: AppSpacing.sm,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '${selectedPlaces.length} ${l10n.placesSelected}',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
          // Places list
          Expanded(
            child: placesAsync.when(
        data: (allPlaces) {
          if (allPlaces.isEmpty) {
            return Center(
              child: Text(
                'No places found in ${widget.city.name}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          }
          
          // Limit displayed places based on _displayCount
          final displayedPlaces = allPlaces.take(_displayCount).toList();
          final hasMore = allPlaces.length > _displayCount;
          
          return Column(
            children: [
              // Places count indicator
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: Text(
                  l10n.showingPlaces(displayedPlaces.length),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              
              // Places list
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    left: AppSpacing.lg,
                    right: AppSpacing.lg,
                    top: AppSpacing.sm,
                    bottom: selectedPlaces.length >= 2 ? 80 : AppSpacing.lg,
                  ),
                  itemCount: displayedPlaces.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Load More button at the end
                    if (index == displayedPlaces.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                        child: Center(
                          child: OutlinedButton.icon(
                            onPressed: _loadMore,
                            icon: const Icon(Icons.add),
                            label: Text(l10n.loadMore),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xl,
                                vertical: AppSpacing.md,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    
                    final place = displayedPlaces[index];
                    final isSelected = selectedPlaces.contains(index);
                    final localizedName = place.getLocalizedName(currentLanguage);
                    
                    // Debug: Print for first place
                    if (index == 0) {
                      print('Current language: $currentLanguage');
                      print('Place original name: ${place.name}');
                      print('Localized names available: ${place.localizedNames.keys.toList()}');
                      print('Localized name shown: $localizedName');
                    }
              
                    return InkWell(
                      onTap: () {
                        final current = ref.read(selectedPlacesProvider);
                        if (isSelected) {
                          ref.read(selectedPlacesProvider.notifier).state = 
                            current.where((id) => id != index).toSet();
                        } else {
                          ref.read(selectedPlacesProvider.notifier).state = 
                            {...current, index};
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        padding: const EdgeInsets.all(AppSpacing.md),
                        transform: Matrix4.identity()..scale(isSelected ? 1.02 : 1.0),
                        decoration: BoxDecoration(
                          color: isSelected 
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          border: isSelected
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              )
                            : null,
                          boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
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
                                    localizedName,
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
                            // Checkbox on the right
                            Checkbox(
                              value: isSelected,
                              onChanged: (value) {
                                final current = ref.read(selectedPlacesProvider);
                                if (value == true) {
                                  ref.read(selectedPlacesProvider.notifier).state = 
                                    {...current, index};
                                } else {
                                  ref.read(selectedPlacesProvider.notifier).state = 
                                    current.where((id) => id != index).toSet();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
          ),
        ],
      ),
      // Generate Route button
      bottomNavigationBar: selectedPlaces.length >= 2
        ? SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: FilledButton(
                onPressed: () {
                  // TODO: Navigate to route generation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.generatingRoute),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                ),
                child: Text(
                  l10n.generateRoute,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
        : null,
    );
  }
}
