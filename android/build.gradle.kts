allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Configure build directory
rootProject.layout.buildDirectory = layout.buildDirectory.dir("../build")

// Clean up subprojects configuration
subprojects {
    afterEvaluate {
        if (hasProperty("android")) {
            extensions.configure<com.android.build.gradle.BaseExtension>("android") {
                if (namespace == null) {
                    namespace = project.group?.toString()
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}