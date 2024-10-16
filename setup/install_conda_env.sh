# SCARAP.

# choice of package manager: conda, mamba, micromamba
pms=$1
if [ -z "$pms" ]; then
pms=conda
fi

scarap_folder="SCARAP"
scarap_url="https://github.com/SWittouck/SCARAP.git"
if [ -d "./$scarap_folder/src/scarap" ]; then 
echo "$scarap_folder is already present, skipping git clone"
else
echo "cloning SCARAP"
git clone "$scarap_url" "$scarap_folder"
fi

$pms env create -f $scarap_folder/environment.yml 

# skani
conda activate scarap
$pms install -y -c bioconda prodigal skani

# link uniortho and R filter script
ln -s $PWD/uniortho $HOME/.local/bin
ln -s $PWD/src/lib/uo_filter_unique_genes.R $HOME/.local/bin
ln -s $PWD/src/lib/process_blast_check.py $HOME/.local/bin