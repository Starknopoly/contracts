#deploy contracts
cd ../
sozo --offline build
sozo migrate --name test
bash ./scripts/setup.sh

#run torii
if [ -e "indexer.db" ]; then
    echo "Deleting db file..."
    rm "indexer.db"
    echo "Deletion successful!"
fi
touch indexer.db
torii --database-url indexer.db --world 0x84486b8e9ffe38978b33c9d7685d9d2d487d0e9f096a1d2669edefc8506c35
