import 'dart:math';
import '../../models/place.dart';

/// Ant Colony Optimization Service for solving Traveling Salesman Problem (TSP)
/// Based on the Ant System algorithm
class AcoService {
  // ACO Parameters
  static const int numAnts = 20; // Number of ants
  static const int numIterations = 200; // Number of iterations
  static const double alpha = 1.0; // Pheromone weight
  static const double beta = 1.0; // Heuristic weight (distance)
  static const double rho = 0.5; // Pheromone evaporation rate
  static const double pheromoneInitial = 1.0; // Initial pheromone value
  static const double Q = 100.0; // Pheromone deposit constant

  final Random _random = Random();

  /// Calculate optimal route through selected places using ACO algorithm
  /// Returns optimized list of places in visit order
  Future<AcoResult> calculateOptimalRoute(List<Place> places) async {
    if (places.isEmpty) {
      throw Exception('No places provided');
    }

    if (places.length == 1) {
      return AcoResult(
        route: places,
        totalDistance: 0.0,
        iterations: 0,
      );
    }

    final numCities = places.length;

    // Calculate distance matrix
    final distanceMatrix = _calculateDistanceMatrix(places);

    // Initialize pheromone matrix
    final pheromoneMatrix = List.generate(
      numCities,
      (_) => List.filled(numCities, pheromoneInitial),
    );

    double bestLength = double.infinity;
    List<int> bestTour = [];

    // Main ACO loop
    for (int iter = 0; iter < numIterations; iter++) {
      final tours = <List<int>>[];
      final tourLengths = <double>[];

      // Each ant constructs a tour
      for (int ant = 0; ant < numAnts; ant++) {
        final tour = _constructTour(
          numCities,
          distanceMatrix,
          pheromoneMatrix,
        );
        final length = _calculateTourLength(tour, distanceMatrix);

        tours.add(tour);
        tourLengths.add(length);

        // Update best solution
        if (length < bestLength) {
          bestLength = length;
          bestTour = List.from(tour);
        }
      }

      // Update pheromone matrix
      _updatePheromones(
        pheromoneMatrix,
        tours,
        tourLengths,
        bestTour,
        bestLength,
      );

      // Optional: Print progress every 50 iterations
      if ((iter + 1) % 50 == 0) {
        print('Iteration ${iter + 1}: Best distance = ${bestLength.toStringAsFixed(2)}');
      }
    }

    // Convert tour indices to ordered places
    final optimizedRoute = bestTour.map((index) => places[index]).toList();

    return AcoResult(
      route: optimizedRoute,
      totalDistance: bestLength,
      iterations: numIterations,
    );
  }

  /// Calculate distance matrix between all places using Haversine formula
  List<List<double>> _calculateDistanceMatrix(List<Place> places) {
    final numCities = places.length;
    final matrix = List.generate(
      numCities,
      (_) => List.filled(numCities, 0.0),
    );

    for (int i = 0; i < numCities; i++) {
      for (int j = 0; j < numCities; j++) {
        if (i != j) {
          matrix[i][j] = _haversineDistance(
            places[i].latitude,
            places[i].longitude,
            places[j].latitude,
            places[j].longitude,
          );
        } else {
          matrix[i][j] = double.infinity; // Self-distance is infinite
        }
      }
    }

    return matrix;
  }

  /// Calculate distance between two coordinates using Haversine formula
  /// Returns distance in kilometers
  double _haversineDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth's radius in kilometers

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  /// Construct a tour for one ant using probabilistic selection
  List<int> _constructTour(
    int numCities,
    List<List<double>> distanceMatrix,
    List<List<double>> pheromoneMatrix,
  ) {
    final tour = <int>[];
    final visited = List.filled(numCities, false);

    // Start from random city
    int currentCity = _random.nextInt(numCities);
    tour.add(currentCity);
    visited[currentCity] = true;

    // Visit remaining cities
    for (int step = 1; step < numCities; step++) {
      final nextCity = _selectNextCity(
        currentCity,
        visited,
        distanceMatrix,
        pheromoneMatrix,
      );

      tour.add(nextCity);
      visited[nextCity] = true;
      currentCity = nextCity;
    }

    tour.add(tour[0]); // Complete the tour (return to start)

    return tour;
  }

  /// Select next city based on pheromone and distance
  int _selectNextCity(
    int currentCity,
    List<bool> visited,
    List<List<double>> distanceMatrix,
    List<List<double>> pheromoneMatrix,
  ) {
    final numCities = visited.length;
    final probabilities = List.filled(numCities, 0.0);
    double sum = 0.0;

    // Calculate probabilities for unvisited cities
    for (int i = 0; i < numCities; i++) {
      if (!visited[i]) {
        final pheromone = pow(pheromoneMatrix[currentCity][i], alpha);
        final heuristic = pow(1.0 / distanceMatrix[currentCity][i], beta);
        probabilities[i] = (pheromone * heuristic).toDouble();
        sum += probabilities[i];
      }
    }

    // Normalize probabilities
    if (sum > 0) {
      for (int i = 0; i < numCities; i++) {
        probabilities[i] /= sum;
      }
    }

    // Roulette wheel selection
    final r = _random.nextDouble();
    double cumulative = 0.0;

    for (int i = 0; i < numCities; i++) {
      if (!visited[i]) {
        cumulative += probabilities[i];
        if (cumulative >= r) {
          return i;
        }
      }
    }

    // Fallback: return first unvisited city
    return visited.indexOf(false);
  }

  /// Calculate total tour length
  double _calculateTourLength(List<int> tour, List<List<double>> distanceMatrix) {
    double length = 0.0;

    for (int i = 0; i < tour.length - 1; i++) {
      length += distanceMatrix[tour[i]][tour[i + 1]];
    }

    return length;
  }

  /// Update pheromone matrix with evaporation and deposit
  void _updatePheromones(
    List<List<double>> pheromoneMatrix,
    List<List<int>> tours,
    List<double> tourLengths,
    List<int> bestTour,
    double bestLength,
  ) {
    final numCities = pheromoneMatrix.length;

    // Evaporation
    for (int i = 0; i < numCities; i++) {
      for (int j = 0; j < numCities; j++) {
        pheromoneMatrix[i][j] *= (1 - rho);
      }
    }

    // Deposit pheromones from all ants
    for (int ant = 0; ant < tours.length; ant++) {
      final tour = tours[ant];
      final length = tourLengths[ant];

      for (int i = 0; i < tour.length - 1; i++) {
        final from = tour[i];
        final to = tour[i + 1];
        pheromoneMatrix[from][to] += Q / length;
      }
    }

    // Additional pheromone for best tour (elitist strategy)
    for (int i = 0; i < bestTour.length - 1; i++) {
      final from = bestTour[i];
      final to = bestTour[i + 1];
      pheromoneMatrix[from][to] += Q / bestLength;
    }
  }
}

/// Result of ACO route optimization
class AcoResult {
  final List<Place> route;
  final double totalDistance;
  final int iterations;

  AcoResult({
    required this.route,
    required this.totalDistance,
    required this.iterations,
  });

  /// Get total distance in kilometers
  String get distanceInKm => '${totalDistance.toStringAsFixed(2)} km';

  /// Get estimated travel time (assuming average speed of 40 km/h in city)
  String get estimatedTime {
    final hours = totalDistance / 40.0;
    final minutes = (hours * 60).round();

    if (minutes < 60) {
      return '$minutes min';
    } else {
      final h = minutes ~/ 60;
      final m = minutes % 60;
      return '${h}h ${m}min';
    }
  }
}
