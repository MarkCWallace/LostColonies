#!/bin/bash

awk '/^tag::/{ a = gensub(/^tag::(.+)\[\]/,"include::../skills/all-skills.adoc[tag=\\1]","g",$1); print a; print"\n<<<\n";}' skills/all-skills.adoc > cards/all-cards.adoc
awk '/^tag::/{ a = gensub(/^tag::(.+)\[\]/,"include::../skills/choice-skills-permutations.adoc[tag=\\1]","g",$1); print a; print"\n<<<\n";}' skills/choice-skills-permutations.adoc >> cards/all-cards.adoc

asciidoctor-pdf -q -a pdf-stylesdir=. -a pdf-style=skill-card -a pdf-fontsdir=resources -o ../output/all-cards.pdf cards/all-cards.adoc