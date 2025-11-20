import '../../models/place.dart';

/// Offline places database for major tourist cities
/// Used as fallback when Overpass API is unavailable
class OfflinePlaces {
  
  /// Get places for a city by name
  static List<Place> getPlacesForCity(String cityName, int cityId) {
    print('[OfflinePlaces] Looking up city: "$cityName" (ID: $cityId)');
    final normalizedName = cityName.toLowerCase().trim();
    print('[OfflinePlaces] Normalized: "$normalizedName"');
    
    List<Place> places = [];
    
    switch (normalizedName) {
      // Existing cities
      case 'rome':
      case 'roma':
        print('[OfflinePlaces] ✓ Matched: Rome');
        places = _getRomePlaces(cityId);
        break;
      case 'paris':
        print('[OfflinePlaces] ✓ Matched: Paris');
        places = _getParisPlaces(cityId);
        break;
      case 'london':
      case 'londra':
        print('[OfflinePlaces] ✓ Matched: London');
        places = _getLondonPlaces(cityId);
        break;
      case 'barcelona':
        print('[OfflinePlaces] ✓ Matched: Barcelona');
        places = _getBarcelonaPlaces(cityId);
        break;
      case 'istanbul':
      case 'İstanbul':
        print('[OfflinePlaces] ✓ Matched: Istanbul');
        places = _getIstanbulPlaces(cityId);
        break;
      case 'amsterdam':
        print('[OfflinePlaces] ✓ Matched: Amsterdam');
        places = _getAmsterdamPlaces(cityId);
        break;
      case 'berlin':
        print('[OfflinePlaces] ✓ Matched: Berlin');
        places = _getBerlinPlaces(cityId);
        break;
      case 'vienna':
      case 'viyana':
      case 'wien':
        print('[OfflinePlaces] ✓ Matched: Vienna');
        places = _getViennaPlaces(cityId);
        break;
      case 'prague':
      case 'prag':
      case 'praha':
        print('[OfflinePlaces] ✓ Matched: Prague');
        places = _getPraguePlaces(cityId);
        break;
      case 'athens':
      case 'atina':
        print('[OfflinePlaces] ✓ Matched: Athens');
        places = _getAthensPlaces(cityId);
        break;
      case 'lisbon':
      case 'lisboa':
        print('[OfflinePlaces] ✓ Matched: Lisbon');
        places = _getLisbonPlaces(cityId);
        break;
      case 'budapest':
        print('[OfflinePlaces] ✓ Matched: Budapest');
        places = _getBudapestPlaces(cityId);
        break;

      // New Europe
      case 'madrid':
        print('[OfflinePlaces] ✓ Matched: Madrid');
        places = _getMadridPlaces(cityId);
        break;
      case 'dublin':
        print('[OfflinePlaces] ✓ Matched: Dublin');
        places = _getDublinPlaces(cityId);
        break;
      case 'brussels':
      case 'bruxelles':
        print('[OfflinePlaces] ✓ Matched: Brussels');
        places = _getBrusselsPlaces(cityId);
        break;
      case 'munich':
      case 'münchen':
        print('[OfflinePlaces] ✓ Matched: Munich');
        places = _getMunichPlaces(cityId);
        break;
      case 'milan':
      case 'milano':
        print('[OfflinePlaces] ✓ Matched: Milan');
        places = _getMilanPlaces(cityId);
        break;
      case 'venice':
      case 'venezia':
        print('[OfflinePlaces] ✓ Matched: Venice');
        places = _getVenicePlaces(cityId);
        break;
      case 'florence':
      case 'firenze':
        print('[OfflinePlaces] ✓ Matched: Florence');
        places = _getFlorencePlaces(cityId);
        break;
      case 'zurich':
      case 'zürich':
        print('[OfflinePlaces] ✓ Matched: Zurich');
        places = _getZurichPlaces(cityId);
        break;
      case 'stockholm':
        print('[OfflinePlaces] ✓ Matched: Stockholm');
        places = _getStockholmPlaces(cityId);
        break;
      case 'copenhagen':
      case 'københavn':
        print('[OfflinePlaces] ✓ Matched: Copenhagen');
        places = _getCopenhagenPlaces(cityId);
        break;
      case 'oslo':
        print('[OfflinePlaces] ✓ Matched: Oslo');
        places = _getOsloPlaces(cityId);
        break;
      case 'helsinki':
        print('[OfflinePlaces] ✓ Matched: Helsinki');
        places = _getHelsinkiPlaces(cityId);
        break;
      case 'warsaw':
      case 'warszawa':
        print('[OfflinePlaces] ✓ Matched: Warsaw');
        places = _getWarsawPlaces(cityId);
        break;
      case 'krakow':
      case 'kraków':
        print('[OfflinePlaces] ✓ Matched: Krakow');
        places = _getKrakowPlaces(cityId);
        break;
      case 'edinburgh':
        print('[OfflinePlaces] ✓ Matched: Edinburgh');
        places = _getEdinburghPlaces(cityId);
        break;
      case 'geneva':
      case 'genève':
        print('[OfflinePlaces] ✓ Matched: Geneva');
        places = _getGenevaPlaces(cityId);
        break;

      // New Americas
      case 'new york':
      case 'new york city':
      case 'nyc':
        print('[OfflinePlaces] ✓ Matched: New York');
        places = _getNewYorkPlaces(cityId);
        break;
      case 'los angeles':
      case 'la':
        print('[OfflinePlaces] ✓ Matched: Los Angeles');
        places = _getLosAngelesPlaces(cityId);
        break;
      case 'san francisco':
      case 'sf':
        print('[OfflinePlaces] ✓ Matched: San Francisco');
        places = _getSanFranciscoPlaces(cityId);
        break;
      case 'las vegas':
      case 'vegas':
        print('[OfflinePlaces] ✓ Matched: Las Vegas');
        places = _getLasVegasPlaces(cityId);
        break;
      case 'miami':
        print('[OfflinePlaces] ✓ Matched: Miami');
        places = _getMiamiPlaces(cityId);
        break;
      case 'chicago':
        print('[OfflinePlaces] ✓ Matched: Chicago');
        places = _getChicagoPlaces(cityId);
        break;
      case 'toronto':
        print('[OfflinePlaces] ✓ Matched: Toronto');
        places = _getTorontoPlaces(cityId);
        break;
      case 'vancouver':
        print('[OfflinePlaces] ✓ Matched: Vancouver');
        places = _getVancouverPlaces(cityId);
        break;
      case 'montreal':
      case 'montréal':
        print('[OfflinePlaces] ✓ Matched: Montreal');
        places = _getMontrealPlaces(cityId);
        break;
      case 'mexico city':
      case 'ciudad de méxico':
      case 'cdmx':
        print('[OfflinePlaces] ✓ Matched: Mexico City');
        places = _getMexicoCityPlaces(cityId);
        break;
      case 'rio de janeiro':
      case 'rio':
        print('[OfflinePlaces] ✓ Matched: Rio de Janeiro');
        places = _getRioDeJaneiroPlaces(cityId);
        break;
      case 'buenos aires':
        print('[OfflinePlaces] ✓ Matched: Buenos Aires');
        places = _getBuenosAiresPlaces(cityId);
        break;

      // Asia / Oceania / Africa
      case 'tokyo':
        print('[OfflinePlaces] ✓ Matched: Tokyo');
        places = _getTokyoPlaces(cityId);
        break;
      case 'kyoto':
        print('[OfflinePlaces] ✓ Matched: Kyoto');
        places = _getKyotoPlaces(cityId);
        break;
      case 'seoul':
        print('[OfflinePlaces] ✓ Matched: Seoul');
        places = _getSeoulPlaces(cityId);
        break;
      case 'bangkok':
        print('[OfflinePlaces] ✓ Matched: Bangkok');
        places = _getBangkokPlaces(cityId);
        break;
      case 'singapore':
        print('[OfflinePlaces] ✓ Matched: Singapore');
        places = _getSingaporePlaces(cityId);
        break;
      case 'dubai':
        print('[OfflinePlaces] ✓ Matched: Dubai');
        places = _getDubaiPlaces(cityId);
        break;
      case 'hong kong':
        print('[OfflinePlaces] ✓ Matched: Hong Kong');
        places = _getHongKongPlaces(cityId);
        break;
      case 'beijing':
        print('[OfflinePlaces] ✓ Matched: Beijing');
        places = _getBeijingPlaces(cityId);
        break;
      case 'shanghai':
        print('[OfflinePlaces] ✓ Matched: Shanghai');
        places = _getShanghaiPlaces(cityId);
        break;
      case 'mumbai':
        print('[OfflinePlaces] ✓ Matched: Mumbai');
        places = _getMumbaiPlaces(cityId);
        break;
      case 'delhi':
      case 'new delhi':
        print('[OfflinePlaces] ✓ Matched: Delhi');
        places = _getDelhiPlaces(cityId);
        break;
      case 'sydney':
        print('[OfflinePlaces] ✓ Matched: Sydney');
        places = _getSydneyPlaces(cityId);
        break;
      case 'melbourne':
        print('[OfflinePlaces] ✓ Matched: Melbourne');
        places = _getMelbournePlaces(cityId);
        break;
      case 'cairo':
        print('[OfflinePlaces] ✓ Matched: Cairo');
        places = _getCairoPlaces(cityId);
        break;
      case 'cape town':
        print('[OfflinePlaces] ✓ Matched: Cape Town');
        places = _getCapeTownPlaces(cityId);
        break;

      default:
        print('[OfflinePlaces] ✗ NO MATCH for "$normalizedName"');
        print('[OfflinePlaces] Available: 50+ major cities across Europe, Americas, Asia, Africa, and Oceania');
        places = [];
    }
    
    print('[OfflinePlaces] Returning ${places.length} places');
    return places;
  }

  static List<Place> _getRomePlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Colosseum',
        localizedNames: {
          'it': 'Colosseo',
          'tr': 'Kolezyum',
          'es': 'Coliseo',
          'fr': 'Colisée',
          'de': 'Kolosseum',
        },
        category: 'Historic Site',
        latitude: 41.8902,
        longitude: 12.4922,
        description: 'Ancient Roman amphitheater and iconic landmark',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'Roman Forum',
        localizedNames: {
          'it': 'Foro Romano',
          'tr': 'Roma Forumu',
          'es': 'Foro Romano',
          'fr': 'Forum Romain',
          'de': 'Forum Romanum',
        },
        category: 'Historic Site',
        latitude: 41.8925,
        longitude: 12.4853,
        description: 'Ancient Roman marketplace and political center',
        rating: 4.8,
      ),
      Place(
        cityId: cityId,
        name: 'Trevi Fountain',
        localizedNames: {
          'it': 'Fontana di Trevi',
          'tr': 'Trevi Çeşmesi',
          'es': 'Fontana de Trevi',
          'fr': 'Fontaine de Trevi',
          'de': 'Trevi-Brunnen',
        },
        category: 'Attraction',
        latitude: 41.9009,
        longitude: 12.4833,
        description: 'Baroque fountain, largest in Rome',
        rating: 4.9,
      ),
      Place(
        cityId: cityId,
        name: 'Pantheon',
        localizedNames: {
          'it': 'Pantheon',
          'tr': 'Pantheon',
          'es': 'Panteón',
          'fr': 'Panthéon',
          'de': 'Pantheon',
        },
        category: 'Historic Site',
        latitude: 41.8986,
        longitude: 12.4768,
        description: 'Former Roman temple, now a church',
        rating: 4.9,
      ),
      Place(
        cityId: cityId,
        name: 'Vatican Museums',
        localizedNames: {
          'it': 'Musei Vaticani',
          'tr': 'Vatikan Müzeleri',
          'es': 'Museos Vaticanos',
          'fr': 'Musées du Vatican',
          'de': 'Vatikanische Museen',
        },
        category: 'Museum',
        latitude: 41.9065,
        longitude: 12.4536,
        description: 'World-famous art museums in Vatican City',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'St. Peter\'s Basilica',
        localizedNames: {
          'it': 'Basilica di San Pietro',
          'tr': 'Aziz Petrus Bazilikası',
          'es': 'Basílica de San Pedro',
          'fr': 'Basilique Saint-Pierre',
          'de': 'Petersdom',
        },
        category: 'Religious Site',
        latitude: 41.9022,
        longitude: 12.4539,
        description: 'Renaissance church, largest in the world',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'Spanish Steps',
        localizedNames: {
          'it': 'Scalinata di Trinità dei Monti',
          'tr': 'İspanyol Merdivenleri',
          'es': 'Escalinata de la Plaza de España',
          'fr': 'Escalier de la Trinité-des-Monts',
          'de': 'Spanische Treppe',
        },
        category: 'Attraction',
        latitude: 41.9058,
        longitude: 12.4823,
        description: 'Monumental stairway of 135 steps',
        rating: 4.6,
      ),
      Place(
        cityId: cityId,
        name: 'Piazza Navona',
        localizedNames: {
          'it': 'Piazza Navona',
          'tr': 'Navona Meydanı',
          'es': 'Plaza Navona',
          'fr': 'Place Navone',
          'de': 'Piazza Navona',
        },
        category: 'Attraction',
        latitude: 41.8992,
        longitude: 12.4731,
        description: 'Public square with Baroque fountains',
        rating: 4.7,
      ),
    ];
  }

  static List<Place> _getLisbonPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Belém Tower',
        localizedNames: {
          'pt': 'Torre de Belém',
          'tr': 'Belem Kulesi',
          'es': 'Torre de Belém',
          'fr': 'Tour de Belém',
          'de': 'Torre de Belém',
        },
        category: 'Historic Site',
        latitude: 38.6916,
        longitude: -9.2159,
        description: 'Iconic fortified tower on the Tagus River waterfront.',
        rating: 4.8,
      ),
      Place(
        cityId: cityId,
        name: 'Jerónimos Monastery',
        localizedNames: {
          'pt': 'Mosteiro dos Jerónimos',
          'tr': 'Jerónimos Manastırı',
          'es': 'Monasterio de los Jerónimos',
          'fr': 'Monastère des Hiéronymites',
          'de': 'Jerónimos-Kloster',
        },
        category: 'Historic Site',
        latitude: 38.6981,
        longitude: -9.2065,
        description: 'UNESCO-listed monastery and masterpiece of Manueline architecture.',
        rating: 4.9,
      ),
      Place(
        cityId: cityId,
        name: 'Alfama District',
        localizedNames: {
          'pt': 'Alfama',
          'tr': 'Alfama Semti',
          'es': 'Barrio de Alfama',
          'fr': 'Quartier de l\'Alfama',
          'de': 'Alfama',
        },
        category: 'Attraction',
        latitude: 38.7139,
        longitude: -9.1303,
        description: 'Oldest district of Lisbon with narrow streets and viewpoints.',
        rating: 4.7,
      ),
      Place(
        cityId: cityId,
        name: 'Praça do Comércio',
        localizedNames: {
          'pt': 'Praça do Comércio',
          'tr': 'Ticaret Meydanı',
          'es': 'Plaza del Comercio',
          'fr': 'Place du Commerce',
          'de': 'Praça do Comércio',
        },
        category: 'Attraction',
        latitude: 38.7078,
        longitude: -9.1366,
        description: 'Grand riverside square surrounded by classical buildings.',
        rating: 4.6,
      ),
    ];
  }

  static List<Place> _getBudapestPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Buda Castle',
        localizedNames: {
          'hu': 'Budavári Palota',
          'tr': 'Buda Kalesi',
          'es': 'Castillo de Buda',
          'fr': 'Château de Buda',
          'de': 'Burgpalast',
        },
        category: 'Historic Site',
        latitude: 47.4969,
        longitude: 19.0399,
        description: 'Historic castle and palace complex overlooking the Danube.',
        rating: 4.8,
      ),
      Place(
        cityId: cityId,
        name: 'Parliament Building',
        localizedNames: {
          'hu': 'Országház',
          'tr': 'Macaristan Parlamentosu',
          'es': 'Parlamento de Hungría',
          'fr': 'Parlement hongrois',
          'de': 'Ungarisches Parlament',
        },
        category: 'Historic Site',
        latitude: 47.5076,
        longitude: 19.0452,
        description: 'Iconic neo-Gothic parliament building on the Danube.',
        rating: 4.9,
      ),
      Place(
        cityId: cityId,
        name: 'Fisherman\'s Bastion',
        localizedNames: {
          'hu': 'Halászbástya',
          'tr': 'Balıkçı Tabyası',
          'es': 'Bastión de los Pescadores',
          'fr': 'Bastion des pêcheurs',
          'de': 'Fischerbastei',
        },
        category: 'Viewpoint',
        latitude: 47.5022,
        longitude: 19.0349,
        description: 'Fairytale-like terrace with panoramic views over Budapest.',
        rating: 4.8,
      ),
      Place(
        cityId: cityId,
        name: 'Széchenyi Thermal Bath',
        localizedNames: {
          'hu': 'Széchenyi Gyógyfürdő',
          'tr': 'Seçeni Kaplıcaları',
          'es': 'Balneario Széchenyi',
          'fr': 'Bains Széchenyi',
          'de': 'Széchenyi-Heilbad',
        },
        category: 'Attraction',
        latitude: 47.5189,
        longitude: 19.0821,
        description: 'One of Europe\'s largest spa complexes with outdoor pools.',
        rating: 4.7,
      ),
    ];
  }

  static List<Place> _getParisPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Eiffel Tower',
        localizedNames: {
          'fr': 'Tour Eiffel',
          'tr': 'Eyfel Kulesi',
          'es': 'Torre Eiffel',
          'de': 'Eiffelturm',
          'it': 'Torre Eiffel',
        },
        category: 'Attraction',
        latitude: 48.8584,
        longitude: 2.2945,
        description: 'Iconic iron lattice tower',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'Louvre Museum',
        localizedNames: {
          'fr': 'Musée du Louvre',
          'tr': 'Louvre Müzesi',
          'es': 'Museo del Louvre',
          'de': 'Louvre',
          'it': 'Museo del Louvre',
        },
        category: 'Museum',
        latitude: 48.8606,
        longitude: 2.3376,
        description: 'World\'s largest art museum',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'Notre-Dame Cathedral',
        localizedNames: {
          'fr': 'Cathédrale Notre-Dame',
          'tr': 'Notre-Dame Katedrali',
          'es': 'Catedral de Notre-Dame',
          'de': 'Kathedrale Notre-Dame',
          'it': 'Cattedrale di Notre-Dame',
        },
        category: 'Religious Site',
        latitude: 48.8530,
        longitude: 2.3499,
        description: 'Medieval Catholic cathedral',
        rating: 4.9,
      ),
      Place(
        cityId: cityId,
        name: 'Arc de Triomphe',
        localizedNames: {
          'fr': 'Arc de Triomphe',
          'tr': 'Zafer Takı',
          'es': 'Arco del Triunfo',
          'de': 'Triumphbogen',
          'it': 'Arco di Trionfo',
        },
        category: 'Historic Site',
        latitude: 48.8738,
        longitude: 2.2950,
        description: 'Monumental arch honoring French army',
        rating: 4.8,
      ),
      Place(
        cityId: cityId,
        name: 'Sacré-Cœur',
        localizedNames: {
          'fr': 'Basilique du Sacré-Cœur',
          'tr': 'Sacré-Cœur Bazilikası',
          'es': 'Basílica del Sagrado Corazón',
          'de': 'Basilika Sacré-Cœur',
          'it': 'Basilica del Sacro Cuore',
        },
        category: 'Religious Site',
        latitude: 48.8867,
        longitude: 2.3431,
        description: 'Roman Catholic church on Montmartre',
        rating: 4.7,
      ),
      Place(
        cityId: cityId,
        name: 'Champs-Élysées',
        localizedNames: {
          'fr': 'Avenue des Champs-Élysées',
          'tr': 'Champs-Élysées Caddesi',
          'es': 'Campos Elíseos',
          'de': 'Champs-Élysées',
          'it': 'Champs-Élysées',
        },
        category: 'Attraction',
        latitude: 48.8698,
        longitude: 2.3078,
        description: 'Famous avenue in Paris',
        rating: 4.6,
      ),
    ];
  }

  static List<Place> _getLondonPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Tower of London',
        localizedNames: {
          'tr': 'Londra Kulesi',
          'es': 'Torre de Londres',
          'fr': 'Tour de Londres',
          'de': 'Tower of London',
          'it': 'Torre di Londra',
        },
        category: 'Historic Site',
        latitude: 51.5081,
        longitude: -0.0759,
        description: 'Historic castle and former royal palace',
        rating: 4.9,
      ),
      Place(
        cityId: cityId,
        name: 'Big Ben',
        localizedNames: {
          'tr': 'Big Ben',
          'es': 'Big Ben',
          'fr': 'Big Ben',
          'de': 'Big Ben',
          'it': 'Big Ben',
        },
        category: 'Attraction',
        latitude: 51.5007,
        longitude: -0.1246,
        description: 'Iconic clock tower at Palace of Westminster',
        rating: 4.8,
      ),
      Place(
        cityId: cityId,
        name: 'British Museum',
        localizedNames: {
          'tr': 'British Museum',
          'es': 'Museo Británico',
          'fr': 'British Museum',
          'de': 'British Museum',
          'it': 'British Museum',
        },
        category: 'Museum',
        latitude: 51.5194,
        longitude: -0.1270,
        description: 'World-famous museum of human history',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'London Eye',
        localizedNames: {
          'tr': 'London Eye',
          'es': 'London Eye',
          'fr': 'London Eye',
          'de': 'London Eye',
          'it': 'London Eye',
        },
        category: 'Attraction',
        latitude: 51.5033,
        longitude: -0.1195,
        description: 'Giant Ferris wheel on South Bank',
        rating: 4.7,
      ),
      Place(
        cityId: cityId,
        name: 'Buckingham Palace',
        localizedNames: {
          'tr': 'Buckingham Sarayı',
          'es': 'Palacio de Buckingham',
          'fr': 'Palais de Buckingham',
          'de': 'Buckingham Palace',
          'it': 'Palazzo di Buckingham',
        },
        category: 'Historic Site',
        latitude: 51.5014,
        longitude: -0.1419,
        description: 'Official residence of British monarch',
        rating: 4.6,
      ),
    ];
  }

  static List<Place> _getBarcelonaPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Sagrada Família',
        localizedNames: {
          'es': 'Sagrada Família',
          'tr': 'Sagrada Família',
          'fr': 'Sagrada Família',
          'de': 'Sagrada Família',
          'it': 'Sagrada Família',
        },
        category: 'Religious Site',
        latitude: 41.4036,
        longitude: 2.1744,
        description: 'Gaudí\'s unfinished masterpiece',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'Park Güell',
        localizedNames: {
          'es': 'Parque Güell',
          'tr': 'Park Güell',
          'fr': 'Parc Güell',
          'de': 'Park Güell',
          'it': 'Parco Güell',
        },
        category: 'Attraction',
        latitude: 41.4145,
        longitude: 2.1527,
        description: 'Colorful park designed by Gaudí',
        rating: 4.8,
      ),
      Place(
        cityId: cityId,
        name: 'Casa Batlló',
        localizedNames: {
          'es': 'Casa Batlló',
          'tr': 'Casa Batlló',
          'fr': 'Casa Batlló',
          'de': 'Casa Batlló',
          'it': 'Casa Batlló',
        },
        category: 'Attraction',
        latitude: 41.3916,
        longitude: 2.1649,
        description: 'Gaudí\'s modernist building',
        rating: 4.7,
      ),
      Place(
        cityId: cityId,
        name: 'La Rambla',
        localizedNames: {
          'es': 'La Rambla',
          'tr': 'La Rambla',
          'fr': 'La Rambla',
          'de': 'La Rambla',
          'it': 'La Rambla',
        },
        category: 'Attraction',
        latitude: 41.3818,
        longitude: 2.1685,
        description: 'Famous tree-lined pedestrian street',
        rating: 4.5,
      ),
      Place(
        cityId: cityId,
        name: 'Camp Nou',
        localizedNames: {
          'es': 'Camp Nou',
          'tr': 'Camp Nou',
          'fr': 'Camp Nou',
          'de': 'Camp Nou',
          'it': 'Camp Nou',
        },
        category: 'Attraction',
        latitude: 41.3809,
        longitude: 2.1228,
        description: 'FC Barcelona\'s home stadium',
        rating: 4.9,
      ),
    ];
  }

  static List<Place> _getIstanbulPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Hagia Sophia',
        localizedNames: {
          'tr': 'Ayasofya',
          'es': 'Santa Sofía',
          'fr': 'Sainte-Sophie',
          'de': 'Hagia Sophia',
          'it': 'Santa Sofia',
        },
        category: 'Historic Site',
        latitude: 41.0086,
        longitude: 28.9802,
        description: 'Former Byzantine church, now mosque',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'Blue Mosque',
        localizedNames: {
          'tr': 'Sultan Ahmet Camii',
          'es': 'Mezquita Azul',
          'fr': 'Mosquée Bleue',
          'de': 'Blaue Moschee',
          'it': 'Moschea Blu',
        },
        category: 'Religious Site',
        latitude: 41.0054,
        longitude: 28.9768,
        description: 'Historic mosque with blue tiles',
        rating: 4.9,
      ),
      Place(
        cityId: cityId,
        name: 'Topkapi Palace',
        localizedNames: {
          'tr': 'Topkapı Sarayı',
          'es': 'Palacio de Topkapi',
          'fr': 'Palais de Topkapi',
          'de': 'Topkapı-Palast',
          'it': 'Palazzo Topkapi',
        },
        category: 'Museum',
        latitude: 41.0115,
        longitude: 28.9833,
        description: 'Former Ottoman palace',
        rating: 4.8,
      ),
      Place(
        cityId: cityId,
        name: 'Grand Bazaar',
        localizedNames: {
          'tr': 'Kapalıçarşı',
          'es': 'Gran Bazar',
          'fr': 'Grand Bazar',
          'de': 'Großer Basar',
          'it': 'Gran Bazar',
        },
        category: 'Attraction',
        latitude: 41.0108,
        longitude: 28.9680,
        description: 'One of the oldest covered markets',
        rating: 4.6,
      ),
      Place(
        cityId: cityId,
        name: 'Galata Tower',
        localizedNames: {
          'tr': 'Galata Kulesi',
          'es': 'Torre de Gálata',
          'fr': 'Tour de Galata',
          'de': 'Galata-Turm',
          'it': 'Torre di Galata',
        },
        category: 'Historic Site',
        latitude: 41.0256,
        longitude: 28.9744,
        description: 'Medieval stone tower with panoramic views',
        rating: 4.7,
      ),
    ];
  }

  static List<Place> _getAmsterdamPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Anne Frank House',
        localizedNames: {
          'nl': 'Anne Frank Huis',
          'tr': 'Anne Frank Evi',
          'es': 'Casa de Ana Frank',
          'fr': 'Maison d\'Anne Frank',
          'de': 'Anne-Frank-Haus',
        },
        category: 'Museum',
        latitude: 52.3752,
        longitude: 4.8840,
        description: 'Historic house and museum',
        rating: 4.9,
      ),
      Place(
        cityId: cityId,
        name: 'Van Gogh Museum',
        localizedNames: {
          'nl': 'Van Gogh Museum',
          'tr': 'Van Gogh Müzesi',
          'es': 'Museo Van Gogh',
          'fr': 'Musée Van Gogh',
          'de': 'Van Gogh Museum',
        },
        category: 'Museum',
        latitude: 52.3584,
        longitude: 4.8811,
        description: 'Art museum dedicated to Van Gogh',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'Rijksmuseum',
        localizedNames: {
          'nl': 'Rijksmuseum',
          'tr': 'Rijksmuseum',
          'es': 'Rijksmuseum',
          'fr': 'Rijksmuseum',
          'de': 'Rijksmuseum',
        },
        category: 'Museum',
        latitude: 52.3600,
        longitude: 4.8852,
        description: 'Dutch national museum',
        rating: 4.9,
      ),
    ];
  }

  static List<Place> _getBerlinPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Brandenburg Gate',
        localizedNames: {
          'de': 'Brandenburger Tor',
          'tr': 'Brandenburg Kapısı',
          'es': 'Puerta de Brandeburgo',
          'fr': 'Porte de Brandebourg',
          'it': 'Porta di Brandeburgo',
        },
        category: 'Historic Site',
        latitude: 52.5163,
        longitude: 13.3777,
        description: 'Iconic 18th-century neoclassical monument',
        rating: 4.9,
      ),
      Place(
        cityId: cityId,
        name: 'Berlin Wall Memorial',
        localizedNames: {
          'de': 'Berliner Mauer',
          'tr': 'Berlin Duvarı Anıtı',
          'es': 'Muro de Berlín',
          'fr': 'Mur de Berlin',
          'it': 'Muro di Berlino',
        },
        category: 'Historic Site',
        latitude: 52.5351,
        longitude: 13.3903,
        description: 'Memorial to divided Berlin',
        rating: 4.8,
      ),
      Place(
        cityId: cityId,
        name: 'Reichstag Building',
        localizedNames: {
          'de': 'Reichstagsgebäude',
          'tr': 'Reichstag Binası',
          'es': 'Edificio del Reichstag',
          'fr': 'Reichstag',
          'it': 'Reichstag',
        },
        category: 'Historic Site',
        latitude: 52.5186,
        longitude: 13.3761,
        description: 'Historic parliament building',
        rating: 4.7,
      ),
    ];
  }

  static List<Place> _getViennaPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Schönbrunn Palace',
        localizedNames: {
          'de': 'Schloss Schönbrunn',
          'tr': 'Schönbrunn Sarayı',
          'es': 'Palacio de Schönbrunn',
          'fr': 'Château de Schönbrunn',
          'it': 'Palazzo di Schönbrunn',
        },
        category: 'Historic Site',
        latitude: 48.1847,
        longitude: 16.3122,
        description: 'Former imperial summer residence',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'St. Stephen\'s Cathedral',
        localizedNames: {
          'de': 'Stephansdom',
          'tr': 'Aziz Stephen Katedrali',
          'es': 'Catedral de San Esteban',
          'fr': 'Cathédrale Saint-Étienne',
          'it': 'Duomo di Santo Stefano',
        },
        category: 'Religious Site',
        latitude: 48.2085,
        longitude: 16.3731,
        description: 'Gothic cathedral in Vienna',
        rating: 4.8,
      ),
      Place(
        cityId: cityId,
        name: 'Hofburg Palace',
        localizedNames: {
          'de': 'Hofburg',
          'tr': 'Hofburg Sarayı',
          'es': 'Palacio de Hofburg',
          'fr': 'Palais de la Hofburg',
          'it': 'Palazzo Imperiale',
        },
        category: 'Historic Site',
        latitude: 48.2066,
        longitude: 16.3658,
        description: 'Former imperial palace',
        rating: 4.7,
      ),
    ];
  }

  static List<Place> _getPraguePlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Prague Castle',
        localizedNames: {
          'cs': 'Pražský hrad',
          'tr': 'Prag Kalesi',
          'es': 'Castillo de Praga',
          'fr': 'Château de Prague',
          'de': 'Prager Burg',
        },
        category: 'Historic Site',
        latitude: 50.0910,
        longitude: 14.4016,
        description: 'Historic castle complex',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'Charles Bridge',
        localizedNames: {
          'cs': 'Karlův most',
          'tr': 'Charles Köprüsü',
          'es': 'Puente de Carlos',
          'fr': 'Pont Charles',
          'de': 'Karlsbrücke',
        },
        category: 'Historic Site',
        latitude: 50.0865,
        longitude: 14.4114,
        description: 'Medieval stone bridge',
        rating: 4.9,
      ),
      Place(
        cityId: cityId,
        name: 'Old Town Square',
        localizedNames: {
          'cs': 'Staroměstské náměstí',
          'tr': 'Eski Şehir Meydanı',
          'es': 'Plaza de la Ciudad Vieja',
          'fr': 'Place de la Vieille-Ville',
          'de': 'Altstädter Ring',
        },
        category: 'Attraction',
        latitude: 50.0875,
        longitude: 14.4213,
        description: 'Historic square in Old Town',
        rating: 4.8,
      ),
    ];
  }

  static List<Place> _getAthensPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Acropolis',
        localizedNames: {
          'el': 'Ακρόπολη',
          'tr': 'Akropolis',
          'es': 'Acrópolis',
          'fr': 'Acropole',
          'de': 'Akropolis',
        },
        category: 'Historic Site',
        latitude: 37.9715,
        longitude: 23.7257,
        description: 'Ancient citadel with Parthenon',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'Parthenon',
        localizedNames: {
          'el': 'Παρθενώνας',
          'tr': 'Parthenon',
          'es': 'Partenón',
          'fr': 'Parthénon',
          'de': 'Parthenon',
        },
        category: 'Historic Site',
        latitude: 37.9715,
        longitude: 23.7266,
        description: 'Ancient Greek temple',
        rating: 5.0,
      ),
      Place(
        cityId: cityId,
        name: 'Acropolis Museum',
        localizedNames: {
          'el': 'Μουσείο Ακρόπολης',
          'tr': 'Akropolis Müzesi',
          'es': 'Museo de la Acrópolis',
          'fr': 'Musée de l\'Acropole',
          'de': 'Akropolis-Museum',
        },
        category: 'Museum',
        latitude: 37.9686,
        longitude: 23.7281,
        description: 'Archaeological museum',
        rating: 4.9,
      ),
    ];
  }

  static List<Place> _getMadridPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Royal Palace', localizedNames: {'es': 'Palacio Real'}, category: 'Historic Site', latitude: 40.4179, longitude: -3.7143, description: 'Official residence of Spanish royal family', rating: 4.8),
      Place(cityId: cityId, name: 'Prado Museum', localizedNames: {'es': 'Museo del Prado'}, category: 'Museum', latitude: 40.4137, longitude: -3.6921, description: 'Main Spanish national art museum', rating: 4.9),
      Place(cityId: cityId, name: 'Retiro Park', localizedNames: {'es': 'El Retiro'}, category: 'Park', latitude: 40.4152, longitude: -3.6837, description: 'One of the largest parks in Madrid', rating: 4.7),
    ];
  }

  static List<Place> _getDublinPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Guinness Storehouse', category: 'Attraction', latitude: 53.3419, longitude: -6.2867, description: 'Brewery experience telling the tale of Ireland\'s famous beer', rating: 4.8),
      Place(cityId: cityId, name: 'Trinity College', category: 'Historic Site', latitude: 53.3438, longitude: -6.2546, description: 'Ireland\'s oldest university', rating: 4.7),
      Place(cityId: cityId, name: 'Temple Bar', category: 'District', latitude: 53.3454, longitude: -6.2641, description: 'Busy riverside neighborhood with pubs', rating: 4.6),
    ];
  }

  static List<Place> _getBrusselsPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Grand Place', localizedNames: {'fr': 'Grand-Place', 'nl': 'Grote Markt'}, category: 'Historic Site', latitude: 50.8467, longitude: 4.3524, description: 'Central square of Brussels', rating: 4.9),
      Place(cityId: cityId, name: 'Atomium', category: 'Attraction', latitude: 50.8949, longitude: 4.3415, description: 'Landmark building originally constructed for 1958 Brussels World\'s Fair', rating: 4.6),
      Place(cityId: cityId, name: 'Manneken Pis', category: 'Attraction', latitude: 50.8450, longitude: 4.3499, description: 'Iconic bronze statue', rating: 4.4),
    ];
  }

  static List<Place> _getMunichPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Marienplatz', category: 'Historic Site', latitude: 48.1372, longitude: 11.5755, description: 'Central square in Munich', rating: 4.8),
      Place(cityId: cityId, name: 'English Garden', localizedNames: {'de': 'Englischer Garten'}, category: 'Park', latitude: 48.1528, longitude: 11.5923, description: 'Large public park', rating: 4.8),
      Place(cityId: cityId, name: 'Nymphenburg Palace', localizedNames: {'de': 'Schloss Nymphenburg'}, category: 'Historic Site', latitude: 48.1582, longitude: 11.5033, description: 'Baroque palace', rating: 4.7),
    ];
  }

  static List<Place> _getMilanPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Duomo di Milano', category: 'Religious Site', latitude: 45.4641, longitude: 9.1919, description: 'Iconic Gothic cathedral', rating: 4.9),
      Place(cityId: cityId, name: 'Galleria Vittorio Emanuele II', category: 'Attraction', latitude: 45.4659, longitude: 9.1900, description: 'Italy\'s oldest active shopping gallery', rating: 4.7),
      Place(cityId: cityId, name: 'Sforzesco Castle', localizedNames: {'it': 'Castello Sforzesco'}, category: 'Historic Site', latitude: 45.4705, longitude: 9.1793, description: 'Medieval fortress', rating: 4.6),
    ];
  }

  static List<Place> _getVenicePlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'St. Mark\'s Basilica', localizedNames: {'it': 'Basilica di San Marco'}, category: 'Religious Site', latitude: 45.4345, longitude: 12.3397, description: 'Famous cathedral in Venice', rating: 4.9),
      Place(cityId: cityId, name: 'Rialto Bridge', localizedNames: {'it': 'Ponte di Rialto'}, category: 'Historic Site', latitude: 45.4379, longitude: 12.3359, description: 'Oldest bridge across the Grand Canal', rating: 4.8),
      Place(cityId: cityId, name: 'Grand Canal', localizedNames: {'it': 'Canal Grande'}, category: 'Attraction', latitude: 45.4375, longitude: 12.3325, description: 'Main waterway in Venice', rating: 4.9),
    ];
  }

  static List<Place> _getFlorencePlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Florence Cathedral', localizedNames: {'it': 'Duomo di Firenze'}, category: 'Religious Site', latitude: 43.7731, longitude: 11.2560, description: 'Cathedral with iconic Renaissance dome', rating: 4.9),
      Place(cityId: cityId, name: 'Uffizi Gallery', localizedNames: {'it': 'Galleria degli Uffizi'}, category: 'Museum', latitude: 43.7678, longitude: 11.2553, description: 'Prominent art museum', rating: 4.9),
      Place(cityId: cityId, name: 'Ponte Vecchio', category: 'Historic Site', latitude: 43.7680, longitude: 11.2532, description: 'Medieval stone arch bridge', rating: 4.7),
    ];
  }

  static List<Place> _getZurichPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Old Town', localizedNames: {'de': 'Altstadt'}, category: 'Historic Site', latitude: 47.3717, longitude: 8.5422, description: 'Historic center of Zurich', rating: 4.7),
      Place(cityId: cityId, name: 'Lake Zurich', localizedNames: {'de': 'Zürichsee'}, category: 'Attraction', latitude: 47.3600, longitude: 8.5500, description: 'Large lake extending southeast of the city', rating: 4.8),
      Place(cityId: cityId, name: 'Uetliberg', category: 'Viewpoint', latitude: 47.3522, longitude: 8.4910, description: 'Mountain offering panoramic views', rating: 4.7),
    ];
  }

  static List<Place> _getStockholmPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Gamla Stan', category: 'Historic Site', latitude: 59.3251, longitude: 18.0708, description: 'The Old Town of Stockholm', rating: 4.7),
      Place(cityId: cityId, name: 'Vasa Museum', localizedNames: {'sv': 'Vasamuseet'}, category: 'Museum', latitude: 59.3280, longitude: 18.0914, description: 'Maritime museum', rating: 4.9),
      Place(cityId: cityId, name: 'Skansen', category: 'Museum', latitude: 59.3247, longitude: 18.1014, description: 'Open-air museum and zoo', rating: 4.6),
    ];
  }

  static List<Place> _getCopenhagenPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Nyhavn', category: 'Attraction', latitude: 55.6797, longitude: 12.5916, description: '17th-century waterfront, canal and entertainment district', rating: 4.8),
      Place(cityId: cityId, name: 'Tivoli Gardens', category: 'Attraction', latitude: 55.6737, longitude: 12.5681, description: 'Famous amusement park', rating: 4.7),
      Place(cityId: cityId, name: 'The Little Mermaid', localizedNames: {'da': 'Den lille Havfrue'}, category: 'Attraction', latitude: 55.6929, longitude: 12.5993, description: 'Bronze statue by Edvard Eriksen', rating: 4.3),
    ];
  }

  static List<Place> _getOsloPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Oslo Opera House', localizedNames: {'no': 'Operahuset'}, category: 'Attraction', latitude: 59.9075, longitude: 10.7531, description: 'Home of the Norwegian National Opera and Ballet', rating: 4.8),
      Place(cityId: cityId, name: 'Vigeland Park', category: 'Park', latitude: 59.9270, longitude: 10.7008, description: 'Sculpture park by Gustav Vigeland', rating: 4.8),
      Place(cityId: cityId, name: 'Viking Ship Museum', category: 'Museum', latitude: 59.9049, longitude: 10.6844, description: 'Museum displaying Viking ships', rating: 4.7),
    ];
  }

  static List<Place> _getHelsinkiPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Helsinki Cathedral', localizedNames: {'fi': 'Helsingin tuomiokirkko'}, category: 'Religious Site', latitude: 60.1702, longitude: 24.9522, description: 'Finnish Evangelical Lutheran cathedral', rating: 4.7),
      Place(cityId: cityId, name: 'Suomenlinna', category: 'Historic Site', latitude: 60.1468, longitude: 24.9914, description: 'Inhabited sea fortress', rating: 4.8),
      Place(cityId: cityId, name: 'Temppeliaukio Church', category: 'Religious Site', latitude: 60.1730, longitude: 24.9252, description: 'Lutheran church built directly into solid rock', rating: 4.6),
    ];
  }

  static List<Place> _getWarsawPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Old Town Market Place', localizedNames: {'pl': 'Rynek Starego Miasta'}, category: 'Historic Site', latitude: 52.2497, longitude: 21.0122, description: 'Center of the Old Town', rating: 4.8),
      Place(cityId: cityId, name: 'Royal Castle', localizedNames: {'pl': 'Zamek Królewski'}, category: 'Historic Site', latitude: 52.2480, longitude: 21.0154, description: 'Former royal residence', rating: 4.7),
      Place(cityId: cityId, name: 'Lazienki Park', category: 'Park', latitude: 52.2155, longitude: 21.0355, description: 'Largest park in Warsaw', rating: 4.9),
    ];
  }

  static List<Place> _getKrakowPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Main Market Square', localizedNames: {'pl': 'Rynek Główny'}, category: 'Historic Site', latitude: 50.0616, longitude: 19.9372, description: 'Main square of the Old Town', rating: 4.9),
      Place(cityId: cityId, name: 'Wawel Royal Castle', localizedNames: {'pl': 'Zamek Królewski na Wawelu'}, category: 'Historic Site', latitude: 50.0540, longitude: 19.9354, description: 'Gothic castle', rating: 4.8),
      Place(cityId: cityId, name: 'St. Mary\'s Basilica', category: 'Religious Site', latitude: 50.0616, longitude: 19.9390, description: 'Brick Gothic church', rating: 4.8),
    ];
  }

  static List<Place> _getEdinburghPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Edinburgh Castle', category: 'Historic Site', latitude: 55.9486, longitude: -3.1999, description: 'Historic fortress dominating the skyline', rating: 4.8),
      Place(cityId: cityId, name: 'Royal Mile', category: 'Attraction', latitude: 55.9505, longitude: -3.1900, description: 'Succession of streets forming the main thoroughfare', rating: 4.7),
      Place(cityId: cityId, name: 'Arthur\'s Seat', category: 'Viewpoint', latitude: 55.9442, longitude: -3.1619, description: 'Ancient volcano and main peak', rating: 4.8),
    ];
  }

  static List<Place> _getGenevaPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Jet d\'Eau', category: 'Attraction', latitude: 46.2074, longitude: 6.1559, description: 'Large fountain in Geneva', rating: 4.6),
      Place(cityId: cityId, name: 'St. Pierre Cathedral', category: 'Religious Site', latitude: 46.2017, longitude: 6.1485, description: 'Cathedral in the Old Town', rating: 4.5),
      Place(cityId: cityId, name: 'Palace of Nations', localizedNames: {'fr': 'Palais des Nations'}, category: 'Historic Site', latitude: 46.2228, longitude: 6.1401, description: 'Home of the United Nations Office', rating: 4.6),
    ];
  }

  static List<Place> _getNewYorkPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Statue of Liberty', category: 'Landmark', latitude: 40.6892, longitude: -74.0445, description: 'Colossal neoclassical sculpture on Liberty Island', rating: 4.9),
      Place(cityId: cityId, name: 'Central Park', category: 'Park', latitude: 40.7851, longitude: -73.9683, description: 'Urban park in Manhattan', rating: 4.9),
      Place(cityId: cityId, name: 'Times Square', category: 'Attraction', latitude: 40.7580, longitude: -73.9855, description: 'Major commercial intersection', rating: 4.7),
    ];
  }

  static List<Place> _getLosAngelesPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Hollywood Sign', category: 'Landmark', latitude: 34.1341, longitude: -118.3215, description: 'American landmark and cultural icon', rating: 4.6),
      Place(cityId: cityId, name: 'Santa Monica Pier', category: 'Attraction', latitude: 34.0100, longitude: -118.4960, description: 'Large double-jointed pier', rating: 4.7),
      Place(cityId: cityId, name: 'Griffith Observatory', category: 'Attraction', latitude: 34.1184, longitude: -118.3004, description: 'Observatory with views of Los Angeles', rating: 4.8),
    ];
  }

  static List<Place> _getSanFranciscoPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Golden Gate Bridge', category: 'Landmark', latitude: 37.8199, longitude: -122.4783, description: 'Suspension bridge spanning the Golden Gate', rating: 4.9),
      Place(cityId: cityId, name: 'Alcatraz Island', category: 'Historic Site', latitude: 37.8270, longitude: -122.4230, description: 'Small island with former federal prison', rating: 4.8),
      Place(cityId: cityId, name: 'Fisherman\'s Wharf', category: 'Attraction', latitude: 37.8080, longitude: -122.4177, description: 'Neighborhood and popular tourist attraction', rating: 4.6),
    ];
  }

  static List<Place> _getLasVegasPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'The Strip', category: 'Attraction', latitude: 36.1147, longitude: -115.1728, description: 'Stretch of South Las Vegas Boulevard', rating: 4.8),
      Place(cityId: cityId, name: 'Bellagio Fountains', category: 'Attraction', latitude: 36.1126, longitude: -115.1767, description: 'Musical fountain show', rating: 4.9),
      Place(cityId: cityId, name: 'High Roller', category: 'Attraction', latitude: 36.1176, longitude: -115.1681, description: '550-foot tall Ferris wheel', rating: 4.6),
    ];
  }

  static List<Place> _getMiamiPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'South Beach', category: 'Beach', latitude: 25.7826, longitude: -80.1341, description: 'Famous beach and neighborhood', rating: 4.7),
      Place(cityId: cityId, name: 'Art Deco District', category: 'Historic Site', latitude: 25.7810, longitude: -80.1300, description: 'Historic district with colorful buildings', rating: 4.6),
      Place(cityId: cityId, name: 'Vizcaya Museum and Gardens', category: 'Museum', latitude: 25.7444, longitude: -80.2105, description: 'Former villa and estate', rating: 4.8),
    ];
  }

  static List<Place> _getChicagoPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Millennium Park', category: 'Park', latitude: 41.8826, longitude: -87.6226, description: 'Public park with Cloud Gate sculpture', rating: 4.8),
      Place(cityId: cityId, name: 'Navy Pier', category: 'Attraction', latitude: 41.8916, longitude: -87.6075, description: 'Pier on Lake Michigan', rating: 4.6),
      Place(cityId: cityId, name: 'Willis Tower', category: 'Attraction', latitude: 41.8789, longitude: -87.6359, description: 'Skyscraper with observation deck', rating: 4.7),
    ];
  }

  static List<Place> _getTorontoPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'CN Tower', category: 'Landmark', latitude: 43.6426, longitude: -79.3871, description: 'Communication and observation tower', rating: 4.8),
      Place(cityId: cityId, name: 'Royal Ontario Museum', category: 'Museum', latitude: 43.6677, longitude: -79.3948, description: 'Museum of art, world culture and natural history', rating: 4.7),
      Place(cityId: cityId, name: 'Ripley\'s Aquarium of Canada', category: 'Attraction', latitude: 43.6424, longitude: -79.3860, description: 'Public aquarium', rating: 4.8),
    ];
  }

  static List<Place> _getVancouverPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Stanley Park', category: 'Park', latitude: 49.3017, longitude: -123.1417, description: 'Public park that borders the downtown', rating: 4.9),
      Place(cityId: cityId, name: 'Capilano Suspension Bridge', category: 'Attraction', latitude: 49.3429, longitude: -123.1149, description: 'Simple suspension bridge', rating: 4.7),
      Place(cityId: cityId, name: 'Granville Island', category: 'District', latitude: 49.2712, longitude: -123.1340, description: 'Peninsula and shopping district', rating: 4.8),
    ];
  }

  static List<Place> _getMontrealPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Old Montreal', localizedNames: {'fr': 'Vieux-Montréal'}, category: 'Historic Site', latitude: 45.5076, longitude: -73.5547, description: 'Historic neighbourhood', rating: 4.8),
      Place(cityId: cityId, name: 'Mount Royal', localizedNames: {'fr': 'Mont Royal'}, category: 'Park', latitude: 45.5088, longitude: -73.5878, description: 'Large volcanic-related hill', rating: 4.7),
      Place(cityId: cityId, name: 'Notre-Dame Basilica', localizedNames: {'fr': 'Basilique Notre-Dame'}, category: 'Religious Site', latitude: 45.5045, longitude: -73.5560, description: 'Basilica in the historic district', rating: 4.9),
    ];
  }

  static List<Place> _getMexicoCityPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Zócalo', category: 'Historic Site', latitude: 19.4326, longitude: -99.1332, description: 'Main square in central Mexico City', rating: 4.8),
      Place(cityId: cityId, name: 'Frida Kahlo Museum', localizedNames: {'es': 'Museo Frida Kahlo'}, category: 'Museum', latitude: 19.3551, longitude: -99.1624, description: 'Historic house and art museum', rating: 4.7),
      Place(cityId: cityId, name: 'Chapultepec Castle', localizedNames: {'es': 'Castillo de Chapultepec'}, category: 'Historic Site', latitude: 19.4204, longitude: -99.1819, description: 'Castle located on top of Chapultepec Hill', rating: 4.8),
    ];
  }

  static List<Place> _getRioDeJaneiroPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Christ the Redeemer', localizedNames: {'pt': 'Cristo Redentor'}, category: 'Landmark', latitude: -22.9519, longitude: -43.2105, description: 'Art Deco statue of Jesus Christ', rating: 5.0),
      Place(cityId: cityId, name: 'Sugarloaf Mountain', localizedNames: {'pt': 'Pão de Açúcar'}, category: 'Viewpoint', latitude: -22.9492, longitude: -43.1545, description: 'Peak situated at the mouth of Guanabara Bay', rating: 4.9),
      Place(cityId: cityId, name: 'Copacabana', category: 'Beach', latitude: -22.9694, longitude: -43.1868, description: 'Famous beach', rating: 4.8),
    ];
  }

  static List<Place> _getBuenosAiresPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Plaza de Mayo', category: 'Historic Site', latitude: -34.6083, longitude: -58.3712, description: 'Main square in the Monserrat barrio', rating: 4.7),
      Place(cityId: cityId, name: 'La Recoleta Cemetery', localizedNames: {'es': 'Cementerio de la Recoleta'}, category: 'Historic Site', latitude: -34.5876, longitude: -58.3926, description: 'Cemetery in the Recoleta neighbourhood', rating: 4.8),
      Place(cityId: cityId, name: 'Teatro Colón', category: 'Attraction', latitude: -34.6011, longitude: -58.3821, description: 'Main opera house in Buenos Aires', rating: 4.9),
    ];
  }

  static List<Place> _getTokyoPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Sensō-ji', category: 'Religious Site', latitude: 35.7148, longitude: 139.7967, description: 'Ancient Buddhist temple in Asakusa', rating: 4.9),
      Place(cityId: cityId, name: 'Tokyo Tower', category: 'Landmark', latitude: 35.6586, longitude: 139.7454, description: 'Communications and observation tower', rating: 4.7),
      Place(cityId: cityId, name: 'Meiji Shrine', category: 'Religious Site', latitude: 35.6764, longitude: 139.6993, description: 'Shinto shrine dedicated to Emperor Meiji', rating: 4.8),
    ];
  }

  static List<Place> _getKyotoPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Fushimi Inari-taisha', category: 'Religious Site', latitude: 34.9671, longitude: 135.7727, description: 'Head shrine of the god Inari', rating: 5.0),
      Place(cityId: cityId, name: 'Kinkaku-ji', category: 'Religious Site', latitude: 35.0394, longitude: 135.7292, description: 'Zen Buddhist temple (Golden Pavilion)', rating: 4.9),
      Place(cityId: cityId, name: 'Kiyomizu-dera', category: 'Religious Site', latitude: 34.9949, longitude: 135.7850, description: 'Historic Buddhist temple', rating: 4.8),
    ];
  }

  static List<Place> _getSeoulPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Gyeongbokgung Palace', category: 'Historic Site', latitude: 37.5796, longitude: 126.9770, description: 'Main royal palace of the Joseon dynasty', rating: 4.9),
      Place(cityId: cityId, name: 'N Seoul Tower', category: 'Attraction', latitude: 37.5512, longitude: 126.9882, description: 'Communication and observation tower', rating: 4.7),
      Place(cityId: cityId, name: 'Bukchon Hanok Village', category: 'Historic Site', latitude: 37.5826, longitude: 126.9830, description: 'Korean traditional village', rating: 4.8),
    ];
  }

  static List<Place> _getBangkokPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Grand Palace', category: 'Historic Site', latitude: 13.7500, longitude: 100.4913, description: 'Complex of buildings at the heart of Bangkok', rating: 4.9),
      Place(cityId: cityId, name: 'Wat Arun', category: 'Religious Site', latitude: 13.7437, longitude: 100.4888, description: 'Buddhist temple on the Chao Phraya River', rating: 4.8),
      Place(cityId: cityId, name: 'Wat Phra Kaew', category: 'Religious Site', latitude: 13.7516, longitude: 100.4926, description: 'Temple of the Emerald Buddha', rating: 4.9),
    ];
  }

  static List<Place> _getSingaporePlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Marina Bay Sands', category: 'Attraction', latitude: 1.2834, longitude: 103.8607, description: 'Integrated resort fronting Marina Bay', rating: 4.9),
      Place(cityId: cityId, name: 'Gardens by the Bay', category: 'Park', latitude: 1.2816, longitude: 103.8636, description: 'Nature park spanning 101 hectares', rating: 4.9),
      Place(cityId: cityId, name: 'Sentosa', category: 'Attraction', latitude: 1.2494, longitude: 103.8303, description: 'Island resort with attractions', rating: 4.7),
    ];
  }

  static List<Place> _getDubaiPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Burj Khalifa', category: 'Landmark', latitude: 25.1972, longitude: 55.2744, description: 'Tallest structure in the world', rating: 5.0),
      Place(cityId: cityId, name: 'The Dubai Mall', category: 'Attraction', latitude: 25.1975, longitude: 55.2797, description: 'One of the world\'s largest shopping malls', rating: 4.8),
      Place(cityId: cityId, name: 'Palm Jumeirah', category: 'Attraction', latitude: 25.1124, longitude: 55.1390, description: 'Artificial archipelago', rating: 4.7),
    ];
  }

  static List<Place> _getHongKongPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Victoria Peak', category: 'Viewpoint', latitude: 22.2759, longitude: 114.1455, description: 'Hill on the western half of Hong Kong Island', rating: 4.9),
      Place(cityId: cityId, name: 'Tian Tan Buddha', category: 'Religious Site', latitude: 22.2540, longitude: 113.9053, description: 'Large bronze statue of Buddha', rating: 4.8),
      Place(cityId: cityId, name: 'Star Ferry', category: 'Attraction', latitude: 22.2866, longitude: 114.1611, description: 'Passenger ferry service crossing Victoria Harbour', rating: 4.7),
    ];
  }

  static List<Place> _getBeijingPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Forbidden City', category: 'Historic Site', latitude: 39.9163, longitude: 116.3972, description: 'Palace complex in central Beijing', rating: 5.0),
      Place(cityId: cityId, name: 'Great Wall of China', category: 'Landmark', latitude: 40.4319, longitude: 116.5704, description: 'Ancient series of walls and fortifications', rating: 5.0),
      Place(cityId: cityId, name: 'Summer Palace', category: 'Historic Site', latitude: 39.9999, longitude: 116.2753, description: 'Vast ensemble of lakes, gardens and palaces', rating: 4.9),
    ];
  }

  static List<Place> _getShanghaiPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'The Bund', category: 'Attraction', latitude: 31.2416, longitude: 121.4844, description: 'Waterfront area in central Shanghai', rating: 4.9),
      Place(cityId: cityId, name: 'Oriental Pearl Tower', category: 'Landmark', latitude: 31.2397, longitude: 121.4998, description: 'TV tower in Pudong', rating: 4.8),
      Place(cityId: cityId, name: 'Yu Garden', category: 'Park', latitude: 31.2272, longitude: 121.4921, description: 'Extensive Chinese garden', rating: 4.7),
    ];
  }

  static List<Place> _getMumbaiPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Gateway of India', category: 'Landmark', latitude: 18.9220, longitude: 72.8347, description: 'Arch-monument built in the 20th century', rating: 4.8),
      Place(cityId: cityId, name: 'Elephanta Caves', category: 'Historic Site', latitude: 18.9633, longitude: 72.9315, description: 'UNESCO World Heritage Site', rating: 4.7),
      Place(cityId: cityId, name: 'Marine Drive', category: 'Attraction', latitude: 18.9442, longitude: 72.8232, description: '3.6-kilometre-long boulevard', rating: 4.7),
    ];
  }

  static List<Place> _getDelhiPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Red Fort', category: 'Historic Site', latitude: 28.6562, longitude: 77.2410, description: 'Historic fort in Old Delhi', rating: 4.8),
      Place(cityId: cityId, name: 'Qutub Minar', category: 'Historic Site', latitude: 28.5244, longitude: 77.1855, description: 'Minaret and "victory tower"', rating: 4.9),
      Place(cityId: cityId, name: 'India Gate', category: 'Landmark', latitude: 28.6129, longitude: 77.2295, description: 'War memorial', rating: 4.8),
    ];
  }

  static List<Place> _getSydneyPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Sydney Opera House', category: 'Landmark', latitude: -33.8568, longitude: 151.2153, description: 'Multi-venue performing arts centre', rating: 5.0),
      Place(cityId: cityId, name: 'Sydney Harbour Bridge', category: 'Landmark', latitude: -33.8523, longitude: 151.2108, description: 'Heritage-listed steel through arch bridge', rating: 4.9),
      Place(cityId: cityId, name: 'Bondi Beach', category: 'Beach', latitude: -33.8915, longitude: 151.2767, description: 'Popular beach and surrounding suburb', rating: 4.8),
    ];
  }

  static List<Place> _getMelbournePlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Federation Square', category: 'Attraction', latitude: -37.8180, longitude: 144.9691, description: 'Venue for arts, culture and public events', rating: 4.7),
      Place(cityId: cityId, name: 'Royal Botanic Gardens', category: 'Park', latitude: -37.8304, longitude: 144.9796, description: 'Large garden close to the city centre', rating: 4.9),
      Place(cityId: cityId, name: 'Melbourne Cricket Ground', category: 'Attraction', latitude: -37.8199, longitude: 144.9834, description: 'Sports stadium', rating: 4.8),
    ];
  }

  static List<Place> _getCairoPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Pyramids of Giza', category: 'Historic Site', latitude: 29.9792, longitude: 31.1342, description: 'Ancient pyramid complex', rating: 5.0),
      Place(cityId: cityId, name: 'Great Sphinx', category: 'Landmark', latitude: 29.9753, longitude: 31.1376, description: 'Limestone statue of a reclining sphinx', rating: 5.0),
      Place(cityId: cityId, name: 'Egyptian Museum', category: 'Museum', latitude: 30.0478, longitude: 31.2336, description: 'Museum of ancient Egyptian antiquities', rating: 4.9),
    ];
  }

  static List<Place> _getCapeTownPlaces(int cityId) {
    return [
      Place(cityId: cityId, name: 'Table Mountain', category: 'Viewpoint', latitude: -33.9628, longitude: 18.4098, description: 'Flat-topped mountain overlooking Cape Town', rating: 5.0),
      Place(cityId: cityId, name: 'Robben Island', category: 'Historic Site', latitude: -33.8076, longitude: 18.3712, description: 'Island known for its prison', rating: 4.8),
      Place(cityId: cityId, name: 'V&A Waterfront', category: 'Attraction', latitude: -33.9036, longitude: 18.4205, description: 'Shopping and entertainment district', rating: 4.7),
    ];
  }
}
