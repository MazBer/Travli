import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/services/aco_service.dart';
import '../../core/providers/units_provider.dart';
import '../../l10n/app_localizations.dart';

class RouteResultScreen extends ConsumerWidget {
  final AcoResult result;

  const RouteResultScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final unitSystem = ref.watch(unitsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.optimizedRoute),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Route Summary Card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(AppSpacing.lg),
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.route,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.optimizedRoute,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      context,
                      Icons.location_on,
                      '${result.route.length}',
                      l10n.places,
                    ),
                    _buildStatItem(
                      context,
                      Icons.straighten,
                      result.totalDistance.toDistanceString(unitSystem),
                      'Distance',
                    ),
                    _buildStatItem(
                      context,
                      Icons.access_time,
                      result.estimatedTime,
                      'Est. Time',
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Route Steps
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: result.route.length,
              itemBuilder: (context, index) {
                final place = result.route[index];
                final isFirst = index == 0;
                final isLast = index == result.route.length - 1;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step indicator
                    Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isFirst || isLast
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: isFirst
                                ? const Icon(Icons.flag, color: Colors.white, size: 18)
                                : isLast
                                    ? const Icon(Icons.location_on, color: Colors.white, size: 18)
                                    : Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 60,
                            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                          ),
                      ],
                    ),
                    const SizedBox(width: AppSpacing.md),

                    // Place info
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: AppSpacing.md),
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Row(
                              children: [
                                Icon(
                                  Icons.category,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  place.category,
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                ),
                              ],
                            ),
                            if (place.address != null) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                  const SizedBox(width: AppSpacing.xs),
                                  Expanded(
                                    child: Text(
                                      place.address!,
                                      style: Theme.of(context).textTheme.bodySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: FilledButton.icon(
            onPressed: () => _openInGoogleMaps(context),
            icon: const Icon(Icons.map),
            label: const Text('View on Map'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            ),
          ),
        ),
      ),
    );
  }

  /// Open the optimized route in Google Maps
  Future<void> _openInGoogleMaps(BuildContext context) async {
    if (result.route.isEmpty) return;

    try {
      // For single place, just show the location
      if (result.route.length == 1) {
        final place = result.route.first;
        final url = 'https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}';
        final uri = Uri.parse(url);
        
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
        return;
      }
      
      // Build Google Maps URL with directions for multiple places
      
      // Determine origin based on starting location
      String originCoords;
      List<String> waypoints = [];
      
      // Get transport mode first to handle transit limitation
      final travelMode = result.transportMode ?? 'driving';
      final isTransitMode = travelMode == 'transit';
      
      if (result.startingLocation != null && 
          result.startingLocation!['type'] == 'gps' &&
          result.startingLocation!['latitude'] != null) {
        // Use GPS coordinates as origin
        final lat = result.startingLocation!['latitude'];
        final lng = result.startingLocation!['longitude'];
        originCoords = '$lat,$lng';
        
        // For transit mode, skip waypoints (Google Maps limitation)
        // All route places become waypoints except the last (destination)
        if (!isTransitMode) {
          for (int i = 0; i < result.route.length - 1; i++) {
            final place = result.route[i];
            waypoints.add('${place.latitude},${place.longitude}');
          }
        }
      } else {
        // Use first place as origin
        final origin = result.route.first;
        originCoords = '${origin.latitude},${origin.longitude}';
        
        // For transit mode, skip waypoints (Google Maps limitation)
        // Build waypoints (all places except first and last)
        if (!isTransitMode) {
          for (int i = 1; i < result.route.length - 1; i++) {
            final place = result.route[i];
            waypoints.add('${place.latitude},${place.longitude}');
          }
        }
      }
      
      final destination = result.route.last;
      
      // Construct Google Maps URL
      String url = 'https://www.google.com/maps/dir/?api=1';
      url += '&origin=$originCoords';
      url += '&destination=${destination.latitude},${destination.longitude}';
      
      // Google Maps doesn't support waypoints with transit mode
      if (waypoints.isNotEmpty && !isTransitMode) {
        url += '&waypoints=${waypoints.join('|')}';
      }
      url += '&travelmode=$travelMode';
      
      // Debug logging
      print('=== Google Maps Debug ===');
      print('Transport mode: $travelMode');
      if (isTransitMode) {
        print('⚠️  Transit mode: Waypoints disabled (Google Maps limitation)');
      }
      print('Starting location type: ${result.startingLocation?['type']}');
      if (result.startingLocation?['type'] == 'gps') {
        print('GPS Origin: ${result.startingLocation?['latitude']}, ${result.startingLocation?['longitude']}');
      }
      print('Origin: $originCoords');
      print('Destination: ${destination.latitude},${destination.longitude}');
      print('Waypoints: ${waypoints.length}${isTransitMode ? ' (skipped for transit)' : ''}');
      print('Full URL: $url');
      print('========================');
      
      final uri = Uri.parse(url);
      
      // Try to launch with external app first (Google Maps)
      bool launched = false;
      try {
        if (await canLaunchUrl(uri)) {
          launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } catch (e) {
        print('Failed to launch with external app: $e');
      }
      
      // If external app failed, try browser
      if (!launched) {
        try {
          print('Trying to open in browser...');
          launched = await launchUrl(uri, mode: LaunchMode.platformDefault);
        } catch (e) {
          print('Failed to launch in browser: $e');
        }
      }
      
      // Show error if both methods failed
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Could not open Google Maps. Please install Google Maps app.'),
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening map: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Widget _buildStatItem(BuildContext context, IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 28,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
              ),
        ),
      ],
    );
  }
}
