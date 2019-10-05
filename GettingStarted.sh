#!/bin/bash -x
PDFARGS="-v -a pdf-stylesdir=. -a pdf-style=lc -a pdf-fontsdir=resources"
file=Getting_Started.md
download=/mnt/c/users/Mark/Downloads
if [ -f $download/$file ] ; then
	mv $download/$file ./source
fi

stem=$(echo $file | cut -f 1 -d .)
src=./source/${stem}.md
dst=./output/${stem}.pdf
cfg=./config/${stem}.adoc
if [ $src -nt $dst ] ; then 
	echo "generate $dst"
	asciidoctor-pdf $PDFARGS -o $dst $cfg
fi
date
