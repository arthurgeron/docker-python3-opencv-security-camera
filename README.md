Docker image with `python 3.6` and `opencv 3.3`.
Runs a python application which broadcasts your camera's video on the local network over the port 80.   
   
**WARNING** Anyone on your local network will be able to view your camera's video while your docker container is running.   
   
Usage:   
    > docker run -p 80:80/tcp -it arthurgeron/opencv-security-camera
