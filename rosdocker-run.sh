#!/bin/bash

xhost local:
docker run -ti --privileged --shm-size=8gb --env="QT_X11_NO_MITSHM=1" -v $(pwd)/catkin_ws:/catkin_ws -v $(pwd)/models:/root/.gazebo/models -v /run/udev:/run/udev -v /run/dbus:/run/dbus -v /run/systemd:/run/systemd -v "/tmp/.X11-unix/:/tmp/.X11-unix:rw" my-ros:3
