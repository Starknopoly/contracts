sozo build

katana --disable-fee

sozo migrate --name test

torii

sozo execute set_townhall  //国库

// Authoritarian

sh ./setup.sh

or:

sozo auth writer Player spawn

sozo auth writer Player roll

sozo auth writer Land roll

sozo auth writer Townhall roll


sozo auth writer Player build

sozo auth writer Land build

sozo auth writer Player buy

sozo auth writer Land buy

sozo auth writer Townhall buy

sozo auth writer Player supplement

sozo auth writer Land supplement

sozo auth writer Townhall supplement

sozo auth writer Player explode 

sozo auth writer Land explode

sozo auth writer Townhall explode



//play

sozo execute spawn --calldata 0x41424344 // with nickName "ABCD"

sozo execute roll

sozo execute build --calldata 1  // 1: Bank

sozo execute explode --calldata 256     //  set bomb with price 256



//view

sozo component entity Player 0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973

sozo component entity Land 0x33