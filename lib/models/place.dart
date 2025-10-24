class Place {
  final int? id;
  final int cityId;
  final String name; // Default/original name
  final Map<String, String> localizedNames; // Names in different languages (e.g., 'en': 'Colosseum', 'tr': 'Kolezyum')
  final String? description;
  final String category;
  final double latitude;
  final double longitude;
  final String? imageUrl;
  final double? rating;
  final String? address;
  final bool isSelected;

  Place({
    this.id,
    required this.cityId,
    required this.name,
    this.localizedNames = const {},
    this.description,
    required this.category,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
    this.rating,
    this.address,
    this.isSelected = false,
  });
  
  /// Get name in preferred language with smart fallback
  /// Priority: User's language → English → Original name
  String getLocalizedName(String languageCode) {
    // Try user's preferred language
    if (localizedNames.containsKey(languageCode)) {
      return localizedNames[languageCode]!;
    }
    
    // Fallback to English if available (most common translation)
    if (languageCode != 'en' && localizedNames.containsKey('en')) {
      return localizedNames['en']!;
    }
    
    // Fallback to original name
    return name;
  }

  // Convert Place to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'city_id': cityId,
      'name': name,
      'description': description,
      'category': category,
      'latitude': latitude,
      'longitude': longitude,
      'image_url': imageUrl,
      'rating': rating,
      'address': address,
      'is_selected': isSelected ? 1 : 0,
    };
  }

  // Create Place from Map
  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] as int?,
      cityId: map['city_id'] as int,
      name: map['name'] as String,
      description: map['description'] as String?,
      category: map['category'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      imageUrl: map['image_url'] as String?,
      rating: map['rating'] as double?,
      address: map['address'] as String?,
      isSelected: (map['is_selected'] as int?) == 1,
    );
  }

  // Create a copy with updated fields
  Place copyWith({
    int? id,
    int? cityId,
    String? name,
    Map<String, String>? localizedNames,
    String? description,
    String? category,
    double? latitude,
    double? longitude,
    String? imageUrl,
    double? rating,
    String? address,
    bool? isSelected,
  }) {
    return Place(
      id: id ?? this.id,
      cityId: cityId ?? this.cityId,
      name: name ?? this.name,
      localizedNames: localizedNames ?? this.localizedNames,
      description: description ?? this.description,
      category: category ?? this.category,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      address: address ?? this.address,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  String toString() {
    return 'Place(id: $id, name: $name, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Place && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
