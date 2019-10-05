#!/bin/bash 
############
# Initialize my variables
OUT=./output
source=./source
config=./config
download=/mnt/c/users/Mark/Downloads/
mkdir -p ${OUT}
mkdir -p ${source}
mkdir -p ${config}
PDFARGS="-a pdf-stylesdir=. -a pdf-style=lc -a pdf-fontsdir=resources"

# Import any files from the download directory
sourcefiles="Getting_Started.docx Getting_Started.md Getting_Started.pdf Lost_Colonies_Rules.docx Lost_Colonies_Rules.md Lost_Colonies_Rules.pdf References.docx References.md References.pdf"
for file in $sourcefiles
do
	if test -f ${download}/$file; then 
		echo $file
		mv $download/$file ./source
	fi
done
# If a new Lost Colonies Rules file has been exported from paper....

sfiles="Getting_Started Lost_Colonies_Rules References"
set -x

for file in $sfiles
do
		if [ ${config}/${file}.md -nt ${OUT}/${file}.pdf ] ; then 
			echo "updating $file"
			if test -f $config/$file.sed; then
				echo "Processing sed file $config/$file.sed to $source/$file.intermed"
				sed -f ${config}/${file}.sed $source/$file | \
					pandoc -s -f markdown -t html -o $OUT/${file}M.html $source/$file.intermed
				echo "Done with $config/$file.sed"
			fi
		fi
	# pandoc -f markdown -t latex -o ${OUT}/${file}mP.pdf ${source}/${file}.md
	# pandoc -s -f markdown -t html -o $OUT/${file}M.html $source/$file.md
	# pandoc -f docx -t markdown -o ${OUT}/${file}.md $source/$file.docx
	asciidoctor-pdf -v $PDFARGS -o $OUT/${file}.pdf $config/$file.adoc
	# pandoc -s -f docx -t html -o $OUT/${file}D.html $source/$file.docx
	# pandoc -f markdown -t latex -o ${OUT}/${file}MP.pdf ${source}/${file}.md
	# pandoc -f docx -t latex -o ${OUT}/${file}DP.pdf ${source}/${file}.docx

	echo "Done with $file"
done


exit
#############################################################
if test -f "$FILE"; then
	echo "Updating Lost Colonies Rules based on $FILE"
	# pandoc -f docx  -t asciidoc -o ${config}/Lost_Colonies_Rules.adoc $FILE
	## Need to add sed transform for edge cases
	# pandoc -f docx -t markdown -o ${OUT}/Lost_Colonies_Rules.md $FILE
	asciidoctor-pdf -v  $PDFARGS -o ${OUT}/Lost_Colonies_Rules.pdf ${config}/Lost_Colonies_Rules.adoc
	# pandoc -s -f docx -t html -o ${OUT}/Lost_Colonies_Rules.html $FILE
	# rm $FILE
fi
############ The following are currently inoperative
	# pandoc to pdf requires pdflatex installed
	# pandoc -f docx  -o ${OUT}/Lost_Colonies_Rules.PDF $FILE


if [ References.adoc -nt ${OUT}References.pdf ] ; then 
	echo "regenerating References"
	sed -f References.sed Volume_2.md >V2.intermed
	asciidoctor-pdf -v   $PDFARGS -o ${OUT}/References.pdf References.adoc
	asciidoctor-pdf -a stylesheet=review.css -a review@=set $PDFARGS -o ${OUT}/ReferencesRedline.pdf References.adoc
fi



echo "exit"
exit
#############
# Design
# mkdir source (Store all source files here
# mdir output  (store output files here - redirect from current
# mkdir config (store all sed files and other configuration materials here

# need to figure out how to strip extension down tos tems
# echo "basename $FILE" | cut -f 1 -d '.'
# FN= basename $FILE | cut -f 1 -d '.'
# echo $FN


echo "generating CS&S"

asciidoctor-pdf -v   $PDFARGS -o ../${OUTPUT}/CommunityStandards.pdf CommunityStandards.adoc


echo "generating CS&S"
asciidoctor-pdf -v   $PDFARGS -o ../${OUTPUT}/CommunityStandards.pdf CommunityStandards.adoc

echo "generating core rulebook pdf"
asciidoctor-pdf -v   --trace $PDFARGS  -o ../${OUT}/R.pdf  rules.adoc

exit

# echo "generating quickstart html"
# asciidoctor -o ../${OUTPUT}/LostColoniesLarp-Quickstart.html quickstart.adoc

echo "generating quickstart pdf"
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Quickstart.pdf quickstart.adoc

# echo "generating guilds html"
# asciidoctor -o ../${OUTPUT}/LostColoniesLarp-Guilds.html guilds-detailed.adoc
# cat ../${OUTPUT}/LostColoniesLarp-Guilds.html | html-to-text > ../${OUTPUT}/LostColoniesLarp-Guilds.txt
# wc -w ../${OUTPUT}/LostColoniesLarp-Guilds.txt

echo "generating guilds pdf"
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Guilds.pdf guilds-detailed.adoc

echo "generating cheat sheets"
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc-cheat-sheets -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Injuries.pdf cheat-sheet-injuries.adoc
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc-cheat-sheets -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Components.pdf cheat-sheet-components.adoc


echo "generating recipe books"
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc-cheat-sheets -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Alchemy.pdf all-alchemy.adoc
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc-cheat-sheets -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Cooking.pdf all-cooking.adoc
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc-cheat-sheets -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Fiber-Arts.pdf all-fiber-arts.adoc
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc-cheat-sheets -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Herbals.pdf all-herbals.adoc
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc-cheat-sheets -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Rituals.pdf all-rituals.adoc
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc-cheat-sheets -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Smithing.pdf all-smithing.adoc
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc-cheat-sheets -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Production.pdf all-production.adoc
asciidoctor-pdf -a stylesheet=review.css -a review@=set -a pdf-stylesdir=. -a pdf-style=lc -a pdf-fontsdir=resources -o ../${OUTPUT}/LostColoniesLarp-Rulebookreview.pdf rulebook.adoc
