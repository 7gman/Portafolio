# Imagen base con el SDK de Flutter y Android
FROM ubuntu:22.04

USER root

# Variables de versiones
    #7583922
ENV ANDROID_SDK_TOOLS_VERSION=7583922
    #3.7.12
ENV FLUTTER_VERSION=3.7.12
    #7.3
ENV GRADLE_VERSION=7.3.3
    #4.8.0.2856
ENV SONAR_SCANNER_VERSION=4.8.0.2856
    # Variables de entorno para configurar JAVA
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/
    # Variables de entorno para configurar el SDK de Android
ENV ANDROID_HOME=/opt/android/sdk
ENV ANDROID_SDK_ROOT=$ANDROID_HOME
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools:${ANDROID_HOME}/emulator:/opt/sonar-scanner/bin:/opt/gradle/bin:/opt/flutter/bin:$JAVA_HOME/bin

# Crear la variable de entorno NODE_TLS_REJECT_UNAUTHORIZED
ENV NODE_TLS_REJECT_UNAUTHORIZED=0

# Crear el directorio para el SDK de Android
RUN mkdir /opt/android
RUN mkdir /opt/android/sdk
 
# Instalar los paquetes necesarios
RUN set -o xtrace  \
    && cd /opt  \
    && apt-get update  \
    && apt-get install -y jq \
    && apt-get install -y openjdk-17-jdk \
    && apt-get install -y python3-pip \
    && pip3 install requests \
    && apt-get install -y sudo wget zip unzip git openssh-client curl bc software-properties-common build-essential ruby-full ruby-bundler libstdc++6 libpulse0 libglu1-mesa locales lcov libsqlite3-dev --no-install-recommends \
    # for x86 emulators
    && apt-get install -y libxtst6 libnss3-dev libnspr4 libxss1 libasound2 libatk-bridge2.0-0 libgtk-3-0 libgdk-pixbuf2.0-0 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean 

RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip && \
    unzip -q commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip -d ${ANDROID_HOME}/cmdline-tools/ && \
    mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/tools && \
    chown -R root:root $ANDROID_HOME && \
    rm commandlinetools-linux-${ANDROID_SDK_TOOLS_VERSION}_latest.zip && \ 
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0" "cmdline-tools;latest"

RUN wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz && \
    tar -xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz -C /opt && \
    chown -R root:root /opt/flutter && \
    rm flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
    
RUN wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip -q gradle-${GRADLE_VERSION}-bin.zip -d /opt && \
    mv /opt/gradle-${GRADLE_VERSION} /opt/gradle && \
    rm gradle-${GRADLE_VERSION}-bin.zip
    
RUN wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    mv sonar-scanner-${SONAR_SCANNER_VERSION}-linux /opt/sonar-scanner && \
    rm sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip
 
# Habilitar licencias de Android
RUN yes | flutter doctor --android-licenses \
    && flutter doctor \
    && flutter precache --android

# Permisos sobre directorios
RUN git config --global --add safe.directory /opt/flutter
# Los siguientes permisos de abajo no se puedieron asignar en el Dockerfile dado que el usario no existe, pero ese usuario (xxx_tfs_build_azpcontainer) 
# es el que automáticamente se crea y se utiliza en el azure pipeline.
#-----------------------------------------------------------------------
#    && sudo chown -R xxx_tfs_build_azpcontainer /opt/flutter \
#    && sudo chown -R xxx_tfs_build_azpcontainer /opt/flutter