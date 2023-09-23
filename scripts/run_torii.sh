#deploy contracts

if [ "$1" == "startover" ]; then
  echo "build and deploy/upgrade contracts"
  sozo --offline build
  sozo migrate --name test
  bash ./scripts/setup.sh

  if [ -e "indexer.db" ]; then
    echo "Deleting db file..."
    rm "indexer.db"
    echo "Deletion successful!"
  fi
  touch indexer.db
  exit 0
elif [ "$1" == "upgrade" ]; then
  sozo --offline build
  sozo migrate --name test
  bash ./scripts/setup.sh
  echo "Run torii server"
  torii --database-url indexer.db --world 0x12aea93a199ffb3b8b8abca77ff2297da26d31f5bad5a87713b823171f59302
  exit 0
elif [ "$1" == "server" ]; then
  echo "Run torii server"
  torii --database-url indexer.db --world 0x12aea93a199ffb3b8b8abca77ff2297da26d31f5bad5a87713b823171f59302
  exit 0
else
  echo "Invalid option: $1, please use startover/upgrade/server"
  exit 1
fi