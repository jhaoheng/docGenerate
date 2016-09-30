#!/bin/bash

echo "Please input file name, ex: index_users.php"

read -p "file : " _input

inputPath=$(pwd)"/"
inputName="${_input%%.*}"
inputExt=".${_input##*.}"
input=$inputPath$inputName$inputExt

outputPath=$(pwd)"/"
outputName=$inputName
outputExt=".md"
output=$outputPath$outputName$outputExt

start_sign='/*==='
end_sign='===*/'

echo ""
echo "input file : "$input
echo "output file : "$output
echo ""
echo "============"

IFS=$'\r\n' GLOBIGNORE='*' command eval  'line=($(cat $input))'
maxLine=$(cat $input | wc -l);
rm $output
# echo $maxLine;
# echo "${line[0]}"

printLine=false

for (( i = 0; i < $maxLine+1; i++ )); do
	# echo "${line[$i]}"
	
	detect=${line[$i]:0:5}
	# echo $detect

	if [ "$detect" == $start_sign ]; then
		printLine=true
		echo "" | tee -a $output
		continue

	elif [ "$detect" == $end_sign ]; then
		#statements
		printLine=false
		continue
	fi

	# echo $printLine
	if $printLine ; then
		echo "${line[$i]}" | tee -a $output
	fi

done

echo "============"
echo "Export file is : "$output
