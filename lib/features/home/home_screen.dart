import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/providers/history_provider.dart';
import '../../models/city.dart';
import '../../models/route.dart';
import '../search/search_screen.dart'; // For CityPlacesScreen

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('[HomeScreen] Build method called.');
    final l10n = AppLocalizations.of(context)!;
    final historyState = ref.watch(historyProvider);
    final recentCities = historyState.recentCities;
    final recentRoutes = historyState.recentRoutes;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              // TODO: Navigate to profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recent trips section
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Text(
                l10n.recentTrips,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            
            SizedBox(
              height: 200,
              child: recentRoutes.isEmpty
                  ? Center(
                      child: Text(
                        l10n.noRecentTrips,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      itemCount: recentRoutes.length,
                      itemBuilder: (context, index) {
                        return _buildTripCard(context, recentRoutes[index]);
                      },
                    ),
            ),
            
            // Recently viewed section
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Text(
                l10n.recentlyViewed,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            
            recentCities.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Center(
                      child: Text(
                        l10n.noRecentlyViewed,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    itemCount: recentCities.length,
                    itemBuilder: (context, index) {
                      return _buildCityCard(context, recentCities[index]);
                    },
                  ),
            
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, TravelRoute route) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 135,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Center(
              child: Icon(
                Icons.route,
                size: 48,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            route.name,
            style: Theme.of(context).textTheme.labelLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${route.formattedDistance} • ${route.formattedDuration}',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildCityCard(BuildContext context, City city) {
    return InkWell(
      onTap: () {
        // Navigate to the city places screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CityPlacesScreen(city: city),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recently viewed',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    city.name,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    city.country,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Center(
                  child: Icon(
                    Icons.location_city,
                    size: 32,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
