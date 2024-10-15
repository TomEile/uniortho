#!/usr/bin/env bash
#requirements: blastn
run_blast_check(){
din=$1/fetch/fastas
dgenomes=$1/fnas
uqgenes=$1/uniquegenes.tsv
dout=$1/blast
threads=$2

mkdir -p $dout

zcat $dgenomes/*.gz | 
makeblastdb -in - -dbtype nucl -out $dout/db -title genomes > $dout/db.log

tail -n +2 $uqgenes |
cut -d ' ' -f 3 |
awk -v d="$din/" '$0='d'$0".fasta"' |
xargs cat |
blastn -query - -db $dout/db -out $dout/results -outfmt 6

}