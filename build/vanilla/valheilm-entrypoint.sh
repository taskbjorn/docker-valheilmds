#!/bin/bash

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppID=892970

echo "Starting server PRESS CTRL-C to exit"
./valheim_server.x86_64 -name ${SERVER_NAME} -port ${SERVER_PORT} -world ${WORLD_NAME} -password ${GAME_PASSWORD} -public 1
export LD_LIBRARY_PATH=$templdpath