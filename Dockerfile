FROM ubuntu:focal

RUN apt update && apt install -y curl gnupg2 locales lsb-release && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8 && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list' && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN export DEBIAN_FRONTEND=noninteractive && \
  apt update && \
  apt install -y \
    build-essential \
    cmake \
    git \
    libbullet-dev \
    python3-colcon-common-extensions \
    python3-flake8 \
    python3-pip \
    python3-pytest-cov \
    python3-rosdep \
    python3-setuptools \
    python3-vcstool \
    wget && \
  python3 -m pip install -U \
    argcomplete \
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
    pytest && \
  apt install --no-install-recommends -y \
    libasio-dev \
    libtinyxml2-dev \
    libcunit1-dev && \
  apt clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt update && apt install -y tmux vim && \
  apt clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p ~/ros2_foxy/src && \
  cd ~/ros2_foxy && \
  wget https://raw.githubusercontent.com/ros2/ros2/master/ros2.repos && \
  vcs import src < ros2.repos && \
  apt update && \
  rosdep init && \
  rosdep update && \
  rosdep install --from-paths src --ignore-src --rosdistro foxy -y --skip-keys "console_bridge fastcdr fastrtps  rti-connext-dds-5.3.1 urdfdom_headers" && \
  apt clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
