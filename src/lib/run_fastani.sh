#!/usr/bin/env bash
#requirements: fastANI
run_fastani(){
fin=$1
dout="../results/$(basename $fin .tsv)"
echo $dout
exit
id=$(find $dout/fnas -name "$2*")
echo $id
ls $dout/fnas/* > $dout/input_fnas.txt

[ -d "$dout/fastani" ] || mkdir -p "$dout/fastani"
fastANI -q $id --rl $dout/input_fnas.txt -o $dout/fastani/${2}_ani.txt

}