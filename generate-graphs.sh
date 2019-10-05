#!/bin/bash

cd skills

cat graph-header.dot > ../graphs/interim/combined.dot

cat all-skills.adoc >> ../graphs/interim/combined.dot

cat choice-skills.adoc >> ../graphs/interim/combined.dot

cat all-guilds.adoc >> ../graphs/interim/combined.dot

# cat all-sets.adoc >> ../graphs/interim/combined.dot

cat all-armaments.adoc >> ../graphs/interim/combined.dot

cat graph-footer.dot >> ../graphs/interim/combined.dot

# awk '/^".*"/ { gsub(/" ->.*$/,"\"",$0); gsub(/"/,"",$0); print $0 }' all-sets.adoc | sort -u > ../graphs/interim/setlist.txt

# awk '/^".*"/ { gsub(/" ->.*$/,"\"",$0); gsub(/"/,"",$0); print $0 }' all-armaments.adoc | sort -u >> ../graphs/interim/setlist.txt

cp attributes-graph.dot ../graphs/interim/attributes.dot

cp character-creation.dot ../graphs/interim/character-creation.dot

cp injury-chart.dot ../graphs/interim/injury-chart.dot
cp injury-chart-10-plus.dot ../graphs/interim/injury-chart-10-plus.dot

cd ..
cd graphs/interim

# gvpr -o Academics.dot -f ../extract-graph-minus-2.gvpr -a "Academics\ Guild" combined.dot
gvpr -o Crafting.dot -f ../extract-graph-minus-2.gvpr -a "Crafting\ Guild" combined.dot
gvpr -o Explorers.dot -f ../extract-graph-minus-2.gvpr -a "Explorers\ Guild" combined.dot
gvpr -o Acquisitions.dot -f ../extract-graph-minus-2.gvpr -a "Acquisitions\ Guild" combined.dot
gvpr -o Ritualist.dot -f ../extract-graph-minus-2.gvpr -a "Ritualist\ Guild" combined.dot
gvpr -o Medicus.dot -f ../extract-graph-minus-2.gvpr -a "Medicus\ Guild" combined.dot
gvpr -o Military.dot -f ../extract-graph-minus-2.gvpr -a "Military\ Orders" combined.dot
# gvpr -o Staring.dot -f ../extract-graph-minus-2.gvpr -a "Staring\ Guild" combined.dot

# special includes
sed '6 i\
{ rank = same; "Apprentice Herbalist I"; "Apprentice Herbalist II"; "Apprentice Herbalist III" }
' Medicus.dot > temp
mv temp Medicus.dot

sed '6 i\
{ rank = same; "Apprentice Alchemist I"; "Apprentice Alchemist II"; "Apprentice Alchemist III" }
' Crafting.dot > temp
mv temp Crafting.dot

sed '6 i\
{ rank = same; "Initiate Rituals", "Adept Rituals", "Master Rituals" }
' Ritualist.dot > temp
mv temp Ritualist.dot

sed '6 i\
{ rank = same; "Sneak", "Tracking and Alertness" }
' Explorers.dot > temp
mv temp Explorers.dot



# while read line; do
# 	gvpr -o "${line// /-}.dot" -f ../extract-graph-set.gvpr -a "${line// /\ }" combined.dot
# done <setlist.txt

# dot -Tpng -o ../../images/all-skills.png combined.dot

for filename in *.dot; do
    newfile=${filename%.dot}
    dot -Tpng -o "../../images/$newfile-graph.png" "$filename"
done


