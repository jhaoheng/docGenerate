#!/bin/bash

jqversion=$(jq --version)
jq=${jqversion:0:2}

if [ "$jq" == "jq" ]; then
	echo ""
	echo "Dependent : "$jqversion
else
	echo ""
	echo "\033[41;37m""Please install 'jq' to use this script""\033[0m"
	echo "\033[41;37m""http://xmodulo.com/how-to-parse-json-string-via-command-line-on-linux.html""\033[0m"
	exit
fi

echo "\033[1;32m"
echo "Please input file name, ex: index_users.php"
echo "\033[0m"

read -p "file : " _input

# input 
# _input="example.php"

inputPath=$(pwd)"/"$(cat config.json | jq -r '.input.path')
inputName="${_input%%.*}"
inputExt=".${_input##*.}"
input=$inputPath$inputName$inputExt

# output
outputPath=$(pwd)"/"$(cat config.json | jq -r '.output.path')
outputName=$(cat config.json | jq -r '.output.name'); if [[ "$outputName" == "" ]]; then outputName=$inputName; fi
outputExt=$(cat config.json | jq -r '.output.ext'); if [[ "$outputExt" == "" ]]; then outputExt=".md"; fi
outputPrefix=$(cat config.json | jq -r '.output.prefix');
outputPostfix=$(cat config.json | jq -r '.output.postfix');
output=$outputPath$outputPrefix$outputName$outputPostfix$outputExt

# sign
start_sign=$(cat config.json | jq -r '.sign.Start'); if [[ "$start_sign" == "" ]]; then start_sign="/*==="; fi
end_sign=$(cat config.json | jq -r '.sign.End'); if [[ "$end_sign" == "" ]]; then end_sign="===*/"; fi
sign_length=$(cat config.json | jq -r '.sign.Length'); if [[ "$sign_length" == "" ]]; then sign_length="5"; fi

echo ""
echo "\033[1;33m""Input""\033[0m"" 		: "$input
echo "\033[1;33m""Onput""\033[0m"" 		: "$output"\033[0m"
echo "\033[1;33m""Start_sign""\033[0m"" 	: "${start_sign:0:$sign_length}"\033[0m"
echo "\033[1;33m""End_sign""\033[0m"" 	: "${end_sign:0:sign_length}"\033[0m"
echo "\033[1;33m""Sign_length""\033[0m"" 	: "$sign_length"\033[0m"
echo ""
echo "============"

# check file exist
if [ ! -e "$input" ]; then
	echo ""
	echo "\033[1;41;37m""File does not exist""\033[0m"
	exit
fi

IFS=$'\r\n' GLOBIGNORE='*' command eval  'line=($(cat $input))'
maxLine=$(cat $input | wc -l);
rm $output
# echo $maxLine;
# echo "${line[0]}"

printLine=false

for (( i = 0; i < $maxLine+1; i++ )); do
	# echo "${line[$i]}"
	
	detect=${line[$i]:0:$sign_length}
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

echo ""
echo "============"
echo ""
