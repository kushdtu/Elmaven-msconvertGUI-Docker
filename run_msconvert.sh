#/bin/sh

echo $1

export DISPLAY=:0
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')


if [ $ip ]; then
  echo "Ip exists"
  echo $ip
else
    echo "Ip not exists"
    ip=$(ifconfig en1 | grep inet | awk '$1=="inet" {print $2}')
    echo $ip
fi

export PATH=$PATH:/usr/X11R6/bin/

xhost $ip
export PATH=$PATH:/usr/local/bin

docker run --rm --name msmac -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v $1:/data:rw -e DISPLAY=$ip:0 kushalgupta/msconvertgui:0.1
