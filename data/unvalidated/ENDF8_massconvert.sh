#!/bin/bash
set -e
set -u


INDIR=./endf_input
echo "Will try to mass convert a bunch of ENDF files. Will look in ${INDIR} for the input files (edit the script to make it look elsewhere)"
OUTBNPREFIX=ENDF8_massconvert_inelasticonly_dummydensity
CMD=ncrystal_endf2ncmat

for name in 013_Al_027 026_Fe_056 Be-metal benzene HinC5O2H8 HinCH2 l-CH4 ortho-D ortho-H para-D para-H reactor-graphite-10P reactor-graphite-30P s-CH4 SiO2-alpha SiO2-beta; do
    $CMD $INDIR/tsl-${name}.endf --outbn ${OUTBNPREFIX}_${name}
done

$CMD $INDIR/tsl-HinIceIh.endf --sec $INDIR/tsl-OinIceIh.endf:1/3 --outbn ${OUTBNPREFIX}_IceIh
$CMD $INDIR/tsl-NinUN.endf    --sec $INDIR/tsl-UinUN.endf:1/2    --outbn ${OUTBNPREFIX}_UN
$CMD $INDIR/tsl-SiinSiC.endf  --sec $INDIR/tsl-CinSiC.endf:1/2   --outbn ${OUTBNPREFIX}_SiC
$CMD $INDIR/tsl-UinUO2.endf   --sec $INDIR/tsl-OinUO2.endf:2/3   --outbn ${OUTBNPREFIX}_UO2
$CMD $INDIR/tsl-YinYH2.endf   --sec $INDIR/tsl-HinYH2.endf:2/3   --outbn ${OUTBNPREFIX}_YH2
$CMD $INDIR/tsl-HinZrH.endf   --sec $INDIR/tsl-ZrinZrH.endf:1/2  --outbn ${OUTBNPREFIX}_ZrH
