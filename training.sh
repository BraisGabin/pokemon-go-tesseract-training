#!/bin/sh

mkdir -p /training/tmp
mkdir -p /training/pgo
cd training

set -ex

text2image --ligatures=true --text=/training/training-text.txt --outputbase=/training/tmp/pgo.lato.exp0 --font='Lato' --fonts_dir=/training/fonts/Lato

tesseract /training/tmp/pgo.lato.exp0.tif /training/tmp/pgo.lato.exp0 box.train.stderr

unicharset_extractor /training/tmp/pgo.lato.exp0.box
mv unicharset /training/tmp/unicharset

set_unicharset_properties -U /training/tmp/unicharset -O /training/tmp/pgo.unicharset --script_dir=langdata/

cd /training/pgo

mftraining -F /training/fonts/font_properties -U /training/tmp/pgo.unicharset -O pgo.unicharset /training/tmp/pgo.lato.exp0.tr
mv pffmtable pgo.pffmtable
mv inttemp pgo.inttemp
mv shapetable pgo.shapetable

cntraining /training/tmp/pgo.lato.exp0.tr
mv normproto pgo.normproto

combine_tessdata pgo.
