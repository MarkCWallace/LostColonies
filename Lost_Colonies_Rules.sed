## Chapter Heads
s/^\(# Skills and Knowledge \)$/<<<\n\1/
s/^\(## Components\)$/<<<\n\1/
s/^\(# More Rules\)$/<<<\n\1/
s/^\(## Gathering\)$/<<<\n\1/
s/^\(# Combat\)$/<<<\n\1/
s/^\(# Combat Skills Reference\)$/<<<\n\1/


# Special treatment of colons after line 27 (should be pattern)
135,704 s/$/\n/
# 135,704 s/:/::/
# Replace initial asterisks on any line with two hash marks (title 2)
s/^\*{1,}\(.*\)\*{1,}$/## \1/g
194,704 s/\*\*$/\n\n/
# Insulate [all]
s/^\(\[all\]\)/{blank}[all]/
