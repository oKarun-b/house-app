import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthService(this._auth, this._firestore);

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  String? get currentUserId => _auth.currentUser?.uid;

  static const Set<String> _allowedUserUpdateFields = {
    'displayName', 'phoneNumber', 'photoUrl', 'language',
    'notificationsEnabled', 'darkMode', 'fcmToken',
  };

  static const Set<String> _allowedPropertyUpdateFields = {
    'title', 'description', 'price', 'images', 'neighborhood',
    'isAvailable', 'waterReliabilityScore', 'electricityStabilityScore',
    'propertyType', 'bedrooms', 'bathrooms', 'hasWater', 'hasElectricity',
    'hasParking', 'hasInternet', 'isFurnished', 'roadAccessibility',
    'floodRisk', 'securityLevel',
  };

  Future<void> sendOtp(
    String phoneNumber,
    PhoneVerificationCompleted onCompleted,
    PhoneVerificationFailed onFailed,
    PhoneCodeSent onCodeSent, {
    int? forceResendingToken,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onCompleted,
      verificationFailed: onFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: forceResendingToken,
    );
  }

  Future<UserCredential> verifyOtp(String verificationId, String smsCode) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return await _auth.signInWithCredential(credential);
  }

  Future<void> createUserProfile(AppUser user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<AppUser?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return AppUser.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    final filtered = Map<String, dynamic>.fromEntries(
      data.entries.where((e) => _allowedUserUpdateFields.contains(e.key)),
    );
    if (filtered.isEmpty) return;
    await _firestore.collection('users').doc(uid).update(filtered);
  }

  Future<void> updateProperty(String docId, Map<String, dynamic> data) async {
    final filtered = Map<String, dynamic>.fromEntries(
      data.entries.where((e) => _allowedPropertyUpdateFields.contains(e.key)),
    );
    if (filtered.isEmpty) return;
    await _firestore.collection('properties').doc(docId).update(filtered);
  }

  Future<AppUser> getOrCreateUser(User firebaseUser, String role) async {
    final existing = await getUserProfile(firebaseUser.uid);
    if (existing != null) {
      return existing;
    }
    final newUser = AppUser(
      uid: firebaseUser.uid,
      phoneNumber: firebaseUser.phoneNumber ?? '',
      displayName: firebaseUser.phoneNumber ?? 'User',
      role: role,
    );
    await createUserProfile(newUser);
    return newUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
