#!/usr/bin/env bash
#requirements: blastn
run_blast_check(){
din=$1/fetch/fastas
dgenomes=$1/fnas
uqgenes=$1/uniquegenes.tsv
dout=$1/blast
threads=$2
blastdb=$3

mkdir -p $dout

if [[ "$blastdb" != false ]] ; then
    echo "$(green Running blast against $blastdb database)"
    tail -n +2 $uqgenes |
    cut -d ' ' -f 3 |
    awk -v d="$din/" '$0='d'$0".fasta"' |
    xargs cat |
    blastn -query - -db $blastdb \
    -out $dout/results -outfmt 6

else
    echo "$(green Running blast against nt database)"
    tail -n +2 $uqgenes |
    cut -d ' ' -f 3 |
    awk -v d="$din/" '$0='d'$0".fasta"' |
    xargs cat |
    blastn -query - -db nt -remote \
    -out $dout/results -outfmt 6

fi


}