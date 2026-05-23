import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/subscription.dart';

class PaymentService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  PaymentService(this._firestore, this._auth);

  CollectionReference get _subscriptions => _firestore.collection('subscriptions');
  CollectionReference get _users => _firestore.collection('users');

  String get _currentUserId {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    return user.uid;
  }

  Future<Subscription> createSubscription({
    required String provider,
    required String phoneNumber,
    double amount = 5000,
    String currency = 'XAF',
  }) async {
    final docRef = _subscriptions.doc();
    final subscription = Subscription(
      id: docRef.id,
      userId: _currentUserId,
      provider: provider,
      phoneNumber: phoneNumber,
      amount: amount,
      currency: currency,
    );
    await docRef.set(subscription.toMap());
    return subscription;
  }

  Future<void> initiatePayment({
    required String subscriptionId,
    required String provider,
    required String phoneNumber,
  }) async {
    final doc = await _subscriptions.doc(subscriptionId).get();
    if (!doc.exists) throw Exception('Subscription not found');
    final data = doc.data() as Map<String, dynamic>;
    if (data['userId'] != _currentUserId) {
      throw Exception('Unauthorized: subscription does not belong to current user');
    }

    await _subscriptions.doc(subscriptionId).update({
      'provider': provider,
      'phoneNumber': phoneNumber,
      'status': 'processing',
    });
  }

  Future<void> confirmPayment(String subscriptionId) async {
    final doc = await _subscriptions.doc(subscriptionId).get();
    if (!doc.exists) throw Exception('Subscription not found');
    final data = doc.data() as Map<String, dynamic>;
    if (data['userId'] != _currentUserId) {
      throw Exception('Unauthorized: subscription does not belong to current user');
    }
    if (data['status'] != 'processing') {
      throw Exception('Invalid subscription state');
    }

    final now = DateTime.now();
    final expiresAt = now.add(const Duration(days: 30));

    await _subscriptions.doc(subscriptionId).update({
      'status': 'active',
      'confirmedAt': now.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
    });

    final userId = data['userId'];
    await _users.doc(userId).update({
      'isPremium': true,
      'premiumExpiry': expiresAt.toIso8601String(),
    });
  }

  Future<List<Subscription>> getUserSubscriptions() async {
    final snapshot = await _subscriptions
        .where('userId', isEqualTo: _currentUserId)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Subscription.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<Subscription?> getActiveSubscription() async {
    final snapshot = await _subscriptions
        .where('userId', isEqualTo: _currentUserId)
        .where('status', isEqualTo: 'active')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return Subscription.fromMap(
        snapshot.docs.first.data() as Map<String, dynamic>,
        snapshot.docs.first.id,
      );
    }
    return null;
  }
}
