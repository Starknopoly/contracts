#Check if "dump-state.bin" file exists in the current directory
if [ -e "indexer.db" ]; then
    echo "Deleting db file..."
    rm "indexer.db"
    echo "Deletion successful!"
fi
touch indexer.db
torii --database-url indexer.db
