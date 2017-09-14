FROM openjdk:8-jdk as base 
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1

FROM base as cleanSdk
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip
#COPY sdk-tools-linux-3859397.zip ./android-sdk.zip
RUN unzip -q android-sdk.zip -d android-sdk
RUN android-sdk/tools/bin/sdkmanager --licenses

FROM cleanSdk
MAINTAINER Hanat <fibritso@gmail.com>
RUN echo "y" | android-sdk/tools/bin/sdkmanager "tools" 
RUN echo "y" | android-sdk/tools/bin/sdkmanager "platform-tools" 
RUN echo "y" | android-sdk/tools/bin/sdkmanager "platforms;android-26" 
RUN echo "y" | android-sdk/tools/bin/sdkmanager "platforms;android-25" 
RUN echo "y" | android-sdk/tools/bin/sdkmanager "build-tools;26.0.1" 
RUN echo "y" | android-sdk/tools/bin/sdkmanager "build-tools;25.0.0" 
RUN echo "y" | android-sdk/tools/bin/sdkmanager "extras;android;gapid;3" 
RUN echo "y" | android-sdk/tools/bin/sdkmanager "extras;android;m2repository" 
RUN echo "y" | android-sdk/tools/bin/sdkmanager "extras;google;auto"
RUN echo "y" | android-sdk/tools/bin/sdkmanager "extras;google;instantapps"
RUN echo "y" | android-sdk/tools/bin/sdkmanager "extras;google;google_play_services"
RUN echo "y" | android-sdk/tools/bin/sdkmanager "extras;google;m2repository"
RUN echo "y" | android-sdk/tools/bin/sdkmanager "extras;google;market_apk_expansion"
RUN echo "y" | android-sdk/tools/bin/sdkmanager "extras;google;market_licensing" 
RUN echo "y" | android-sdk/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2"
RUN echo "y" | android-sdk/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" 


#RUN echo y | android-sdk/tools/bin/sdkmanager "platform-tools"
#RUN echo y | android-sdk/tools/bin/sdkmanager "tools"
#RUN echo y | android-sdk/tools/bin/sdkmanager "platforms;android-26"
#RUN echo y | android-sdk/tools/bin/sdkmanager "build-tools;26.0.2"
#RUN echo y | android-sdk/tools/bin/sdkmanager "extras;android;gapid;3" "extras;android;m2repository" "extras;google;auto" "extras;google;instantapps"
#RUN echo y | android-sdk/tools/bin/sdkmanager "extras;google;google_play_services" "extras;google;m2repository" "extras;google;market_apk_expansion"
#RUN echo y | android-sdk/tools/bin/sdkmanager "extras;google;market_licensing"

RUN export ANDROID_HOME=$(pwd)/android-sdk
RUN export PATH=$PATH:$(pwd)/android-sdk/platform-tools/
