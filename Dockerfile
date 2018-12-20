FROM ubuntu:bionic

RUN apt update -qq && \
    apt install -y \
      curl \
      gnupg2 \
      locales \
      lsb-release && \
    curl http://repo.ros2.org/repos.key | apt-key add - && \
    sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list' && \
    apt update -qq && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    apt install -y \
      build-essential \
      cmake \
      git \
      python3-colcon-common-extensions \
      python3-pip \
      python-rosdep \
      python3-vcstool \
      wget && \
    python3 -m pip install -U \
      argcomplete flake8 \
      flake8-blind-except \
      flake8-builtins \
      flake8-class-newline \
      flake8-comprehensions \
      flake8-deprecated \
      flake8-docstrings \
      flake8-import-order \
      flake8-quotes \
      pytest-repeat \
      pytest-rerunfailures \
      pytest \
      pytest-cov \
      pytest-runner \
      setuptools && \
    apt install --no-install-recommends -y \
      libasio-dev \
      libtinyxml2-dev && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
