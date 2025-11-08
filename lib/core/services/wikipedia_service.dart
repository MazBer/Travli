import 'package:dio/dio.dart';

/// Service to fetch place information from Wikipedia and Wikimedia Commons
class WikipediaService {
  final Dio _dio = Dio();

  WikipediaService() {
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  /// Fetch place details from Wikipedia by name
  Future<Map<String, dynamic>?> fetchPlaceDetails(String placeName, {String language = 'en'}) async {
    try {
      // Search for the article
      final searchResponse = await _dio.get(
        'https://$language.wikipedia.org/w/api.php',
        queryParameters: {
          'action': 'query',
          'format': 'json',
          'list': 'search',
          'srsearch': placeName,
          'srlimit': 1,
        },
      );

      final searchResults = searchResponse.data['query']?['search'] as List?;
      if (searchResults == null || searchResults.isEmpty) {
        return null;
      }

      final pageTitle = searchResults[0]['title'] as String;
      final pageId = searchResults[0]['pageid'] as int;

      // Get page details including extract and images
      final pageResponse = await _dio.get(
        'https://$language.wikipedia.org/w/api.php',
        queryParameters: {
          'action': 'query',
          'format': 'json',
          'pageids': pageId,
          'prop': 'extracts|pageimages|info',
          'exintro': true,
          'explaintext': true,
          'exsentences': 3,
          'piprop': 'thumbnail|original',
          'pithumbsize': 500,
          'inprop': 'url',
        },
      );

      final pages = pageResponse.data['query']?['pages'] as Map?;
      if (pages == null) return null;

      final pageData = pages[pageId.toString()] as Map?;
      if (pageData == null) return null;

      // Get all images from the page
      final imagesResponse = await _dio.get(
        'https://$language.wikipedia.org/w/api.php',
        queryParameters: {
          'action': 'query',
          'format': 'json',
          'pageids': pageId,
          'prop': 'images',
          'imlimit': 10,
        },
      );

      final imagesList = <String>[];
      final imagesData = imagesResponse.data['query']?['pages']?[pageId.toString()]?['images'] as List?;
      
      if (imagesData != null) {
        for (var image in imagesData) {
          final imageTitle = image['title'] as String?;
          if (imageTitle != null && !imageTitle.contains('.svg')) {
            // Get image URL
            final imageUrl = await _getImageUrl(imageTitle, language);
            if (imageUrl != null) {
              imagesList.add(imageUrl);
            }
          }
        }
      }

      // Extract description
      String? description = pageData['extract'] as String?;
      if (description != null && description.length > 300) {
        description = '${description.substring(0, 297)}...';
      }

      // Get thumbnail
      final thumbnail = pageData['thumbnail']?['source'] as String?;
      final original = pageData['original']?['source'] as String?;
      
      // Add thumbnail/original to images list if not already there
      if (original != null && !imagesList.contains(original)) {
        imagesList.insert(0, original);
      } else if (thumbnail != null && !imagesList.contains(thumbnail)) {
        imagesList.insert(0, thumbnail);
      }

      return {
        'title': pageTitle,
        'description': description,
        'imageUrls': imagesList,
        'wikipediaUrl': pageData['fullurl'] as String?,
      };
    } catch (e) {
      print('Error fetching Wikipedia data for $placeName: $e');
      return null;
    }
  }

  /// Get direct image URL from image title
  Future<String?> _getImageUrl(String imageTitle, String language) async {
    try {
      final response = await _dio.get(
        'https://$language.wikipedia.org/w/api.php',
        queryParameters: {
          'action': 'query',
          'format': 'json',
          'titles': imageTitle,
          'prop': 'imageinfo',
          'iiprop': 'url',
          'iiurlwidth': 500,
        },
      );

      final pages = response.data['query']?['pages'] as Map?;
      if (pages == null) return null;

      final pageData = pages.values.first as Map?;
      final imageInfo = pageData?['imageinfo'] as List?;
      
      if (imageInfo != null && imageInfo.isNotEmpty) {
        return imageInfo[0]['thumburl'] as String? ?? imageInfo[0]['url'] as String?;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Fetch place details from Wikidata by ID
  Future<Map<String, dynamic>?> fetchFromWikidata(String wikidataId) async {
    try {
      final response = await _dio.get(
        'https://www.wikidata.org/w/api.php',
        queryParameters: {
          'action': 'wbgetentities',
          'format': 'json',
          'ids': wikidataId,
          'props': 'labels|descriptions|claims',
          'languages': 'en',
        },
      );

      final entities = response.data['entities'] as Map?;
      if (entities == null) return null;

      final entity = entities[wikidataId] as Map?;
      if (entity == null) return null;

      // Get description
      final description = entity['descriptions']?['en']?['value'] as String?;

      // Get images from claims (P18 is the image property)
      final claims = entity['claims'] as Map?;
      final imageClaims = claims?['P18'] as List?;
      
      final imagesList = <String>[];
      if (imageClaims != null) {
        for (var claim in imageClaims) {
          final imageName = claim['mainsnak']?['datavalue']?['value'] as String?;
          if (imageName != null) {
            // Convert to Commons URL
            final imageUrl = _getCommonsImageUrl(imageName);
            if (imageUrl != null) {
              imagesList.add(imageUrl);
            }
          }
        }
      }

      return {
        'description': description,
        'imageUrls': imagesList,
      };
    } catch (e) {
      print('Error fetching Wikidata for $wikidataId: $e');
      return null;
    }
  }

  /// Convert Wikimedia Commons filename to URL
  String? _getCommonsImageUrl(String filename) {
    try {
      // Remove "File:" prefix if present
      final cleanName = filename.replaceFirst('File:', '');
      
      // URL encode
      final encoded = Uri.encodeComponent(cleanName);
      
      // Wikimedia Commons thumbnail URL
      return 'https://commons.wikimedia.org/wiki/Special:FilePath/$encoded?width=500';
    } catch (e) {
      return null;
    }
  }
}
