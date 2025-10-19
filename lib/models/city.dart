class City {
  final int? id;
  final String name;
  final String country;
  final double latitude;
  final double longitude;
  final String? imageUrl;
  final String? description;
  final DateTime? lastViewed;

  City({
    this.id,
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
    this.description,
    this.lastViewed,
  });

  // Convert City to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'image_url': imageUrl,
      'description': description,
      'last_viewed': lastViewed?.toIso8601String(),
    };
  }

  // Create City from Map
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] as int?,
      name: map['name'] as String,
      country: map['country'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      imageUrl: map['image_url'] as String?,
      description: map['description'] as String?,
      lastViewed: map['last_viewed'] != null
          ? DateTime.parse(map['last_viewed'] as String)
          : null,
    );
  }

  // Create a copy with updated fields
  City copyWith({
    int? id,
    String? name,
    String? country,
    double? latitude,
    double? longitude,
    String? imageUrl,
    String? description,
    DateTime? lastViewed,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      lastViewed: lastViewed ?? this.lastViewed,
    );
  }

  @override
  String toString() {
    return 'City(id: $id, name: $name, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is City && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  /// Get translated city name
  String getTranslatedName(String languageCode, translationService) {
    return translationService.translateCity(name, languageCode);
  }

  /// Get translated country name
  String getTranslatedCountry(String languageCode, translationService) {
    return translationService.translateCountry(country, languageCode);
  }
}
