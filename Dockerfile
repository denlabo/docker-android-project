FROM java:8

MAINTAINER denLabo LLC
# NOTE: This Dockerfile is forked version of https://github.com/gfx/docker-android-project

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -yq libc6:i386 libstdc++6:i386 zlib1g:i386 libncurses5:i386 \
		build-essential g++ unzip vim-common --no-install-recommends && \
    apt-get clean

# Download and untar Android SDK
ENV ANDROID_SDK_URL http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN curl -L "${ANDROID_SDK_URL}" | tar --no-same-owner -xz -C /usr/local
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANDROID_SDK /usr/local/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

# Download and untar Android NDK -- This may take a few minutes
ENV ANDROID_NDK_URL http://dl.google.com/android/ndk/android-ndk-r9b-linux-x86.tar.bz2
RUN curl -L "${ANDROID_NDK_URL}" | tar --no-same-owner -jx -C /usr/local
ENV ANDROID_NDK /usr/local/android-ndk-r9b

# Install fb-adb command
ENV FB_ADB_URL https://github.com/facebook/fb-adb/releases/download/1.4.4/fb-adb-1.4.4.tar.gz
RUN curl -L "${FB_ADB_URL}" | tar --no-same-owner -xz -C /usr/local
RUN cd /usr/local/fb-adb-1.4.4/ && mkdir build && cd build/ && ../configure && make && \
	cp ./fb-adb /usr/local/bin/ && chmod u+x /usr/local/bin/fb-adb && rm -rf /usr/local/fb-adb-1.4.4/

# Install Android SDK components
ARG ANDROID_COMPONENTS="platform-tools,build-tools-23.0.3,build-tools-24.0.0,android-23,android-24"
ARG GOOGLE_COMPONENTS="extra-android-m2repository,extra-google-m2repository"
RUN echo y | android update sdk --no-ui --all --filter "${ANDROID_COMPONENTS}" ; \
    echo y | android update sdk --no-ui --all --filter "${GOOGLE_COMPONENTS}"

# Support Gradle
ENV TERM dumb
