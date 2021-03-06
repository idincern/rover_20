#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/basestation/rover20_ws/src/rover_20/rover_20_navsat_driver"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/basestation/rover20_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/basestation/rover20_ws/install/lib/python2.7/dist-packages:/home/basestation/rover20_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/basestation/rover20_ws/build" \
    "/usr/bin/python2" \
    "/home/basestation/rover20_ws/src/rover_20/rover_20_navsat_driver/setup.py" \
    build --build-base "/home/basestation/rover20_ws/build/rover_20/rover_20_navsat_driver" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/basestation/rover20_ws/install" --install-scripts="/home/basestation/rover20_ws/install/bin"
