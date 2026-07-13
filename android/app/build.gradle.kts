import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

fun requiredKeystoreValue(name: String): String {
    return keystoreProperties.getProperty(name)
        ?: throw GradleException(
            "Missing '$name' in android/key.properties"
        )
}

android {
    namespace = "com.waterhero.hydrationtracker"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.waterhero.hydrationtracker"

        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            if (!keystorePropertiesFile.exists()) {
                throw GradleException(
                    "Missing android/key.properties file"
                )
            }

            keyAlias = requiredKeystoreValue("keyAlias")
            keyPassword = requiredKeystoreValue("keyPassword")
            storePassword = requiredKeystoreValue("storePassword")

            val releaseKeystore = file(
                requiredKeystoreValue("storeFile")
            )

            if (!releaseKeystore.exists()) {
                throw GradleException(
                    "Keystore file not found: ${releaseKeystore.absolutePath}"
                )
            }

            storeFile = releaseKeystore
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}