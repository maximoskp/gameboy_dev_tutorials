#!/bin/sh

RUNNING=false

# Handle -r flag
if [ "$1" = "-r" ]; then
    RUNNING=true
    shift
fi

# Remaining arguments are .c files
SOURCES="$@"

if [ -z "$SOURCES" ]; then
    echo "Usage: ./make.sh [-r] file1.c file2.c ..."
    exit 1
fi

# Output ROM name based on first source file
FIRST_FILE="$1"
ROM_NAME="${FIRST_FILE%%.*}.gb"

# Compile & link all sources at once
~/gbdk/bin/lcc -Wa-l -Wl-m -Wl-j -o "$ROM_NAME" $SOURCES

# Run emulator if requested
if [ "$RUNNING" = true ]; then
    open "$ROM_NAME"
    # or:
    # wine ~/Desktop/bgb/bgb.exe "$ROM_NAME" &
    # java -jar ~/Documents/gb_dev/Emulicious/Emulicious.jar "$ROM_NAME" &
fi
