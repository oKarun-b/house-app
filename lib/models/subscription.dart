class Subscription {
  final String id;
  final String userId;
  final String provider;
  final String phoneNumber;
  final double amount;
  final String currency;
  final String status;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? expiresAt;
  final String? transactionId;

  Subscription({
    required this.id,
    required this.userId,
    this.provider = '',
    this.phoneNumber = '',
    this.amount = 5000,
    this.currency = 'XAF',
    this.status = 'pending',
    DateTime? createdAt,
    this.confirmedAt,
    this.expiresAt,
    this.transactionId,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'provider': provider,
    'phoneNumber': phoneNumber,
    'amount': amount,
    'currency': currency,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'confirmedAt': confirmedAt?.toIso8601String(),
    'expiresAt': expiresAt?.toIso8601String(),
    'transactionId': transactionId,
  };

  factory Subscription.fromMap(Map<String, dynamic> map, String id) => Subscription(
    id: id,
    userId: map['userId'] ?? '',
    provider: map['provider'] ?? '',
    phoneNumber: map['phoneNumber'] ?? '',
    amount: (map['amount'] ?? 5000).toDouble(),
    currency: map['currency'] ?? 'XAF',
    status: map['status'] ?? 'pending',
    createdAt: DateTime.tryParse(map['createdAt'] ?? ''),
    confirmedAt: map['confirmedAt'] != null ? DateTime.tryParse(map['confirmedAt']) : null,
    expiresAt: map['expiresAt'] != null ? DateTime.tryParse(map['expiresAt']) : null,
    transactionId: map['transactionId'],
  );
}
