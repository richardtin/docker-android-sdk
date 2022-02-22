FROM openjdk:11-jdk-buster

RUN apt-get update -qqy && \
    apt-get install -qqy \
        lib32stdc++6 lib32z1 build-essential libcurl4-openssl-dev \
        libglu1-mesa libglu1-mesa-dev && \
    rm -rf /var/lib/apt/lists/*

# Download and install Android Commandline Tools
ARG cmdline_tools=https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip
ARG android_home=/opt/android/sdk

# SHA-256 d71f75333d79c9c6ef5c39d3456c6c58c613de30e6a751ea0dbd433e8f8b9cbf

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
    "platform-tools" \
    "patcher;v4"

COPY rootfs /

WORKDIR /app
ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["./gradlew", "tasks"]
