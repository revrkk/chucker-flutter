import java.util.Properties
import java.util.Base64

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.reader(Charsets.UTF_8).use { reader ->
        localProperties.load(reader)
    }
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode") ?: "1"

android {

    compileSdk = 36
    ndkVersion = "27.0.12077973"
    namespace = "com.example.example"
    sourceSets["main"].java.srcDirs("src/main/kotlin")
    lint {
        disable.add("InvalidPackage")
    }
    compileOptions {
        isCoreLibraryDesugaringEnabled = true
    }
    java {
        toolchain {
            languageVersion.set(JavaLanguageVersion.of(21))
        }
    }
    defaultConfig {
        applicationId = "com.example.example"
        minSdk = 24
        targetSdk = 35
        versionCode = flutterVersionCode.toInt()
        versionName = "1.0"
        resValue("string", "app_name", "Chucker App")
    }
    // buildTypes {
    //     release {
    //         signingConfig = signingConfigs.debug
    //     }
    // }
}
kotlin {
    jvmToolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:2.1.0")
    implementation("com.google.android.gms:play-services-location:21.3.0")
    implementation("com.squareup.okhttp3:logging-interceptor:4.12.0")
}
