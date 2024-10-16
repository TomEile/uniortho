fetch_genes(){
din=$1
filtered_pan=$2

if [[ -n $(find "$din/fetch/fastas" -type f -name "*.fasta") ]]; then
    echo "$(blue $din/fetch/fastas already exists. Skipping fetch)"
else

ls $din/ffns/* > $din/input_ffns.txt
cat $din/input_ffns.txt
scarap fetch $din/input_ffns.txt $din/pan/pangenome.tsv $din/fetch
# cleanup
rm $din/input_ffns.txt
fi
}

