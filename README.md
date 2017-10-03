Docker image with `python 3.6` and `opencv 3.3`.
Runs a python application which broadcasts your camera's video on the local network over the port 80.   
   
**WARNING** Anyone on your local network will be able to view your camera's video while your docker container is running.   
   
Usage:   
> docker run -d -p 80:80 --privileged=true -v /dev/video0:/dev/video0 arthurgeron/docker-python3-opencv-security-camera:latest
