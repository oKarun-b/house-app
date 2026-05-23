class Property {
  final String id;
  final String landlordId;
  final String landlordName;
  final String landlordAvatar;
  final bool landlordVerified;
  final String landlordResponseTime;
  final int landlordListingsCount;
  final List<String> images;
  final String title;
  final String description;
  final double price;
  final String currency;
  final String neighborhood;
  final String landmark;
  final String propertyType;
  final int bedrooms;
  final int bathrooms;
  final bool hasWater;
  final int waterReliabilityScore;
  final bool hasElectricity;
  final int electricityStabilityScore;
  final bool hasParking;
  final bool hasInternet;
  final int internetQuality;
  final bool isFurnished;
  final bool isVerified;
  final bool isPremium;
  final double roadAccessibility;
  final int floodRisk;
  final String securityLevel;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isAvailable;
  final int views;
  final int favorites;
  final List<String> houseRules;
  final String status;

  Property({
    required this.id,
    required this.landlordId,
    required this.landlordName,
    this.landlordAvatar = '',
    this.landlordVerified = false,
    this.landlordResponseTime = 'Within 1 hour',
    this.landlordListingsCount = 1,
    required this.images,
    required this.title,
    this.description = '',
    required this.price,
    this.currency = 'XAF',
    required this.neighborhood,
    this.landmark = '',
    required this.propertyType,
    this.bedrooms = 1,
    this.bathrooms = 1,
    this.hasWater = false,
    this.waterReliabilityScore = 0,
    this.hasElectricity = false,
    this.electricityStabilityScore = 0,
    this.hasParking = false,
    this.hasInternet = false,
    this.internetQuality = 0,
    this.isFurnished = false,
    this.isVerified = false,
    this.isPremium = false,
    this.roadAccessibility = 0,
    this.floodRisk = 0,
    this.securityLevel = 'Medium',
    this.latitude = 0,
    this.longitude = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isAvailable = true,
    this.views = 0,
    this.favorites = 0,
    this.houseRules = const [],
    this.status = 'pending',
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'id': id,
    'landlordId': landlordId,
    'landlordName': landlordName,
    'landlordAvatar': landlordAvatar,
    'landlordVerified': landlordVerified,
    'landlordResponseTime': landlordResponseTime,
    'landlordListingsCount': landlordListingsCount,
    'images': images,
    'title': title,
    'description': description,
    'price': price,
    'currency': currency,
    'neighborhood': neighborhood,
    'landmark': landmark,
    'propertyType': propertyType,
    'bedrooms': bedrooms,
    'bathrooms': bathrooms,
    'hasWater': hasWater,
    'waterReliabilityScore': waterReliabilityScore,
    'hasElectricity': hasElectricity,
    'electricityStabilityScore': electricityStabilityScore,
    'hasParking': hasParking,
    'hasInternet': hasInternet,
    'internetQuality': internetQuality,
    'isFurnished': isFurnished,
    'isVerified': isVerified,
    'isPremium': isPremium,
    'roadAccessibility': roadAccessibility,
    'floodRisk': floodRisk,
    'securityLevel': securityLevel,
    'latitude': latitude,
    'longitude': longitude,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'isAvailable': isAvailable,
    'views': views,
    'favorites': favorites,
    'houseRules': houseRules,
    'status': status,
  };

  factory Property.fromMap(Map<String, dynamic> map, String id) => Property(
    id: id,
    landlordId: map['landlordId'] ?? '',
    landlordName: map['landlordName'] ?? '',
    landlordAvatar: map['landlordAvatar'] ?? '',
    landlordVerified: map['landlordVerified'] ?? false,
    landlordResponseTime: map['landlordResponseTime'] ?? 'Within 1 hour',
    landlordListingsCount: map['landlordListingsCount'] ?? 1,
    images: List<String>.from(map['images'] ?? []),
    title: map['title'] ?? '',
    description: map['description'] ?? '',
    price: (map['price'] ?? 0).toDouble(),
    currency: map['currency'] ?? 'XAF',
    neighborhood: map['neighborhood'] ?? '',
    landmark: map['landmark'] ?? '',
    propertyType: map['propertyType'] ?? '',
    bedrooms: map['bedrooms'] ?? 1,
    bathrooms: map['bathrooms'] ?? 1,
    hasWater: map['hasWater'] ?? false,
    waterReliabilityScore: map['waterReliabilityScore'] ?? 0,
    hasElectricity: map['hasElectricity'] ?? false,
    electricityStabilityScore: map['electricityStabilityScore'] ?? 0,
    hasParking: map['hasParking'] ?? false,
    hasInternet: map['hasInternet'] ?? false,
    internetQuality: map['internetQuality'] ?? 0,
    isFurnished: map['isFurnished'] ?? false,
    isVerified: map['isVerified'] ?? false,
    isPremium: map['isPremium'] ?? false,
    roadAccessibility: (map['roadAccessibility'] ?? 0).toDouble(),
    floodRisk: map['floodRisk'] ?? 0,
    securityLevel: map['securityLevel'] ?? 'Medium',
    latitude: (map['latitude'] ?? 0).toDouble(),
    longitude: (map['longitude'] ?? 0).toDouble(),
    createdAt: DateTime.tryParse(map['createdAt'] ?? ''),
    updatedAt: DateTime.tryParse(map['updatedAt'] ?? ''),
    isAvailable: map['isAvailable'] ?? true,
    views: map['views'] ?? 0,
    favorites: map['favorites'] ?? 0,
    houseRules: List<String>.from(map['houseRules'] ?? []),
    status: map['status'] ?? 'pending',
  );

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  String get formattedPrice {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}M';
    }
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}K';
    }
    return price.toStringAsFixed(0);
  }
}
