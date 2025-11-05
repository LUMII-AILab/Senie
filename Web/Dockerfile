FROM gradle:9.0.0-jdk21-alpine

WORKDIR /app/src

COPY ["*.kts", "./"]
COPY ["gradle/libs*", "gradle/"]
# Dummy build with just build config (no source code) to trigger dependency downloads. Doing this in a
# separate step from the actual build enables Docker to cache the results and not re-download on every source
# code change (only build config changes will invalidate the cache and trigger a re-run of this step).
RUN gradle build --info || return 0

# Build the app
COPY ["src/", "src/"]
RUN gradle bootJar --info

# Put the app in the proper dir and clean up the sources.
WORKDIR /app
RUN mv src/build/libs/app.jar app.jar \
 && rm -rf /src

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
