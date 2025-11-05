// `val`s in gradle DSL scripts are technically class properties, and thus trip naming convention checks.
// But in practice they're file-globals, and capitalization avoids conflicts with existing config properties.
@file:Suppress("PrivatePropertyName")

private val GradleVersion = "9.0.0"
private val JavaJvmTarget = JavaVersion.VERSION_21

plugins { java }

tasks.wrapper { gradleVersion = GradleVersion }
java { targetCompatibility = JavaJvmTarget }