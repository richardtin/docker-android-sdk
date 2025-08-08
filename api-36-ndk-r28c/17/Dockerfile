FROM ghcr.io/richardtin/docker-android-sdk:jdk-17-api-36

# Update SDK manager and install system image, platform and build tools
RUN sdkmanager \
    "cmake;3.22.1" \
    "cmake;3.18.1" \
    "cmake;3.10.2.4988404"
RUN sdkmanager \
    "ndk;28.2.13676358"
