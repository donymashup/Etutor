# Add project specific ProGuard rules here.

# Razorpay ProGuard Rules
-dontwarn proguard.annotation.**
-keep class proguard.annotation.** { *; }
-keepattributes *Annotation*

# Keep Razorpay classes
-keepclassmembers class * {
    @proguard.annotation.Keep *;
    @proguard.annotation.KeepClassMembers *;
}

-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Additional rules
-keepattributes Signature
-keepattributes Exceptions
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# OkHttp
-dontwarn okhttp3.**
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okio.**

# Retrofit
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}

# Gson
-keep class com.google.gson.** { *; }
-keep class sun.misc.Unsafe { *; }
-keepattributes Signature
-keepattributes *Annotation*

-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep all classes that might be used via reflection
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# ===== FLUTTER APP SPECIFIC RULES =====

# Keep all your model classes - CRITICAL FOR YOUR APP
-keep class com.example.etutor.features.home.model.** { *; }
-keep class com.example.etutor.features.auth.model.** { *; }
-keep class com.example.etutor.features.subscribed_course.model.** { *; }
-keep class com.example.etutor.features.my_course.model.** { *; }
-keep class com.example.etutor.features.notification.model.** { *; }
-keep class com.example.etutor.features.profile.model.** { *; }
-keep class com.example.etutor.features.**.model.** { *; }

# Keep all model fields and methods
-keepclassmembers class com.example.etutor.features.**.model.** {
    *;
}

# If using json_serializable (generated .g.dart files)
-keep class **.g.dart { *; }
-keep class **$*.g.dart { *; }

# Keep data classes used in API responses
-keep class * {
    <init>(...);
    @com.google.gson.annotations.SerializedName <fields>;
}

# Keep constructors
-keepclassmembers class * {
    public <init>(...);
}

# Keep names for debugging (optional, increases APK size slightly)
-keepnames class com.example.etutor.features.**.model.**

# Prevent stripping of generic type information
-keepattributes RuntimeVisibleAnnotations
-keepattributes RuntimeInvisibleAnnotations
-keepattributes RuntimeVisibleParameterAnnotations
-keepattributes RuntimeInvisibleParameterAnnotations

# ===== FLUTTER SPECIFIC =====

# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Google Play Core (Fix for missing classes)
-keep class com.google.android.play.core.** { *; }
-keep interface com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Flutter Play Store Split
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }

# Keep cached_network_image
-keep class com.example.cached_network_image.** { *; }

# Keep provider classes
-keep class androidx.lifecycle.** { *; }
-dontwarn androidx.lifecycle.**

# ===== DEBUGGING (Remove after fixing) =====
# Uncomment these lines to see what's being stripped
# -printconfiguration proguard-config.txt
# -printusage proguard-usage.txt
# -whyareyoukeeping class com.yourpackage.etutor.features.home.model.**