# SCARAP.
scarap_folder="SCARAP"
scarap_url="https://github.com/SWittouck/SCARAP.git"
if [ -d "./$scarap_folder" ]; then 
echo "$scarap_folder is already present, skipping git clone"
else
echo "cloning SCARAP"
git clone "$scarap_url" "$scarap_folder"
fi
cd SCARAP
conda env create -f environment.yml 

# skani
conda activate scarap
conda install -c bioconda skani