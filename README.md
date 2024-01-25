# uniortho
Pipeline to make strain specific primers for your strain of interest based on unique orthogroups

Uniortho is a standalone bash script developed by using [bashly](https://bashly.dannyb.co/). It uses the pangenome analysis tool [SCARAP](https://github.com/SWittouck/SCARAP) and [skani](https://github.com/bluenote-1577/skani) for average nucleotide identity calculation.

# Installing uniortho

The easiest way to install the dependencies needed for uniortho is to clone this repository and make use of a conda environment. Make sure that you have [conda installed](https://conda.io/projects/conda/en/latest/user-guide/install/index.html).

Clone this repository

```{bash}
git clone https://github.com/TomEile/uniortho.git
cd uniortho
```

A script containing instructions on installing the dependencies is included in the setup directory. Running it as such creates a new conda environment called 'scarap':

```{bash}
chmod +x ./setup/install_conda_env.sh
./setup/install_conda_env.sh
```

After dependencies have installed the script can be used while the environment is active:

```{bash}
conda activate scarap
uniortho run
```
# Usage

To get a detailed overview of the parameters run:

```{bash}
uniortho run -h
```

```
uniortho run - running the pipeline

Alias: r

Usage:
  uniortho run SPECIES [OPTIONS]
  uniortho run --help | -h

Options:
  --outfolder, -o OUTFOLDER
    Supply your output folder, by default, it will be in ../results
    Default: ./results

  --ani, -a
    Use the fastANI approach on the samples to remove highly similar samples

  --input_files, -i GENOMES_LIST
    Supply the file with paths to fna files that need to be included
    Default: 

  --threads, -t THREADS
    Supply number of threads used
    Default: 16

  --gtdb_version_url, -g URL
    to use a different version of gtdb, supply the URL here
    Default: https://data.gtdb.ecogenomic.org/releases/latest/bac120_metadata.tsv.gz

  --completeness, -c COMPLETENESS
    Supply the minimum completeness threshold to select genomes on
    Default: 95

  --contamination, -C CONTAMINATION
    Supply the maximum contamination threshold to select genomes on
    Default: 5

  --help, -h
    Show this help

Arguments:
  SPECIES
    name of the species, leading with the s__ (using gtdb taxonomy)
```
