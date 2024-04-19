# example run:
# without running the program:
# ./make.sh FILENAME
# running the program after building:
# ./make.sh -r FILENAME
FILENAME=$1
RUNNING=false

if getopts 'r' c; then
    echo running
    FILENAME=$2
    RUNNING=true
fi

FILENAME="${FILENAME%%.*}"

/Users/max/Documents/gb_dev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -c -o $FILENAME.o $FILENAME.c
/Users/max/Documents/gb_dev/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -o a.gb $FILENAME.o

if [ $RUNNING = true ]; then
    # wine /home/max/Desktop/bgb/bgb.exe a.gb 2>/dev/null &
	java -jar /Users/max/Documents/gb_dev/Emulicious/Emulicious.jar a.gb 2>/dev/null &
	# java -jar /Users/max/Documents/gb_dev/Emulicious//Emulicious.jar
fi
