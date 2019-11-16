#!/bin/bash

xhost local:
docker run -ti --privileged --shm-size=8gb --net=host --env="QT_X11_NO_MITSHM=1" -v $(pwd)/../../github/robot-system/beginner_tutorials:/catkin_ws/src/beginner_tutorials -v $(pwd)/models:/root/.gazebo/models -v /run/udev:/run/udev -v /run/dbus:/run/dbus -v /run/systemd:/run/systemd -v "/tmp/.X11-unix/:/tmp/.X11-unix:rw" my-ros:5
