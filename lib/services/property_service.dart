import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/property.dart';

class PropertyService {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  PropertyService(this._firestore, this._storage);

  CollectionReference get _properties => _firestore.collection('properties');

  Future<List<Property>> getProperties({
    String? type,
    String? neighborhood,
    double? maxPrice,
    double? minPrice,
    bool? furnished,
    bool? hasWater,
    bool? hasElectricity,
    String? sortBy,
    String? status,
  }) async {
    Query query = _properties;

    if (status != null) {
      query = query.where('status', isEqualTo: status);
    } else {
      query = query.where('status', isEqualTo: 'approved');
    }

    query = query.where('isAvailable', isEqualTo: true);

    if (type != null && type.isNotEmpty) {
      query = query.where('propertyType', isEqualTo: type);
    }

    if (neighborhood != null && neighborhood.isNotEmpty) {
      query = query.where('neighborhood', isEqualTo: neighborhood);
    }

    if (furnished != null) {
      query = query.where('isFurnished', isEqualTo: furnished);
    }

    if (hasWater != null) {
      query = query.where('hasWater', isEqualTo: hasWater);
    }

    if (hasElectricity != null) {
      query = query.where('hasElectricity', isEqualTo: hasElectricity);
    }

    if (sortBy == 'price_asc') {
      query = query.orderBy('price', descending: false);
    } else if (sortBy == 'price_desc') {
      query = query.orderBy('price', descending: true);
    } else if (sortBy == 'newest') {
      query = query.orderBy('createdAt', descending: true);
    } else if (sortBy == 'popular') {
      query = query.orderBy('views', descending: true);
    } else {
      query = query.orderBy('createdAt', descending: true);
    }

    final snapshot = await query.get();
    var properties = snapshot.docs
        .map((doc) => Property.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    if (maxPrice != null) {
      properties = properties.where((p) => p.price <= maxPrice).toList();
    }
    if (minPrice != null) {
      properties = properties.where((p) => p.price >= minPrice).toList();
    }

    return properties;
  }

  Future<Property?> getPropertyById(String id) async {
    final doc = await _properties.doc(id).get();
    if (doc.exists) {
      return Property.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Future<void> addProperty(Property property) async {
    await _properties.doc(property.id).set(property.toMap());
  }

  Future<void> updateProperty(String id, Map<String, dynamic> data) async {
    await _properties.doc(id).update(data);
  }

  Future<void> deleteProperty(String id) async {
    await _properties.doc(id).delete();
  }

  Future<List<Property>> getLandlordProperties(String landlordId) async {
    final snapshot = await _properties
        .where('landlordId', isEqualTo: landlordId)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Property.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<List<Property>> getSavedProperties(List<String> ids) async {
    if (ids.isEmpty) return [];
    final snapshot = await _properties.where(FieldPath.documentId, whereIn: ids).get();
    return snapshot.docs
        .map((doc) => Property.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<List<Property>> getPendingProperties() async {
    final snapshot = await _properties
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Property.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<QuerySnapshot> searchProperties(String query) async {
    final snapshot = await _properties
        .where('status', isEqualTo: 'approved')
        .where('isAvailable', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(20)
        .get();
    return snapshot;
  }

  Future<void> incrementViews(String id) async {
    await _properties.doc(id).update({'views': FieldValue.increment(1)});
  }

  Future<void> incrementFavorites(String id) async {
    await _properties.doc(id).update({'favorites': FieldValue.increment(1)});
  }

  Future<String> uploadImage(String filePath, String fileName) async {
    final ref = _storage.ref().child('properties/$fileName');
    final task = await ref.putString(filePath);
    if (task.state == TaskState.success) {
      return await ref.getDownloadURL();
    }
    throw Exception('Failed to upload image');
  }
}
