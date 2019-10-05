echo "generating graphs"
./generate-graphs.sh

echo "generating guilds pdf"
asciidoctor-pdf -a pdf-stylesdir=. -a pdf-style=lc -a pdf-fontsdir=resources -o ../output/LostColoniesLarp-Guilds.pdf guilds-detailed.adoc