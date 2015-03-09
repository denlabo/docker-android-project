# based on https://registry.hub.docker.com/u/samtstern/android-sdk/dockerfile/ with openjdk-8
FROM java:8

MAINTAINER FUJI Goro <g.psy.va@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Dependencies
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -yq libstdc++6:i386 zlib1g:i386 libncurses5:i386 ant maven --no-install-recommends
RUN tar --version && curl --version

# Download and untar SDK
ENV ANDROID_SDK_URL http://dl.google.com/android/android-sdk_r24.1.2-linux.tgz
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANDROID_SDK /usr/local/android-sdk-linux

# Install Android SDK components
ENV ANDROID_SDK_COMPONENTS platform-tools,build-tools-21.1.2,android-21,extra-android-support
RUN echo y | ${ANDROID_HOME}/tools/android update sdk --no-ui --all --filter "${ANDROID_SDK_COMPONENTS}"

# Path
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

# Android project support

ENV TERM dumb
ENV JAVA_OPTS -Xms256m -Xmx512m
