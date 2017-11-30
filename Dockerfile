FROM ubuntu:16.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# make sure the package repository is up to date
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update
RUN apt-get install -y unzip wget curl git

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable


RUN /bin/bash -l -c rvm requirements
ENV PATH $PATH:/usr/local/rvm/bin
RUN source /usr/local/rvm/scripts/rvm
RUN rvm install 2.4.2
RUN echo "source /usr/local/rvm/scripts/rvm" >> /root/.bash_profile
RUN echo "rvm --default use 2.4.2" >> /root/.bash_profile

RUN/bin/bash -l -c	rvm --default use 2.2.3

RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
RUN tail -2 /root/.bashrc >> /root/.bash_profile
RUN /bin/bash -l -c	"nvm install 6.5.0"


RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN wget http://chromedriver.storage.googleapis.com/2.25/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN chmod +x chromedriver
RUN mv -f chromedriver /usr/local/share/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/bin/chromedriver


# Install vnc, xvfb in order to create a 'fake' display and firefox
RUN apt-get install -y --allow-unauthenticated google-chrome-stable
RUN apt-get install -y x11vnc xvfb

RUN mkdir ~/.vnc
# Setup a password
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd


ENV DISPLAY :99

# Install Xvfb init script

ADD xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb
ADD xvfb-daemon-run /usr/bin/xvfb-daemon-run
RUN chmod a+x /usr/bin/xvfb-daemon-run

# Allow root to execute Google Chrome by replacing launch script
ADD google-chrome-launcher /usr/bin/google-chrome
RUN chmod a+x /usr/bin/google-chrome

RUN apt-get install -y python python-pip
RUN apt-get install -y lsb-release apt-transport-https

RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-xenial main" > /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update
RUN apt-get install -y google-cloud-sdk google-cloud-sdk-app-engine-python

RUN pip install virtualenv
RUN virtualenv venv
RUN ln -s /venv /root/venv
RUN echo "done"
ENTRYPOINT /bin/bash -l
