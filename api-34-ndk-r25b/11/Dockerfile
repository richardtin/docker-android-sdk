FROM ghcr.io/richardtin/docker-android-sdk:jdk-11-api-34

# Update SDK manager and install system image, platform and build tools
RUN sdkmanager \
    "cmake;3.22.1" \
    "cmake;3.18.1" \
    "cmake;3.10.2.4988404" \
    "cmake;3.6.4111459"
RUN sdkmanager \
    "ndk;25.1.8937393"
