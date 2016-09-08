#!/bin/sh

set -ex

cd /training

text2image --ligatures=true --text=training-text.txt --outputbase=pgo.lato.exp0 --font='Lato' --fonts_dir=fonts/Lato

tesseract pgo.lato.exp0.tif pgo.lato.exp0 box.train.stderr

unicharset_extractor pgo.lato.exp0.box

set_unicharset_properties -U unicharset -O unicharset2 --script_dir=langdata/

mftraining -F fonts/font_properties -U unicharset2 -O pgo.unicharset pgo.lato.exp0.tr
cntraining pgo.lato.exp0.tr

rm unicharset2
mv pffmtable pgo.pffmtable
mv inttemp pgo.inttemp
mv shapetable pgo.shapetable
mv normproto pgo.normproto

combine_tessdata pgo.
