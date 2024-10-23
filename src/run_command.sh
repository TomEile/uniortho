data_folder=./data
species=${args[species]}
genomes_list=${args[genomes_list]}
outf=${args[--outfolder]}
gtdb_url=${args[--gtdb_version_url]}
completeness=${args[--completeness]}
contamination=${args[--contamination]}
cpus=${args[--threads]}
ani_threshold=${args[--ani]}
blast_check=${args[--blast]}

# Add s__ to species if absent
if [[ $species != s__* ]]; then
    species="s__$species"
fi

# check for requirements: R, scarap and skani
check_requirements


if [[ ! -s "$outf/pan/pangenome.tsv" ]]; then
    prepare_genomes "$data_folder" \
    "$gtdb_url" \
    "$species" \
    "$completeness" \
    "$contamination" \
    "$genomes_list "\
    "$outf"
    
    run_pangenome $outf $cpus
else
    echo "$(blue Pangenome already exists. Skipping pangenome calculation)"
fi

#using skani here, since its 'supposed to be better' for highly similar ANIs
# and those are the ones we want to remove 
#run_fastani $out $species

if [[ ! -s "$outf/ani" ]]; then
    run_skani $outf
else
    echo "$(blue ANI matrix already exists. Skipping ANI calculation)"
fi


# Rscript should be added to path and called from there
if [[ ! -s $HOME/.local/bin/uo_filter_unique_genes.R ]]; then
    echo "$(red uo_filter_unique_genes.R not found in $HOME/.local/bin.)"
    echo "$(red add the script to your path, for example with)"
    echo "$(magenta ln -s $PWD/src/lib/uo_filter_unique_genes.R $HOME/.local/bin)"
    exit 1
fi

script_in_bin "uo_filter_unique_genes.R"
$HOME/.local/bin/uo_filter_unique_genes.R $outf/pan/pangenome.tsv $outf/ani $ani_threshold $outf
fetch_genes $outf

if [[ $blast_check == 1 ]]; then
    run_blast_check $outf $cpus
    script_in_bin "process_blast_check.py"
    $HOME/.local/bin/process_blast_check.py $outf/blast/results $outf/uniquegenes.tsv $outf
fi
