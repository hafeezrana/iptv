import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Load local.properties
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use { localProperties.load(it) }
}

android {
    namespace = "com.iptv.azul"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    // sourceSets {
    //     getByName("main") {
    //         java.srcDirs("src/main/kotlin")
    //     }
    // }

    defaultConfig {
        applicationId = "com.iptv.azul"
        minSdk = 25
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
            // Use debug signing config unless a release one is specified
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // Uncomment and configure when you have a release keystore
    /*
    signingConfigs {
        create("release") {
            keyAlias = localProperties["keyAlias"] as String?
            keyPassword = localProperties["keyPassword"] as String?
            storeFile = localProperties["storeFile"]?.let { file(it as String) }
            storePassword = localProperties["storePassword"] as String?
        }
    }
    */
}

dependencies {
    // Use AndroidX MultiDex instead of legacy support library
    implementation("androidx.multidex:multidex:2.0.1")
    implementation("com.google.android.ump:user-messaging-platform:2.2.0")
    
    // Updated ExoPlayer dependencies (use Media3 for newer versions)
    implementation("androidx.media3:media3-exoplayer:1.2.1")
    implementation("androidx.media3:media3-ui:1.2.1")
    implementation("androidx.media3:media3-exoplayer-smoothstreaming:1.2.1")
    
    // Alternative: If you want to stick with ExoPlayer 2.x
    // implementation("com.google.android.exoplayer:exoplayer-ui:2.19.1")
    // implementation("com.google.android.exoplayer:exoplayer-smoothstreaming:2.19.1")
}