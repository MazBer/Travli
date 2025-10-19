import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildTripCard(context, index);
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
                'Recently viewed',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildCityCard(context, index);
              },
            ),
            
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, int index) {
    final trips = [
      {'title': 'Hiking in the Alps', 'duration': '3 days'},
      {'title': 'Relaxing on the Maldives', 'duration': '7 days'},
      {'title': 'Exploring Tokyo', 'duration': '5 days'},
    ];
    
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 135,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 48, color: AppColors.secondaryText),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            trips[index]['title']!,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(
            trips[index]['duration']!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildCityCard(BuildContext context, int index) {
    final cities = [
      {'name': 'Paris', 'country': 'France'},
      {'name': 'Rome', 'country': 'Italy'},
      {'name': 'London', 'country': 'United Kingdom'},
    ];
    
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
                  'Popular',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  cities[index]['name']!,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  cities[index]['country']!,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 32, color: AppColors.secondaryText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
