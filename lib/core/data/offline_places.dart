import '../../models/place.dart';

/// Offline places database for major tourist cities
/// Used as fallback when Overpass API is unavailable
class OfflinePlaces {
  
  /// Get places for a city by name
  static List<Place> getPlacesForCity(String cityName, int cityId) {
    final normalizedName = cityName.toLowerCase();
    
    switch (normalizedName) {
      case 'rome':
      case 'roma':
        return _getRomePlaces(cityId);
      case 'paris':
        return _getParisPlaces(cityId);
      case 'london':
      case 'londra':
        return _getLondonPlaces(cityId);
      case 'barcelona':
        return _getBarcelonaPlaces(cityId);
      case 'istanbul':
      case 'İstanbul':
        return _getIstanbulPlaces(cityId);
      case 'amsterdam':
        return _getAmsterdamPlaces(cityId);
      case 'berlin':
        return _getBerlinPlaces(cityId);
      case 'vienna':
      case 'viyana':
      case 'wien':
        return _getViennaPlaces(cityId);
      case 'prague':
      case 'prag':
      case 'praha':
        return _getPraguePlaces(cityId);
      case 'athens':
      case 'atina':
        return _getAthensPlaces(cityId);
      default:
        return [];
    }
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
}
