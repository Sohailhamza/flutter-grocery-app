import com.android.build.gradle.BaseExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    plugins.withId("com.android.application") {
        configureAndroidBlock(this@subprojects)
    }
    plugins.withId("com.android.library") {
        configureAndroidBlock(this@subprojects)
    }
}

fun configureAndroidBlock(project: Project) {
    val android = project.extensions.findByType(BaseExtension::class.java)
    android?.apply {
        compileSdkVersion(34)
        buildToolsVersion("34.0.0")
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}