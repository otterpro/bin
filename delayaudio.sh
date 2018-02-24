#!/bin/sh
# PROBLEM: it won't work on windows version. TODO: test on Mac/Linux
# delayaudio.sh <filename.mp4> [<delay=0.5s>]
outputfile="${1%.mp4}_delay.mp4" 
# debug parameters
# echo "one", $1
# echo "two", $2
# echo $outputfile

# example
#ffmpeg -i test.mp4 -itsoffset 0.5 -i test.mp4 -map 0:0 -map 1:1 -vcodec copy -acodec copy output.mp4
#echo "-itsoffset ${2:-0.5} -i"
# ffmpeg -i "$1" -itsoffset ${2:-0.5} -i "$1" -map 0:0 -map 1:1 -vcodec copy -acodec copy "$outputfile"
ffmpeg -i "$1" -itsoffset ${2:-0.5} -i "$1" -map 0:0 -map 1:1 -vcodec copy -acodec copy "$outputfile"
