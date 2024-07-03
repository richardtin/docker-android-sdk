FROM eclipse-temurin:17-jdk-jammy

RUN apt-get update -qqy && \
    apt-get install -qqy \
        lib32stdc++6 lib32z1 build-essential libcurl4-openssl-dev \
        libglu1-mesa libglu1-mesa-dev unzip && \
    rm -rf /var/lib/apt/lists/*

# Download and install Android Commandline Tools
ARG cmdline_tools=https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
ARG android_home=/opt/android/sdk

# SHA-256 bd1aa17c7ef10066949c88dc6c9c8d536be27f992a1f3b5a584f9bd2ba5646a0

RUN mkdir -p ${android_home}/cmdline-tools && \
    wget -O /tmp/cmdline-tools.zip -t 5 "${cmdline_tools}" && \
    unzip -q /tmp/cmdline-tools.zip -d ${android_home}/cmdline-tools && \
    mv ${android_home}/cmdline-tools/cmdline-tools ${android_home}/cmdline-tools/latest && \
    rm /tmp/cmdline-tools.zip

# Set environmental variables
ENV ANDROID_HOME ${android_home}
ENV ANDROID_SDK_ROOT ${android_home}
ENV ADB_INSTALL_TIMEOUT 120
ENV PATH ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}

RUN mkdir ~/.android && echo '### User Sources for Android SDK Manager' > ~/.android/repositories.cfg

RUN yes | sdkmanager --licenses && yes | sdkmanager --update

# Update SDK manager and install system image, platform and build tools
RUN sdkmanager \
    "emulator" \
    "platform-tools"

COPY ../rootfs /

WORKDIR /app
ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["./gradlew", "tasks"]
