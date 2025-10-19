class TravelRoute {
  final int? id;
  final String name;
  final int cityId;
  final List<int> placeIds;
  final double totalDistance;
  final int totalDuration; // in minutes
  final DateTime createdAt;
  final bool isFavorite;

  TravelRoute({
    this.id,
    required this.name,
    required this.cityId,
    required this.placeIds,
    required this.totalDistance,
    required this.totalDuration,
    DateTime? createdAt,
    this.isFavorite = false,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert Route to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city_id': cityId,
      'place_ids': placeIds.join(','), // Store as comma-separated string
      'total_distance': totalDistance,
      'total_duration': totalDuration,
      'created_at': createdAt.toIso8601String(),
      'is_favorite': isFavorite ? 1 : 0,
    };
  }

  // Create Route from Map
  factory TravelRoute.fromMap(Map<String, dynamic> map) {
    return TravelRoute(
      id: map['id'] as int?,
      name: map['name'] as String,
      cityId: map['city_id'] as int,
      placeIds: (map['place_ids'] as String)
          .split(',')
          .map((e) => int.parse(e))
          .toList(),
      totalDistance: map['total_distance'] as double,
      totalDuration: map['total_duration'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      isFavorite: (map['is_favorite'] as int?) == 1,
    );
  }

  // Create a copy with updated fields
  TravelRoute copyWith({
    int? id,
    String? name,
    int? cityId,
    List<int>? placeIds,
    double? totalDistance,
    int? totalDuration,
    DateTime? createdAt,
    bool? isFavorite,
  }) {
    return TravelRoute(
      id: id ?? this.id,
      name: name ?? this.name,
      cityId: cityId ?? this.cityId,
      placeIds: placeIds ?? this.placeIds,
      totalDistance: totalDistance ?? this.totalDistance,
      totalDuration: totalDuration ?? this.totalDuration,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Format distance for display
  String get formattedDistance {
    if (totalDistance < 1) {
      return '${(totalDistance * 1000).toStringAsFixed(0)} m';
    }
    return '${totalDistance.toStringAsFixed(1)} km';
  }

  // Format duration for display
  String get formattedDuration {
    final hours = totalDuration ~/ 60;
    final minutes = totalDuration % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  @override
  String toString() {
    return 'TravelRoute(id: $id, name: $name, places: ${placeIds.length})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TravelRoute && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
