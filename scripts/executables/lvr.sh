#!/bin/bash
LOCALPATH="$(dirname "${BASH_SROUCE[0]}")"
source "$HOME"/Desktop/AWS/scripts/env.sh

function print_usage()
{
	echo "`basename $0` --playtime={playtime} --framerate={framerate} --playVideo={playVideo} --mediaName={mediaName} --loglevel={loglevel}"
	echo "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __"
	echo ""
	echo "Where {playtim} is the duration you want to stream for....."
	echo "Where {playVideo} when streaming is done play the clip
	       y -> play 
	       n -> don't play"
	echo "Where {loglevel}"
	     echo "Either quiet or Noisy (with output)"       
	echo "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __"
}

if [ $# -lt 4 ]; then
	print_usage
	exit 2
fi 


while getopts ":sh-:" opt 
do 
	case "${opt}" in 
		-)
			val=${OPTARG#*=}	
			case $OPTARG in 
				playtime=*)
					playtime="${val}"
					;;
				framerate=*)
					framerate="${val}"	
					;;
				playVideo=*)
					playVideo="${val}"
					;;
				mediaName=*)
					mediaName="${val}"	
					;;
				loglevel=*)
					loglevel="${val}"	
					;;
			*)
				ehco invalid argument: "${OPTARG}"
				exit 1
				;;
			esac 
			;;
		h)
			print_usage
			exit 1
			;;

		*)
			echo unrecognized argument: "${OPTARG}"				
			exit 2
			;;
	esac 
done
	 
if [ -z "${playVideo}" ]; then
	echo please specify an playVideo option --yes or no-- with --playVideo; exit 3 
fi 	 

							
StartStreaming(){
	# ffmpeg -f avfoundation -framerate $playtime -i "0" -target pal-vcd ./$mediaName.mpg
	if [ $playtime == "n" ]; then
		$LOG "PASSED -- Play time not specified - please do ctrl+cmd to exit out of the ffmpeg streaming/mode...."
		ffmpeg -f avfoundation -framerate $framerate -i "0" -loglevel $loglevel -target pal-vcd ./$mediaName.mpg
	else
		$LOG "PASSED -- Starting a $playtimeseconds streaming session "
		ffmpeg -f avfoundation -framerate $framerate -t $playtime -i "0" -loglevel $loglevel -target pal-vcd ./$mediaName.mpg
	fi	
}

PlayVideo(){
	if [ $playVideo == "n" ]; then
	
		$LOG "DEBUG -- Not playing Media Clip Named: $mediaName (selected playVideo option: $playVideo"
	elif [ $playVideo == "y" ]; then 	
		$LOG "PASSED -- Playing Media Clip Named: $mediaName (selected playVideo option: $playVideo"
		ffplay $mediaName.mpg
	fi	
}

StartStreaming
# sleep $playtime
PlayVideo