#!/bin/bash
set -euo pipefail
pushd $(dirname "$0")/..

export WORLD_ADDRESS="0x84486b8e9ffe38978b33c9d7685d9d2d487d0e9f096a1d2669edefc8506c35";

sozo execute set_townhall  --world $WORLD_ADDRESS # 国库
sleep 1

# Authoritarian
sozo auth writer Player spawn --world $WORLD_ADDRESS
sleep 1
sozo auth writer ETH spawn --world $WORLD_ADDRESS
sleep 1
sozo auth writer Player roll --world $WORLD_ADDRESS
sleep 1
sozo auth writer Land roll --world $WORLD_ADDRESS
sleep 1
sozo auth writer Townhall roll --world $WORLD_ADDRESS
sleep 1

sozo auth writer Player build --world $WORLD_ADDRESS
sleep 1
sozo auth writer Land build --world $WORLD_ADDRESS
sleep 1
sozo auth writer Townhall build --world $WORLD_ADDRESS
sleep 1
sozo auth writer Player buy --world $WORLD_ADDRESS
sleep 1
sozo auth writer Land buy --world $WORLD_ADDRESS
sleep 1
sozo auth writer Townhall buy --world $WORLD_ADDRESS
sleep 1
sozo auth writer Player supplement --world $WORLD_ADDRESS
sleep 1
sozo auth writer Land supplement --world $WORLD_ADDRESS
sleep 1
sozo auth writer Townhall supplement --world $WORLD_ADDRESS
sleep 1
sozo auth writer Player explode --world $WORLD_ADDRESS
sleep 1
sozo auth writer Land explode --world $WORLD_ADDRESS
sleep 1
sozo auth writer Townhall explode --world $WORLD_ADDRESS
sleep 1
sozo auth writer ETH buy_gold --world $WORLD_ADDRESS
sleep 1
sozo auth writer Player buy_gold --world $WORLD_ADDRESS
sleep 1
sozo auth writer Townhall buy_gold --world $WORLD_ADDRESS
sleep 1
sozo auth writer Player claim_steps --world $WORLD_ADDRESS
sleep 1


echo "Default authorizations have been successfully set."