FROM ruby:2.7.0

RUN set -ex \
  && apt-get update \
  && apt-get install -y --no-install-recommends xauth xvfb xfonts-100dpi xfonts-75dpi \
  xfonts-scalable xfonts-cyrillic qt5-default libqt5webkit5-dev \
  gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x libnss3 \
  unzip wget curl git imagemagick libmagickwand-dev libpq-dev cmake \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt/archives/*.deb

# Install Chrome
ARG CHROME_VERSION="google-chrome-stable"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
  ${CHROME_VERSION:-google-chrome-stable} \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY wrap_chrome_binary /opt/bin/wrap_chrome_binary
RUN /opt/bin/wrap_chrome_binary

ARG CHROME_DRIVER_VERSION="80.0.3987.106"
RUN CD_VERSION=$(if [ ${CHROME_DRIVER_VERSION:-latest} = "80.0.3987.106" ]; then echo $(wget -qO- https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION); else echo $CHROME_DRIVER_VERSION; fi) \
  && echo "Using chromedriver version: "$CD_VERSION \
  && wget --no-verbose -O /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CD_VERSION/chromedriver_linux64.zip \
  && rm -rf /opt/selenium/chromedriver \
  && unzip /tmp/chromedriver_linux64.zip -d /opt/selenium \
  && rm /tmp/chromedriver_linux64.zip \
  && mv /opt/selenium/chromedriver /opt/selenium/chromedriver-$CD_VERSION \
  && chmod 755 /opt/selenium/chromedriver-$CD_VERSION \
  && ln -fs /opt/selenium/chromedriver-$CD_VERSION /usr/bin/chromedriver

RUN curl -sL https://deb.nodesource.com/setup_8.x |  bash - 
RUN apt-get install nodejs -y
