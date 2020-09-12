TEMPLATE = app

QT += qml quick multimedia multimediawidgets svg
CONFIG += c++11

SOURCES += main.cpp \
    qrccache.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    images.txt \
    packaging.txt

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    qrccache.h

ANDROID_ABIS = armeabi-v7a

