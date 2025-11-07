import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../l10n/app_localizations.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/providers/aco_provider.dart';
import '../../core/services/aco_service.dart';
import '../../models/place.dart';
import 'route_result_screen.dart';

// Transport mode enum
enum TransportMode {
  walking,
  driving,
  publicTransport,
  cycling,
}

// Starting location type enum
enum StartingLocationType {
  currentLocation,
  customAddress,
  firstPlace,
}

// Providers for route configuration
final transportModeProvider = StateProvider<TransportMode>((ref) => TransportMode.walking);
final startingLocationTypeProvider = StateProvider<StartingLocationType>((ref) => StartingLocationType.firstPlace);
final customAddressProvider = StateProvider<String?>((ref) => null);

class RouteConfigScreen extends ConsumerStatefulWidget {
  final List<Place> selectedPlaces;

  const RouteConfigScreen({
    super.key,
    required this.selectedPlaces,
  });

  @override
  ConsumerState<RouteConfigScreen> createState() => _RouteConfigScreenState();
}

class _RouteConfigScreenState extends ConsumerState<RouteConfigScreen> {
  final TextEditingController _addressController = TextEditingController();
  bool _isLoadingLocation = false;
  Position? _currentPosition; // Store GPS position

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      // Store the position
      setState(() {
        _currentPosition = position;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location acquired: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error getting location: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      setState(() => _isLoadingLocation = false);
    }
  }

  void _generateRoute() async {
    final l10n = AppLocalizations.of(context)!;
    final transportMode = ref.read(transportModeProvider);
    final startingLocationType = ref.read(startingLocationTypeProvider);
    final customAddress = ref.read(customAddressProvider);
    
    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Text(l10n.generatingRoute),
          ],
        ),
        duration: const Duration(seconds: 30),
      ),
    );

    try {
      // Convert transport mode to Google Maps format
      String googleMapsMode;
      switch (transportMode) {
        case TransportMode.walking:
          googleMapsMode = 'walking';
          break;
        case TransportMode.driving:
          googleMapsMode = 'driving';
          break;
        case TransportMode.publicTransport:
          googleMapsMode = 'transit';
          break;
        case TransportMode.cycling:
          googleMapsMode = 'bicycling';
          break;
      }
      
      // Prepare starting location data
      Map<String, dynamic>? startingLocationData;
      if (startingLocationType == StartingLocationType.currentLocation) {
        if (_currentPosition != null) {
          startingLocationData = {
            'type': 'gps',
            'latitude': _currentPosition!.latitude,
            'longitude': _currentPosition!.longitude,
          };
        } else {
          // No GPS position acquired yet
          if (mounted) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please get your location first'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return; // Don't proceed without GPS
        }
      } else if (startingLocationType == StartingLocationType.customAddress) {
        startingLocationData = {
          'type': 'custom',
          'address': customAddress,
        };
      } else {
        // First place - will be handled in route result
        startingLocationData = {
          'type': 'first_place',
        };
      }

      // Run ACO algorithm
      final acoService = ref.read(acoServiceProvider);
      final baseResult = await acoService.calculateOptimalRoute(widget.selectedPlaces);
      
      // Create enhanced result with configuration
      final result = AcoResult(
        route: baseResult.route,
        totalDistance: baseResult.totalDistance,
        iterations: baseResult.iterations,
        transportMode: googleMapsMode,
        startingLocation: startingLocationData,
      );

      // Hide loading snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        // Navigate to result screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RouteResultScreen(result: result),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating route: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final transportMode = ref.watch(transportModeProvider);
    final startingLocationType = ref.watch(startingLocationTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.routeConfiguration ?? 'Route Configuration'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected places summary
            _buildSummaryCard(context, l10n),
            
            const SizedBox(height: AppSpacing.xl),
            
            // Starting location section
            _buildSectionTitle(context, l10n.startingLocation ?? 'Starting Location', Icons.location_on),
            const SizedBox(height: AppSpacing.md),
            _buildStartingLocationOptions(context, l10n, startingLocationType),
            
            const SizedBox(height: AppSpacing.xl),
            
            // Transport mode section
            _buildSectionTitle(context, l10n.transportMode ?? 'Transport Mode', Icons.directions),
            const SizedBox(height: AppSpacing.md),
            _buildTransportModeOptions(context, l10n, transportMode),
            
            const SizedBox(height: AppSpacing.xl),
            
            // Generate route button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _generateRoute,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                ),
                child: Text(
                  l10n.generateRoute,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, AppLocalizations l10n) {
    return Container(
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
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.selectedPlaces.length} ${l10n.placesSelected}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.configureYourRoute ?? 'Configure your route preferences',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStartingLocationOptions(BuildContext context, AppLocalizations l10n, StartingLocationType currentType) {
    return Column(
      children: [
        _buildLocationOption(
          context,
          l10n,
          StartingLocationType.firstPlace,
          Icons.place,
          l10n.firstSelectedPlace ?? 'First Selected Place',
          l10n.startFromFirstPlace ?? 'Start from the first place in your selection',
          currentType,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildLocationOption(
          context,
          l10n,
          StartingLocationType.currentLocation,
          Icons.my_location,
          l10n.currentLocation ?? 'Current Location',
          l10n.useGpsLocation ?? 'Use your current GPS location',
          currentType,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildLocationOption(
          context,
          l10n,
          StartingLocationType.customAddress,
          Icons.edit_location,
          l10n.customAddress ?? 'Custom Address',
          l10n.enterCustomAddress ?? 'Enter a specific address or place',
          currentType,
        ),
        
        // Custom address input field (shown when custom address is selected)
        if (currentType == StartingLocationType.customAddress) ...[
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _addressController,
            decoration: InputDecoration(
              hintText: l10n.enterAddress ?? 'Enter address...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              ref.read(customAddressProvider.notifier).state = value.isEmpty ? null : value;
            },
          ),
        ],
        
        // Current location button (shown when current location is selected)
        if (currentType == StartingLocationType.currentLocation) ...[
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _isLoadingLocation ? null : _getCurrentLocation,
              icon: _isLoadingLocation
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.gps_fixed),
              label: Text(_isLoadingLocation 
                  ? (l10n.gettingLocation ?? 'Getting location...') 
                  : (l10n.getMyLocation ?? 'Get My Location')),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLocationOption(
    BuildContext context,
    AppLocalizations l10n,
    StartingLocationType type,
    IconData icon,
    String title,
    String subtitle,
    StartingLocationType currentType,
  ) {
    final isSelected = currentType == type;
    
    return InkWell(
      onTap: () {
        ref.read(startingLocationTypeProvider.notifier).state = type;
      },
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransportModeOptions(BuildContext context, AppLocalizations l10n, TransportMode currentMode) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTransportModeCard(
                context,
                l10n,
                TransportMode.walking,
                Icons.directions_walk,
                l10n.walking ?? 'Walking',
                '~5 km/h',
                currentMode,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _buildTransportModeCard(
                context,
                l10n,
                TransportMode.driving,
                Icons.directions_car,
                l10n.driving ?? 'Driving',
                '~40 km/h',
                currentMode,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _buildTransportModeCard(
                context,
                l10n,
                TransportMode.publicTransport,
                Icons.directions_bus,
                l10n.publicTransport ?? 'Transit',
                '~20 km/h',
                currentMode,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _buildTransportModeCard(
                context,
                l10n,
                TransportMode.cycling,
                Icons.directions_bike,
                l10n.cycling ?? 'Cycling',
                '~15 km/h',
                currentMode,
              ),
            ),
          ],
        ),
        // Show warning for transit mode
        if (currentMode == TransportMode.publicTransport) ...[
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.transitLimitation ?? 'Note: Transit mode shows direct route only (no stops)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTransportModeCard(
    BuildContext context,
    AppLocalizations l10n,
    TransportMode mode,
    IconData icon,
    String title,
    String speed,
    TransportMode currentMode,
  ) {
    final isSelected = currentMode == mode;
    
    return InkWell(
      onTap: () {
        ref.read(transportModeProvider.notifier).state = mode;
      },
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : null,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              speed,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8)
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: AppSpacing.xs),
              Icon(
                Icons.check_circle,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
