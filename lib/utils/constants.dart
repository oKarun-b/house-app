import 'package:flutter/material.dart';

class AppColors {
  static const Color deepGreen = Color(0xFF0F6B4B);
  static const Color deepGreenDark = Color(0xFF0A4F37);
  static const Color deepGreenLight = Color(0xFF1A8F62);
  static const Color gold = Color(0xFFFFD700);
  static const Color goldLight = Color(0xFFFFE44D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8F9FA);
  static const Color backgroundLight = Color(0xFFF2F4F6);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2C2C2C);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFF59E0B);
  static const Color verified = Color(0xFF0F6B4B);
  static const Color unverified = Color(0xFF9CA3AF);
  static const Color premiumGlow = Color(0x33FFD700);
  static const Color glassBg = Color(0xCCFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);
  static const Color overlay = Color(0x80000000);
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
}

class AppTypography {
  static const String fontFamily = 'Poppins';

  static const TextStyle headline1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle price = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.deepGreen,
  );

  static const TextStyle goldPrice = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.gold,
  );
}

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppRadius {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double full = 999;
}

class AppStrings {
  static const String appName = 'HouseApp';
  static const String tagline = 'Find Your Next Home Easily';
  static const String subTagline = 'Verified houses and direct landlord contacts';
  static const String continueAsTenant = 'Continue as Tenant';
  static const String continueAsLandlord = 'Continue as Landlord';
  static const String searchHint = 'Search neighborhoods, landmarks, apartments...';
  static const String premiumContact = 'Unlock landlord contacts for 5,000 XAF/month';
  static const String subscribe = 'Subscribe Now';
  static const String mtn = 'MTN Mobile Money';
  static const String orange = 'Orange Money';
  static const String noResults = 'No results found';
  static const String emptyFavorites = 'Save your dream homes here';
  static const String emptyMessages = 'No messages yet';
  static const String emptyListings = 'No listings available';
  static const String verifyAccount = 'Verify your account';
  static const String enterPhone = 'Enter your phone number';
  static const String enterOtp = 'Enter verification code';
  static const String resendOtp = 'Resend code';
  static const String terms = 'Terms & Conditions';
  static const String privacy = 'Privacy Policy';
  static const String language = 'Language';
  static const String logout = 'Logout';
  static const String settings = 'Settings';
  static const String profile = 'Profile';
  static const String myListings = 'My Listings';
  static const String paymentHistory = 'Payment History';
  static const String subscription = 'Subscription';
  static const String favorites = 'Favorites';
  static const String messages = 'Messages';
  static const String admin = 'Admin';
  static const String approve = 'Approve';
  static const String reject = 'Reject';
  static const String analytics = 'Analytics';
  static const String revenue = 'Revenue';
}
