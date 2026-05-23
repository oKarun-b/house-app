import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/property.dart';

class AppProvider extends ChangeNotifier {
  AppUser? _currentUser;
  bool _isLoading = false;
  bool _isDarkMode = false;
  String _locale = 'en';
  List<Property> _properties = [];
  List<Property> _favorites = [];
  List<String> _recentSearches = [];
  int _currentBottomNavIndex = 0;
  bool _isPremium = false;

  AppUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isDarkMode => _isDarkMode;
  String get locale => _locale;
  List<Property> get properties => _properties;
  List<Property> get favorites => _favorites;
  List<String> get recentSearches => _recentSearches;
  int get currentBottomNavIndex => _currentBottomNavIndex;
  bool get isPremium => _isPremium;

  void setUser(AppUser user) {
    _currentUser = user;
    _isPremium = user.isPremiumActive;
    notifyListeners();
  }

  void clearUser() {
    _currentUser = null;
    _isPremium = false;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setLocale(String locale) {
    _locale = locale;
    notifyListeners();
  }

  void setBottomNavIndex(int index) {
    _currentBottomNavIndex = index;
    notifyListeners();
  }

  void setProperties(List<Property> properties) {
    _properties = properties;
    notifyListeners();
  }

  void addProperties(List<Property> properties) {
    _properties.addAll(properties);
    notifyListeners();
  }

  void toggleFavorite(Property property) {
    if (_favorites.any((p) => p.id == property.id)) {
      _favorites.removeWhere((p) => p.id == property.id);
    } else {
      _favorites.add(property);
    }
    notifyListeners();
  }

  bool isFavorite(String propertyId) {
    return _favorites.any((p) => p.id == propertyId);
  }

  void addRecentSearch(String search) {
    _recentSearches.remove(search);
    _recentSearches.insert(0, search);
    if (_recentSearches.length > 10) {
      _recentSearches = _recentSearches.sublist(0, 10);
    }
    notifyListeners();
  }

  void setPremium(bool value) {
    _isPremium = value;
    notifyListeners();
  }
}
