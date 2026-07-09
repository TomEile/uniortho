# create uniortho conda environment.

## choice of package manager: conda, mamba, micromamba
pms=$1
if [ -z "$pms" ]; then
pms=conda
fi

$pms env create -n uniortho

$pms activate uniortho
$pms install -y -c bioconda scarap prodigal skani

# link uniortho and R filter script
ln -s $PWD/uniortho $HOME/.local/bin
ln -s $PWD/src/lib/uo_filter_unique_genes.R $HOME/.local/bin
ln -s $PWD/src/lib/process_blast_check.py $HOME/.local/bin
