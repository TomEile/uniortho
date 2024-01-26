#!/usr/bin/env bash
run_prodigal() {

dout=$1
din=$dout/fnas

[ -d "$dout/faas" ] || mkdir -p "$dout/faas"
[ -d "$dout/ffns" ] || mkdir -p "$dout/ffns" #needed for extraction of the genes of interest
for F in $din/*.fna.gz;
	do N=$(basename $F .fna.gz);
    if test -s "$dout/faas/$N.faa"; then
        echo "$(blue $dout/faas/$N.faa already exists. Skipping prodigal)"
    else
        echo "$(green Running prodigal on $N.fna.gz)"
        zcat $F | prodigal -a $dout/faas/$N.faa -d $dout/ffns/$N.ffn -q >/dev/null;
    fi
done
}