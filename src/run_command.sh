data_folder=./data
species=${args[species]}
genomes_list=${args[genomes_list]}
outf=${args[--outfolder]}
gtdb_url=${args[--gtdb_version_url]}
completeness=${args[--completeness]}
contamination=${args[--contamination]}
cpus=${args[--threads]}

# Add s__ to species if absent
if [[ $species != s__* ]]; then
    species="s__$species"
fi

# Check if genome_list file exists when supplied
if [[ -n "$genomes_list" && ! -s "$genome_list" ]]; then
    echo "File $genomes_list not found. Exiting..."
    exit 1
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
    echo "Pangenome already exists. Skipping pangenome calculation"
fi

#using skani here, since its 'supposed to be better' for highly similar ANIs
# and those are the ones we want to remove 
#run_fastani $out $species

if [[ ! -s "$outf/ani.af" ]]; then
    run_skani $outf
else
    echo "ANI matrix already exists. Skipping ANI calculation"
fi


# TODO: Add to path and call from there
if [[ ! -s $HOME/.local/bin/uo_filter_unique_genes.R ]]; then
    echo "uo_filter_unique_genes.R not found in $HOME/.local/bin."
    echo "Please add the script to your path, for example with"
    echo "ln -s $PWD/src/lib/uo_filter_unique_genes.R $HOME/.local/bin"
    exit 1
fi

$HOME/.local/bin/uo_filter_unique_genes.R $outf/pan/pangenome.tsv $outf/ani.af $outf
fetch_genes $outf
