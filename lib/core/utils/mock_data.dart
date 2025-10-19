import '../../models/city.dart';
import '../../models/place.dart';

class MockData {
  // Mock cities
  static final List<City> cities = [
    City(
      name: 'Paris',
      country: 'France',
      latitude: 48.8566,
      longitude: 2.3522,
      description: 'The City of Light, known for art, fashion, and culture',
      imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
    ),
    City(
      name: 'Rome',
      country: 'Italy',
      latitude: 41.9028,
      longitude: 12.4964,
      description: 'The Eternal City, home to ancient ruins and Renaissance art',
      imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
    ),
    City(
      name: 'London',
      country: 'United Kingdom',
      latitude: 51.5074,
      longitude: -0.1278,
      description: 'A diverse metropolis with rich history and modern culture',
      imageUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad',
    ),
    City(
      name: 'Tokyo',
      country: 'Japan',
      latitude: 35.6762,
      longitude: 139.6503,
      description: 'A bustling metropolis blending tradition and innovation',
      imageUrl: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf',
    ),
    City(
      name: 'New York',
      country: 'United States',
      latitude: 40.7128,
      longitude: -74.0060,
      description: 'The city that never sleeps, a global hub of culture and commerce',
      imageUrl: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9',
    ),
  ];

  // Mock places for Paris
  static List<Place> getParisPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Eiffel Tower',
        category: 'Landmark',
        description: 'Iconic iron lattice tower on the Champ de Mars',
        latitude: 48.8584,
        longitude: 2.2945,
        rating: 4.7,
        address: 'Champ de Mars, 5 Avenue Anatole France',
        imageUrl: 'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f',
      ),
      Place(
        cityId: cityId,
        name: 'Louvre Museum',
        category: 'Museum',
        description: 'World\'s largest art museum and historic monument',
        latitude: 48.8606,
        longitude: 2.3376,
        rating: 4.8,
        address: 'Rue de Rivoli',
        imageUrl: 'https://images.unsplash.com/photo-1499856871958-5b9627545d1a',
      ),
      Place(
        cityId: cityId,
        name: 'Arc de Triomphe',
        category: 'Monument',
        description: 'Monumental arch honoring those who fought for France',
        latitude: 48.8738,
        longitude: 2.2950,
        rating: 4.6,
        address: 'Place Charles de Gaulle',
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
      ),
      Place(
        cityId: cityId,
        name: 'Notre-Dame Cathedral',
        category: 'Cathedral',
        description: 'Medieval Catholic cathedral with Gothic architecture',
        latitude: 48.8530,
        longitude: 2.3499,
        rating: 4.7,
        address: '6 Parvis Notre-Dame',
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
      ),
      Place(
        cityId: cityId,
        name: 'Sacré-Cœur',
        category: 'Basilica',
        description: 'Roman Catholic church and minor basilica',
        latitude: 48.8867,
        longitude: 2.3431,
        rating: 4.6,
        address: '35 Rue du Chevalier de la Barre',
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
      ),
      Place(
        cityId: cityId,
        name: 'Champs-Élysées',
        category: 'Street',
        description: 'Famous avenue lined with shops, cafés, and theaters',
        latitude: 48.8698,
        longitude: 2.3078,
        rating: 4.5,
        address: 'Avenue des Champs-Élysées',
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
      ),
      Place(
        cityId: cityId,
        name: 'Versailles Palace',
        category: 'Palace',
        description: 'Opulent 17th-century palace with vast gardens',
        latitude: 48.8049,
        longitude: 2.1204,
        rating: 4.8,
        address: 'Place d\'Armes',
        imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
      ),
    ];
  }

  // Mock places for Rome
  static List<Place> getRomePlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Colosseum',
        category: 'Landmark',
        description: 'Ancient amphitheater and iconic symbol of Rome',
        latitude: 41.8902,
        longitude: 12.4922,
        rating: 4.8,
        address: 'Piazza del Colosseo',
        imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
      ),
      Place(
        cityId: cityId,
        name: 'Vatican Museums',
        category: 'Museum',
        description: 'Art and Christian museums with the Sistine Chapel',
        latitude: 41.9065,
        longitude: 12.4536,
        rating: 4.7,
        address: 'Viale Vaticano',
        imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
      ),
      Place(
        cityId: cityId,
        name: 'Trevi Fountain',
        category: 'Fountain',
        description: 'Baroque fountain, the largest in Rome',
        latitude: 41.9009,
        longitude: 12.4833,
        rating: 4.7,
        address: 'Piazza di Trevi',
        imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
      ),
      Place(
        cityId: cityId,
        name: 'Pantheon',
        category: 'Monument',
        description: 'Former Roman temple, now a church',
        latitude: 41.8986,
        longitude: 12.4769,
        rating: 4.7,
        address: 'Piazza della Rotonda',
        imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
      ),
      Place(
        cityId: cityId,
        name: 'Roman Forum',
        category: 'Archaeological Site',
        description: 'Ancient plaza surrounded by ruins',
        latitude: 41.8925,
        longitude: 12.4853,
        rating: 4.6,
        address: 'Via della Salara Vecchia',
        imageUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5',
      ),
    ];
  }

  // Mock places for London
  static List<Place> getLondonPlaces(int cityId) {
    return [
      Place(
        cityId: cityId,
        name: 'Big Ben',
        category: 'Landmark',
        description: 'Iconic clock tower at the Palace of Westminster',
        latitude: 51.5007,
        longitude: -0.1246,
        rating: 4.7,
        address: 'Westminster',
        imageUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad',
      ),
      Place(
        cityId: cityId,
        name: 'British Museum',
        category: 'Museum',
        description: 'World-famous museum of human history and culture',
        latitude: 51.5194,
        longitude: -0.1270,
        rating: 4.8,
        address: 'Great Russell Street',
        imageUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad',
      ),
      Place(
        cityId: cityId,
        name: 'Tower of London',
        category: 'Castle',
        description: 'Historic castle and home to the Crown Jewels',
        latitude: 51.5081,
        longitude: -0.0759,
        rating: 4.6,
        address: 'Tower Hill',
        imageUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad',
      ),
      Place(
        cityId: cityId,
        name: 'London Eye',
        category: 'Attraction',
        description: 'Giant Ferris wheel on the South Bank',
        latitude: 51.5033,
        longitude: -0.1195,
        rating: 4.5,
        address: 'Riverside Building, County Hall',
        imageUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad',
      ),
      Place(
        cityId: cityId,
        name: 'Buckingham Palace',
        category: 'Palace',
        description: 'Official residence of the British monarch',
        latitude: 51.5014,
        longitude: -0.1419,
        rating: 4.6,
        address: 'Westminster',
        imageUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad',
      ),
    ];
  }

  // Get places for any city
  static List<Place> getPlacesForCity(int cityId, String cityName) {
    switch (cityName) {
      case 'Paris':
        return getParisPlaces(cityId);
      case 'Rome':
        return getRomePlaces(cityId);
      case 'London':
        return getLondonPlaces(cityId);
      default:
        return [];
    }
  }
}
