# example run:
# without running the program:
# ./make.sh FILENAME
# running the program after building:
# ./make.sh -r FILENAME
FILENAME=$1
RUNNING=true

if getopts 'r' c; then
    echo running
    FILENAME=$2
    RUNNING=true
fi

FILENAME="${FILENAME%%.*}"

~/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -c -o $FILENAME.o $FILENAME.c
~/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -o a.gb $FILENAME.o

if [ $RUNNING = true ]; then
    # wine ~/Desktop/bgb/bgb.exe a.gb 2>/dev/null &
	# java -jar ~/repos/gameboy_dev_tutorials/tools/Emulicious/Emulicious.jar a.gb 2>/dev/null &
    open a.gb
	# java -jar ~/Documents/gb_dev/Emulicious//Emulicious.jar
fi
