# startover: clean and start
# server: run with --load-state

if [ "$1" == "startover" ]; then
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
  exit 0
elif [ "$1" == "server" ]; then
  katana --disable-fee --load-state ./dump-state.bin --dump-state ./dump-state.bin
  exit 0
else
  echo "Invalid option: $1, please use startover/server"
  exit 1
fi