fetch_genes(){
din=$1
filtered_pan=$2

ls $din/ffns/* > $din/input_ffns.txt
cat $din/input_ffns.txt
scarap fetch $din/input_ffns.txt $din/pan/pangenome.tsv $din/fetch
# cleanup
rm $din/input_ffns.txt
}

