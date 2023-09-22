#Check if "dump-state.bin" file exists in the current directory
if [ -e "dump-state.bin" ]; then
    echo "Deleting state file..."
    rm "dump-state.bin"
    echo "Deletion successful!"
fi

katana --disable-fee --dump-state ./dump-state.bin &
sleep 1
echo "stop katana..."
kill -SIGINT $!
echo "restarting katana..."
sleep 2
katana --disable-fee --load-state ./dump-state.bin --dump-state ./dump-state.bin