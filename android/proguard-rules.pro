-dontwarn com.stripe.**
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider

-keep class com.pierfrancescosoffritti.** { *; }
-keep class com.google.android.youtube.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.android.exoplayer2.** { *; }

# --- Keep YouTube player classes ---
-keep class com.pierfrancescosoffritti.androidyoutubeplayer.** { *; }
-dontwarn com.pierfrancescosoffritti.androidyoutubeplayer.**

# --- Keep Flutter plugin classes (general) ---
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.plugins.**

# --- Keep video player classes ---
-keep class com.google.android.exoplayer2.** { *; }
-dontwarn com.google.android.exoplayer2.**

# --- Prevent stripping reflection-dependent components ---
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}