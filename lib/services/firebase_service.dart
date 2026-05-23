import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  FirebaseApp? _app;
  FirebaseAuth? _auth;
  FirebaseFirestore? _firestore;
  FirebaseStorage? _storage;

  FirebaseAuth get auth => _auth!;
  FirebaseFirestore get firestore => _firestore!;
  FirebaseStorage get storage => _storage!;

  Future<void> initialize() async {
    _app = await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'YOUR_API_KEY',
        appId: 'YOUR_APP_ID',
        messagingSenderId: 'YOUR_SENDER_ID',
        projectId: 'YOUR_PROJECT_ID',
        authDomain: 'YOUR_AUTH_DOMAIN',
        storageBucket: 'YOUR_STORAGE_BUCKET',
      ),
    );
    _auth = FirebaseAuth.instanceFor(app: _app!);
    _firestore = FirebaseFirestore.instanceFor(app: _app!);
    _storage = FirebaseStorage.instanceFor(app: _app!);
  }

  Future<void> initializeWithOptions(FirebaseOptions options) async {
    _app = await Firebase.initializeApp(options: options);
    _auth = FirebaseAuth.instanceFor(app: _app!);
    _firestore = FirebaseFirestore.instanceFor(app: _app!);
    _storage = FirebaseStorage.instanceFor(app: _app!);
  }
}
