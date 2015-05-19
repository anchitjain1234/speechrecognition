clear
echo 'Enter name of file'
read inpfname
echo 'Is file in different directory?(y/n)'
read choice
inpcomppath=$inpfname
if [[ "$choice" == y ]]; then
	echo "Enter path of the input file"
	read inpfpath
	inpcomppath="$inpfpath/$inpfname"
fi
outfname="$inpfname-converted"
if [[ "$choice" == y ]]; then
	ffmpeg -i $inpfpath/$inpfname -acodec pcm_s16le -ac 1 -ar 16000 $outfname.wav
else
	ffmpeg -i $inpfname -acodec pcm_s16le -ac 1 -ar 16000 $outfname.wav
fi

gcc -o prog prog.c     -DMODELDIR=\"`pkg-config --variable=modeldir pocketsphinx`\"     `pkg-config --cflags --libs pocketsphinx sphinxbase`
outtxt="$outfname.txt"
outcomppath="$PWD/$outtxt"
./prog $inpcomppath $outcomppath
gedit $outtxt
