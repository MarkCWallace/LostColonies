#!/bin/bash 
############
# Initialize my variables
OUT=./output		# OUT is the destination for all output files
source=./source  	# Source is where I store all the markdown files
config=./config		# Config is where I store adoc files

mkdir -p ${OUT}		# If the directory does not exist, create it.
mkdir -p ${source}	# If the directory does not exist, create it.
mkdir -p ${config}	# If the directory does not exist, create it.
# Use the following arguments for all asciidoctor PDF creation.
PDFARGS="-a pdf-stylesdir=. -a pdf-style=lc -a pdf-fontsdir=resources"

sfiles="Getting_Started Lost_Colonies_Rules References guilds guilds-detailed"
date
set -x

for file in $sfiles
do
	# This shoudl be insulated by an "if this file exists, remove it"

	[ -f ${OUT}/${file}.pdf ] && rm ${OUT}/${file}.pdf 
	[ -f ${OUT}/${file}.imd ] && rm ${OUT}/${file}.imd

	if [ ${config}/${file}.adoc -nt ${OUT}/${file}.pdf ]; then
		echo "newer"
	else	
		echo "older"
	fi
	# if there is a sed file for pre-processing, then 
	# 	pre process the markdown file (md) to an intermediate markdown (imd)
	if test -f $config/$file.sed; then	#sed pre-process
		sed -f ${config}/${file}.sed < ${source}/${file}.md > ${source}/${file}.imd
		fi
	asciidoctor-pdf -v $PDFARGS -o $OUT/${file}.pdf $config/$file.adoc
	echo "Done with $file"
done


exit
####
# TODO
# I'd like to get rid of config - I could store the files in source or
# I could generate them algorithmically.  They're not complex files

# I need ot find a way to tag and cross connect to do the guild book

