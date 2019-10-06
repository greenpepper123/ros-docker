FROM osrf/ros:melodic-desktop-bionic

# install ros packages and utils
RUN apt update && apt install -y \
    ros-melodic-desktop-full=1.4.1-0* \
    python-catkin-tools \
    vim \
    git \
    openssh-client

RUN apt install -y tmux canberra-gtk*

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

ENV DISPLAY :0
ENV NO_AT_BRIDGE 1

RUN echo -e 'function setupros() {\nsource /opt/ros/melodic/setup.bash\nsource /catkin_ws/devel/setup.bash\n}\nfunction rosnode-killall () {\nwhile read -r NODE; do\nif [ $NODE != "/rosout" ]; then\nrosnode kill "$NODE"\nfi\ndone < <(rosnode list)\n}' >> /root/.bashrc
RUN echo -e 'au BufNewFile,BufRead *.launch set filetype=xml' >> /etc/vim/vimrc
