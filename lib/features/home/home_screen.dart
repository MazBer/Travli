import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/providers/data_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentCitiesAsync = ref.watch(recentCitiesProvider);
    final recentRoutesAsync = ref.watch(recentRoutesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
                'Recent trips',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            
            SizedBox(
              height: 200,
              child: recentRoutesAsync.when(
                data: (routes) {
                  if (routes.isEmpty) {
                    return Center(
                      child: Text(
                        'No recent trips yet',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    itemCount: routes.length,
                    itemBuilder: (context, index) {
                      return _buildTripCard(context, routes[index]);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
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
                'Recently viewed',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            
            recentCitiesAsync.when(
              data: (cities) {
                if (cities.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Center(
                      child: Text(
                        'No recently viewed cities',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    return _buildCityCard(context, cities[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
            
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, route) {
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

  Widget _buildCityCard(BuildContext context, city) {
    return Container(
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
    );
  }
}
