import 'package:dio/dio.dart';
import '../../models/city.dart';
import '../../models/place.dart';
import '../data/popular_cities.dart';

class ApiService {
  final Dio _dio = Dio();
  
  // Overpass API for places (OpenStreetMap)
  static const String _overpassBaseUrl = 'https://overpass-api.de/api/interpreter';

  ApiService() {
    _dio.options.headers = {
      'User-Agent': 'Travli/1.0.0', // Required by Nominatim
    };
  }

  /// Search for cities by name
  Future<List<City>> searchCities(String query) async {
    if (query.isEmpty) return [];

    try {
      final response = await _dio.get(
        'https://nominatim.openstreetmap.org/search',
        queryParameters: {
          'q': query,
          'format': 'json',
          'limit': 50,  // Increased to get more results before filtering
          'addressdetails': 1,
          'featuretype': 'city',  // Prioritize cities
        },
      );

      final List<dynamic> results = response.data;
      var cities = <City>[]; // Changed to var to allow reassignment
      final seenCities = <String>{};

      for (var result in results) {
        final address = result['address'] as Map<String, dynamic>?;
        if (address == null) continue;

        // Prioritize city field, then town, then others
        String? cityName = address['city'] as String?;
        
        // If no city field, check if it's a major place
        if (cityName == null) {
          final placeType = result['type'] as String?;
          final resultClass = result['class'] as String?;
          
          // Only accept towns/villages if they're significant
          if (placeType == 'city' || placeType == 'town' || 
              resultClass == 'place' && placeType == 'city') {
            cityName = address['town'] as String? ??
                      address['municipality'] as String? ??
                      result['name'] as String?;
          }
        }

        if (cityName == null || cityName.isEmpty) continue;
        
        // Skip very small places (villages, hamlets, etc.) unless they match popular cities
        final placeType = result['type'] as String?;
        if (placeType == 'village' || placeType == 'hamlet' || placeType == 'locality') {
          if (_getCityPopularityScore(cityName) == 0) {
            continue;  // Skip small places that aren't popular
          }
        }

        final country = address['country'] as String? ?? 'Unknown';
        final uniqueKey = '$cityName|$country';

        // Avoid duplicates
        if (seenCities.contains(uniqueKey)) continue;
        seenCities.add(uniqueKey);

        cities.add(City(
          name: cityName,
          country: country,
          latitude: double.parse(result['lat'].toString()),
          longitude: double.parse(result['lon'].toString()),
          description: result['display_name'] as String?,
        ));
      }

      // Sort by popularity (larger cities first based on importance)
      cities.sort((a, b) {
        final aScore = _getCityPopularityScore(a.name);
        final bScore = _getCityPopularityScore(b.name);
        print('Comparing ${a.name} (score: $aScore) vs ${b.name} (score: $bScore)');
        return bScore.compareTo(aScore);
      });

      print('Sorted cities: ${cities.map((c) => '${c.name} (${_getCityPopularityScore(c.name)})').join(', ')}');

      // Limit to 10 unique cities after sorting
      if (cities.length > 10) {
        cities = cities.sublist(0, 10);
      }

      // If API returned no results, use offline database as fallback
      if (cities.isEmpty) {
        print('API returned no results, using offline database...');
        return PopularCities.search(query);
      }

      return cities;
    } catch (e) {
      print('Error searching cities from API: $e');
      print('Falling back to offline city database...');
      
      // Fallback to offline popular cities only on error
      return PopularCities.search(query);
    }
  }

  /// Get popularity score for city (higher = more popular)
  int _getCityPopularityScore(String cityName) {
    final name = cityName.toLowerCase();
    
    // Major world cities (score: 1000+)
    const majorCities = {
      'paris': 1500, 'london': 1500, 'new york': 1500, 'tokyo': 1500,
      'barcelona': 1400, 'rome': 1400, 'istanbul': 1400, 'dubai': 1400,
      'amsterdam': 1300, 'berlin': 1300, 'madrid': 1300, 'vienna': 1300,
      'prague': 1200, 'lisbon': 1200, 'athens': 1200, 'budapest': 1200,
    };
    
    // Large cities (score: 500-999)
    const largeCities = {
      'milan': 900, 'munich': 900, 'venice': 900, 'florence': 900,
      'dublin': 800, 'brussels': 800, 'copenhagen': 800, 'stockholm': 800,
      'oslo': 700, 'helsinki': 700, 'warsaw': 700, 'krakow': 700,
    };
    
    // Check exact match
    if (majorCities.containsKey(name)) return majorCities[name]!;
    if (largeCities.containsKey(name)) return largeCities[name]!;
    
    // Check partial match for compound names
    for (var entry in majorCities.entries) {
      if (name.contains(entry.key) || entry.key.contains(name)) {
        return entry.value - 100;
      }
    }
    
    // Default score
    return 0;
  }

  /// Get places/attractions for a city
  Future<List<Place>> getPlacesForCity(City city, {int? cityId}) async {
    try {
      // Define the search radius (in meters)
      const radius = 10000; // 10km

      // Overpass QL query to get tourist attractions
      final query = '''
        [out:json][timeout:25];
        (
          node["tourism"="attraction"](around:$radius,${city.latitude},${city.longitude});
          node["tourism"="museum"](around:$radius,${city.latitude},${city.longitude});
          node["tourism"="viewpoint"](around:$radius,${city.latitude},${city.longitude});
          node["historic"](around:$radius,${city.latitude},${city.longitude});
          node["amenity"="place_of_worship"](around:$radius,${city.latitude},${city.longitude});
          way["tourism"="attraction"](around:$radius,${city.latitude},${city.longitude});
          way["tourism"="museum"](around:$radius,${city.latitude},${city.longitude});
          way["historic"](around:$radius,${city.latitude},${city.longitude});
        );
        out center 100;
      ''';

      final response = await _dio.post(
        _overpassBaseUrl,
        data: query,
        options: Options(
          contentType: 'application/x-www-form-urlencoded',
        ),
      );

      final data = response.data as Map<String, dynamic>;
      final elements = data['elements'] as List<dynamic>? ?? [];
      final places = <Place>[];

      for (var element in elements) {
        final tags = element['tags'] as Map<String, dynamic>?;
        if (tags == null) continue;

        final name = tags['name'] as String?;
        if (name == null || name.isEmpty) continue;

        // Get coordinates
        double lat, lon;
        if (element['type'] == 'node') {
          lat = double.parse(element['lat'].toString());
          lon = double.parse(element['lon'].toString());
        } else if (element['center'] != null) {
          lat = double.parse(element['center']['lat'].toString());
          lon = double.parse(element['center']['lon'].toString());
        } else {
          continue;
        }

        // Determine category
        String category = 'Attraction';
        if (tags['tourism'] == 'museum') {
          category = 'Museum';
        } else if (tags['historic'] != null) {
          category = 'Historic Site';
        } else if (tags['amenity'] == 'place_of_worship') {
          category = 'Religious Site';
        } else if (tags['tourism'] == 'viewpoint') {
          category = 'Viewpoint';
        }

        // Extract localized names
        final localizedNames = <String, String>{};
        tags.forEach((key, value) {
          if (key.startsWith('name:') && value is String && value.isNotEmpty) {
            final langCode = key.substring(5); // Extract language code after 'name:'
            localizedNames[langCode] = value;
          }
        });
        
        // Calculate popularity score
        final popularityScore = _calculatePopularityScore(tags, element);

        places.add(Place(
          cityId: cityId ?? 0,
          name: name,
          localizedNames: localizedNames,
          category: category,
          latitude: lat,
          longitude: lon,
          description: tags['description'] as String?,
          address: _buildAddress(tags),
          rating: popularityScore,
        ));
      }

      // Sort by popularity (rating field contains popularity score)
      places.sort((a, b) {
        final scoreA = a.rating ?? 0.0;
        final scoreB = b.rating ?? 0.0;
        return scoreB.compareTo(scoreA); // Descending order (highest first)
      });

      return places; // Return all places for pagination
    } catch (e) {
      print('Error fetching places: $e');
      return [];
    }
  }

  String? _buildAddress(Map<String, dynamic> tags) {
    final parts = <String>[];
    
    if (tags['addr:street'] != null) {
      parts.add(tags['addr:street']);
    }
    if (tags['addr:housenumber'] != null) {
      parts.add(tags['addr:housenumber']);
    }
    
    return parts.isEmpty ? null : parts.join(' ');
  }

  /// Calculate popularity score based on OSM tags and attributes
  /// Higher score = more popular/important attraction
  double _calculatePopularityScore(Map<String, dynamic> tags, Map<String, dynamic> element) {
    double score = 0.0;
    
    // 1. Wikipedia presence (very strong indicator of importance)
    if (tags['wikipedia'] != null || tags['wikidata'] != null) {
      score += 50.0;
    }
    
    // 2. UNESCO World Heritage Site (extremely important)
    if (tags['heritage'] == '1' || tags['heritage:operator'] == 'whc') {
      score += 100.0;
    }
    
    // 3. Tourism importance level
    final tourism = tags['tourism'];
    if (tourism == 'attraction') {
      final importance = tags['importance'];
      if (importance == 'international') score += 80.0;
      else if (importance == 'national') score += 60.0;
      else if (importance == 'regional') score += 40.0;
      else score += 30.0; // Default attraction
    } else if (tourism == 'museum') {
      score += 45.0;
    } else if (tourism == 'viewpoint') {
      score += 25.0;
    }
    
    // 4. Historic significance
    final historic = tags['historic'];
    if (historic != null) {
      if (historic == 'castle' || historic == 'monument') score += 50.0;
      else if (historic == 'archaeological_site') score += 45.0;
      else if (historic == 'ruins') score += 40.0;
      else if (historic == 'memorial') score += 35.0;
      else score += 30.0;
    }
    
    // 5. Religious importance
    if (tags['amenity'] == 'place_of_worship') {
      // Major religious sites
      if (tags['name:en']?.toLowerCase().contains('cathedral') == true ||
          tags['name']?.toLowerCase().contains('cathedral') == true) {
        score += 45.0;
      } else if (tags['name:en']?.toLowerCase().contains('basilica') == true ||
                 tags['name']?.toLowerCase().contains('basilica') == true) {
        score += 40.0;
      } else {
        score += 30.0;
      }
    }
    
    // 6. Building significance
    final building = tags['building'];
    if (building == 'cathedral' || building == 'basilica') score += 40.0;
    else if (building == 'palace' || building == 'castle') score += 45.0;
    
    // 7. Architectural style (indicates significance)
    if (tags['architectural_style'] != null) {
      score += 20.0;
    }
    
    // 8. Opening hours (indicates active tourist site)
    if (tags['opening_hours'] != null) {
      score += 15.0;
    }
    
    // 9. Entrance fee (indicates managed attraction)
    if (tags['fee'] == 'yes' || tags['charge'] != null) {
      score += 10.0;
    }
    
    // 10. Website presence (indicates professional management)
    if (tags['website'] != null || tags['contact:website'] != null) {
      score += 10.0;
    }
    
    // 11. Image availability
    if (tags['image'] != null || tags['wikimedia_commons'] != null) {
      score += 8.0;
    }
    
    // 12. Description presence (indicates documentation)
    if (tags['description'] != null || tags['description:en'] != null) {
      score += 5.0;
    }
    
    // 13. Operator (managed sites are usually more significant)
    if (tags['operator'] != null) {
      score += 5.0;
    }
    
    // 14. Way vs Node (ways are usually larger, more significant structures)
    if (element['type'] == 'way') {
      score += 10.0;
    }
    
    // 15. Bonus for having multiple language names (international significance)
    int languageCount = 0;
    tags.forEach((key, value) {
      if (key.startsWith('name:')) languageCount++;
    });
    if (languageCount >= 5) score += 15.0;
    else if (languageCount >= 3) score += 10.0;
    else if (languageCount >= 1) score += 5.0;
    
    return score;
  }
}
