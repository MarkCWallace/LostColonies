#!/bin/bash 
PDFARGS="-v -a pdf-stylesdir=. -a pdf-style=lc -a pdf-fontsdir=resources"
file=Lost_Colonies_Rules.md
download=/mnt/c/users/Mark/Downloads
if [ -f $download/$file ] ; then
	mv $download/$file ./source
fi

stem=$(echo $file | cut -f 1 -d .)
src=./source/${stem}.md
dst=./output/${stem}.pdf
cfg=./config/${stem}.adoc
imd=./source/${stem}.imd
set -x
if [ $src -nt $dst ] ; then 
	echo "generate $dst"
	sed -f ./config/${stem}.sed <$src > $imd
	asciidoctor-pdf --trace $PDFARGS -o $dst $cfg
fi
set +x
wc -l $src
date
