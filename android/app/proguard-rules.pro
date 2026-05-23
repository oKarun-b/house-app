# HouseApp ProGuard Rules
-keep class com.houseapp.** { *; }
-keep class com.google.firebase.** { *; }
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
-dontwarn com.google.firebase.**
