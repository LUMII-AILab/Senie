// `val`s in gradle DSL scripts are technically class properties, and thus trip naming convention checks.
// But in practice they're file-globals, and capitalization avoids conflicts with existing config properties.
@file:Suppress("PrivatePropertyName")

import org.jetbrains.kotlin.gradle.dsl.JvmDefaultMode
import org.jetbrains.kotlin.gradle.dsl.JvmTarget


private val GradleVersion = "9.0.0"
private val KotlinJvmTarget = JvmTarget.JVM_21
private val JavaJvmTarget = JavaVersion.VERSION_21

// The standard approach is `plugins { "name" version "version" }`, but this alias+apply way allows loading
// plugin definitions from `libs.versions.toml`, instead of manually repeating version numbers etc.
plugins {
    alias(libs.plugins.kotlin)
    alias(libs.plugins.sb)
    alias(libs.plugins.kotlinsb)
    alias(libs.plugins.kotlinnjpa)
}
apply(plugin = libs.plugins.kotlin.get().pluginId)
apply(plugin = libs.plugins.sb.get().pluginId)
apply(plugin = libs.plugins.kotlinsb.get().pluginId)
apply(plugin = libs.plugins.kotlinnjpa.get().pluginId)

dependencies {
    implementation(libs.kotlin.log)
    implementation(libs.kotlin.reflect)
    implementation(libs.sb.web)
    implementation(libs.sb.jpa)
    runtimeOnly(libs.mariadb)
}

tasks.bootJar {
    archiveFileName.set("app.jar")
}

tasks.wrapper { gradleVersion = GradleVersion }

java { targetCompatibility = JavaJvmTarget }

kotlin {
    compilerOptions {
        jvmTarget.set(KotlinJvmTarget)
        // This actually makes default methods more compatible with current JVMs, as the compatibility
        // refers to older (less JVM-compatible) versions of Kotlin.
        jvmDefault = JvmDefaultMode.NO_COMPATIBILITY
        // Enable guard conditions for when expressions
        freeCompilerArgs.add("-Xwhen-guards")
        // https://kotlinlang.org/docs/java-interop.html#jsr-305-support
        freeCompilerArgs.add("-Xjsr305=strict")
    }
}