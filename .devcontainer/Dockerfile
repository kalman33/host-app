FROM ubuntu:focal

# VARIABLES
ARG NODEJS_VERSION="16"
ARG LOMBOK_VERSION="1.18.12"
ARG USERNAME=node
ARG USER_UID=1000
ARG USER_GID=1000

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY
ENV http_proxy=${HTTP_PROXY}
ENV https_proxy=${HTTPS_PROXY}
ENV no_proxy=${NO_PROXY}

ARG HTTP_PROXY_FORMATION

# Prerequisites
## user non root
# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y \
       openjdk-11-jdk \
       git \
       bzip2 \
       curl \
       unzip \
       wget \
       sudo \
       locales \
       vim \
       docker

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV JAVA_HOME='/usr/lib/jvm/java-1.11.0-openjdk-amd64'
ENV PATH=${JAVA_HOME}/bin:${PATH}:${M2_HOME}/bin

# Node
RUN curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
    && apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y nodejs

# Lombok
RUN wget https://projectlombok.org/downloads/lombok-${LOMBOK_VERSION}.jar -O /home/node/lombok.jar

# Persist bash history between runs
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && mkdir /commandhistory \
    && touch /commandhistory/.bash_history \
    && chown -R $USERNAME /commandhistory \
    && echo $SNIPPET >> "/home/$USERNAME/.bashrc"

# Installation de Chrome
RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get install -y ./google-chrome-stable_current_amd64.deb
RUN rm google-chrome-stable_current_amd64.deb 
ENV CHROME_BIN=google-chrome-stable

ENV http_proxy=""
ENV https_proxy=""
ENV no_proxy=""

RUN su node -c "echo ${HTTP_PROXY}"

# npm config
RUN su node -c "npm config set registry https://registry.npmjs.org/"
RUN su node -c "npm config set proxy ${HTTP_PROXY}"
RUN su node -c "npm config set https-proxy ${HTTP_PROXY}"
RUN su node -c "npm config set strict-ssl false"

RUN su node -c "echo 'phantomjs_cdnurl=https://registry.npmjs.org//phantomjs' >> ~/.npmrc"
RUN su node -c "echo 'chromedriver_cdnurl=https://registry.npmjs.org//chromedriver' >> ~/.npmrc"

RUN apt-get update && apt-get install -y openjdk-17-jdk

# OH-MY-ZSH

RUN apt-get install -y zsh
RUN wget -nv -O /home/node/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
RUN chmod 777 /home/node/install.sh

COPY ozsh.sh /home/node/ozsh.sh
RUN chmod 777 /home/node/ozsh.sh