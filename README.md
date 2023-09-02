sozo build

katana --disable-fee

sozo migrate --name test

torii

sozo execute set_townhall  //国库
sozo execute set_building  --calldata 1,100  //酒店 100
sozo execute set_building  --calldata 2,500  //银行 500
sozo execute set_building  --calldata 3,1000 //加油站 1000

// Authoritarian
sozo auth writer Player spawn

sozo auth writer Player roll
sozo auth writer Land roll

sozo auth writer Player build
sozo auth writer Land build

sozo auth writer Player buy
sozo auth writer Land buy
sozo auth writer Townhall buy

sozo auth writer Player supplement
sozo auth writer Land supplement
sozo auth writer Townhall supplement