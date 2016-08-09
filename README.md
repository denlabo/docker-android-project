# Dockerfile for Android Projects

This is a Dockerfile to make images for Android projects.
No `ant`, `maven` are included.

## Included

* OpenJDK 8
* Android SDK
* Android NDK
* Android Support Libraries
* Google Play Services
* [fb-adb](https://github.com/facebook/fb-adb) command - A better shell for Android devices (by Facebook)

## Example

```
$ wget https://raw.githubusercontent.com/denlabo/dockerfile-android-project/master/Dockerfile
$ docker build --tag=android .
$ docker exec -it android /bin/bash
```

If necessary, you can also install the specific packages at build process.

```
$ docker build --tag=android \
  --build-arg ANDROID_COMPONENTS="platform-tools,build-tools-23.0.3,android-17,sys-img-armeabi-v7a-android-17" \
  --build-arg GOOGLE_COMPONENTS="extra-google-google_play_services" \
  .
```

# Maintainer

[denLabo LLC](http://denlabo.co.jp/)

# License

This project is forked version.
The [based version](https://github.com/gfx/docker-android-project) was authored by FUJI Goro and released under the MIT License
