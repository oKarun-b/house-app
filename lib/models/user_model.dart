class AppUser {
  final String uid;
  final String phoneNumber;
  final String? email;
  final String displayName;
  final String? photoUrl;
  final String role;
  final bool isVerified;
  final bool isPremium;
  final DateTime? premiumExpiry;
  final DateTime createdAt;
  final List<String> savedProperties;
  final List<String> contactHistory;
  final List<String> viewedProperties;
  final String language;
  final bool notificationsEnabled;
  final bool darkMode;
  final int listingCount;
  final bool isBlocked;
  final String? fcmToken;

  AppUser({
    required this.uid,
    required this.phoneNumber,
    this.email,
    this.displayName = '',
    this.photoUrl,
    this.role = 'tenant',
    this.isVerified = false,
    this.isPremium = false,
    this.premiumExpiry,
    DateTime? createdAt,
    this.savedProperties = const [],
    this.contactHistory = const [],
    this.viewedProperties = const [],
    this.language = 'en',
    this.notificationsEnabled = true,
    this.darkMode = false,
    this.listingCount = 0,
    this.isBlocked = false,
    this.fcmToken,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'phoneNumber': phoneNumber,
    'email': email,
    'displayName': displayName,
    'photoUrl': photoUrl,
    'role': role,
    'isVerified': isVerified,
    'isPremium': isPremium,
    'premiumExpiry': premiumExpiry?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'savedProperties': savedProperties,
    'contactHistory': contactHistory,
    'viewedProperties': viewedProperties,
    'language': language,
    'notificationsEnabled': notificationsEnabled,
    'darkMode': darkMode,
    'listingCount': listingCount,
    'isBlocked': isBlocked,
    'fcmToken': fcmToken,
  };

  factory AppUser.fromMap(Map<String, dynamic> map, String uid) => AppUser(
    uid: uid,
    phoneNumber: map['phoneNumber'] ?? '',
    email: map['email'],
    displayName: map['displayName'] ?? '',
    photoUrl: map['photoUrl'],
    role: map['role'] ?? 'tenant',
    isVerified: map['isVerified'] ?? false,
    isPremium: map['isPremium'] ?? false,
    premiumExpiry: map['premiumExpiry'] != null ? DateTime.tryParse(map['premiumExpiry']) : null,
    createdAt: DateTime.tryParse(map['createdAt'] ?? ''),
    savedProperties: List<String>.from(map['savedProperties'] ?? []),
    contactHistory: List<String>.from(map['contactHistory'] ?? []),
    viewedProperties: List<String>.from(map['viewedProperties'] ?? []),
    language: map['language'] ?? 'en',
    notificationsEnabled: map['notificationsEnabled'] ?? true,
    darkMode: map['darkMode'] ?? false,
    listingCount: map['listingCount'] ?? 0,
    isBlocked: map['isBlocked'] ?? false,
    fcmToken: map['fcmToken'],
  );

  bool get isPremiumActive {
    if (!isPremium || premiumExpiry == null) return false;
    return premiumExpiry!.isAfter(DateTime.now());
  }
}
