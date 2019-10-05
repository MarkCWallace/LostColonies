#!/bin/bash -x
PDFARGS="-v -a pdf-stylesdir=. -a pdf-style=lc -a pdf-fontsdir=resources"
$file=References.md
download=/mnt/c/users/Mark/Downloads
if [ -f $download/$file ] ; then
	mv $download/$file ./source
fi

asciidoctor-pdf $PDFARGS -o output/References.pdf config/References.adoc

date
