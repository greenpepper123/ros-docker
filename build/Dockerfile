FROM osrf/ros:melodic-desktop-bionic

# install ros packages and utils
RUN apt update && apt install -y \
    ros-melodic-desktop-full=1.4.1-0* \
    python-catkin-tools \
    vim \
    git \
    openssh-client \
    rlwrap \
    libfreenect-dev

RUN apt install -y tmux canberra-gtk*

RUN apt install -y ros-melodic-jsk-common ros-melodic-jskeus ros-melodic-husky-navigation ros-melodic-husky-gazebo ros-melodic-husky-viz

SHELL ["/bin/bash", "-c"]

RUN mkdir -p /catkin_ws/src

WORKDIR /catkin_ws/src

RUN source /opt/ros/melodic/setup.bash; \
    git clone https://github.com/jsk-enshu/robot-programming; \
    wstool init . ; \
    wstool merge robot-programming/.rosinstall.melodic; \
    wstool update

RUN source /opt/ros/melodic/setup.bash; \
    rosdep update

RUN rosdep install -y -r --from-paths . --ignore-src; exit 0

RUN cd .. ; \
    source /opt/ros/melodic/setup.bash; \
    catkin build

WORKDIR /catkin_ws
RUN wstool set -y -t src navigation_tutorials --git https://github.com/ros-planning/navigation_tutorials; \
    wstool update -t src navigation_tutorials; \
    rosdep install -y --from-paths src/navigation_tutorials --ignore-src; exit 0
RUN catkin build navigation_stage

ENV DISPLAY :0
ENV NO_AT_BRIDGE 1

RUN echo -e 'function setupros() {\nsource /opt/ros/melodic/setup.bash\nsource /catkin_ws/devel/setup.bash\nexport ROS_PACKAGE_PATH=/catkin_ws/src/beginner_tutorials:${ROS_PACKAGE_PATH}\n}\nfunction rosnode-killall () {\nwhile read -r NODE; do\nif [ $NODE != "/rosout" ]; then\nrosnode kill "$NODE"\nfi\ndone < <(rosnode list)\n}\nsetupros\nalias roseus="rlwrap roseus"\nalias irteusgl="rlwrap irteusgl"' >> /root/.bashrc; \
    echo -e "set expandtab\nset tabstop=4\nset shiftwidth=4\nset completeopt=menuone\nset nocompatible\nset wildmenu\nset wildmode=longest:full,full\nset whichwrap=b,s,[,],<,>\nau BufNewFile,BufRead *.launch set filetype=xml\nau BufNewFile,BufRead *.l set filetype=lisp" >> /usr/share/vim/vimrc; \
    echo -e "set -g mouse on\nset -g status-position top\nset-option -g history-limit 10000" > /root/.tmux.conf
