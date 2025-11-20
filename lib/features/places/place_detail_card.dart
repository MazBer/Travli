import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/place.dart';
import '../../l10n/app_localizations.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/services/wikipedia_service.dart';

/// A detailed card showing place information with images
class PlaceDetailCard extends StatefulWidget {
  final Place place;
  final String languageCode;

  const PlaceDetailCard({
    super.key,
    required this.place,
    required this.languageCode,
  });

  @override
  State<PlaceDetailCard> createState() => _PlaceDetailCardState();
}

class _PlaceDetailCardState extends State<PlaceDetailCard> {
  final WikipediaService _wikipediaService = WikipediaService();
  Place? _enrichedPlace;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWikipediaData();
  }

  Future<void> _loadWikipediaData() async {
    // If place already has images and description, no need to fetch
    if (widget.place.imageUrls != null && 
        widget.place.imageUrls!.isNotEmpty && 
        widget.place.description != null) {
      setState(() {
        _enrichedPlace = widget.place;
        _isLoading = false;
      });
      return;
    }

    try {
      print('Loading Wikipedia data for: ${widget.place.name}');
      final wikiData = await _wikipediaService.fetchPlaceDetails(
        widget.place.name,
        language: widget.languageCode,
      );

      if (wikiData != null && mounted) {
        setState(() {
          _enrichedPlace = widget.place.copyWith(
            description: wikiData['description'] as String?,
            imageUrls: wikiData['imageUrls'] as List<String>?,
            wikipediaUrl: wikiData['wikipediaUrl'] as String?,
          );
          _isLoading = false;
        });
        print('✓ Loaded Wikipedia data for ${widget.place.name}');
      } else if (mounted) {
        setState(() {
          _enrichedPlace = widget.place;
          _isLoading = false;
        });
        print('✗ No Wikipedia data found for ${widget.place.name}');
      }
    } catch (e) {
      print('Error loading Wikipedia data: $e');
      if (mounted) {
        setState(() {
          _enrichedPlace = widget.place;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final place = _enrichedPlace ?? widget.place;
    final localizedName = place.getLocalizedName(widget.languageCode);
    
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(AppSpacing.lg),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image carousel or single image
            Stack(
              children: [
                _buildImageSection(context, place),
                // Loading indicator overlay
                if (_isLoading)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(AppSpacing.radiusLg),
                        ),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      localizedName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      ),
                      child: Text(
                        place.category,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    if (place.rating != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber[700],
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            place.rating!.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                    
                    if (place.address != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            ),
                          ),
                        ],
                      ),
                    ],
                    
                    if (place.description != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      const Divider(),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        place.description!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    
                    if (place.wikipediaUrl != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      OutlinedButton.icon(
                        onPressed: () => _launchWikipedia(place.wikipediaUrl!),
                        icon: const Icon(Icons.article_outlined, size: 18),
                        label: const Text('Read more on Wikipedia'), // TODO: Use l10n.readMoreWikipedia after regeneration
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            // Close button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'), // TODO: Use l10n.close after regeneration
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, Place place) {
    final images = place.imageUrls ?? (place.imageUrl != null ? [place.imageUrl!] : <String>[]);
    
    if (images.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusLg),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getCategoryIcon(place.category),
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'No image available', // TODO: Use l10n.noImageAvailable after regeneration
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    if (images.length == 1) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
        child: CachedNetworkImage(
          imageUrl: images.first,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            height: 200,
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: 200,
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Center(
              child: Icon(
                Icons.broken_image,
                size: 48,
                color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
              ),
            ),
          ),
        ),
      );
    }
    
    // Multiple images - show carousel
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusLg),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: images[index],
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 200,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 48,
                        color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                // Image counter
                Positioned(
                  bottom: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      '${index + 1}/${images.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'museum':
        return Icons.museum;
      case 'monument':
        return Icons.account_balance;
      case 'park':
        return Icons.park;
      case 'restaurant':
        return Icons.restaurant;
      case 'shopping':
        return Icons.shopping_bag;
      case 'entertainment':
        return Icons.theater_comedy;
      case 'religious':
        return Icons.church;
      default:
        return Icons.place;
    }
  }

  Future<void> _launchWikipedia(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
