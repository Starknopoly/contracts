#!/bin/bash
set -euo pipefail
pushd $(dirname "$0")/..

export WORLD_ADDRESS="0x12aea93a199ffb3b8b8abca77ff2297da26d31f5bad5a87713b823171f59302";
export WORLD_ADDRESS="0x12aea93a199ffb3b8b8abca77ff2297da26d31f5bad5a87713b823171f59302";

sozo execute set_townhall  --world $WORLD_ADDRESS # 国库
sleep 1

# Authoritarian
sozo auth writer Player spawn --world $WORLD_ADDRESS
sozo auth writer Player spawn --world $WORLD_ADDRESS
sleep 1
sozo auth writer ETH spawn --world $WORLD_ADDRESS
sozo auth writer ETH spawn --world $WORLD_ADDRESS
sleep 1
sozo auth writer Player roll --world $WORLD_ADDRESS
sozo auth writer Player roll --world $WORLD_ADDRESS
sleep 1
sozo auth writer Land roll --world $WORLD_ADDRESS
sozo auth writer Land roll --world $WORLD_ADDRESS
sleep 1
sozo auth writer Townhall roll --world $WORLD_ADDRESS
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
sozo auth writer Player claim_energy --world $WORLD_ADDRESS
sleep 1
sozo auth writer EnergyRecover claim_energy --world $WORLD_ADDRESS
sleep 1

echo "Default authorizations have been successfully set."

