# uniortho run

running the pipeline

| Attributes       | &nbsp;
|------------------|-------------
| Alias:           | r

## Usage

```bash
uniortho run SPECIES [OPTIONS]
```

## Arguments

#### *SPECIES*

name of the species, leading with the s__ (using gtdb taxonomy)

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

## Options

#### *--outfolder, -o OUTFOLDER*

Supply your output folder, by default, it will be in ../results

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | ./results

#### *--ani, -a*

Use the fastANI approach on the samples to remove highly similar samples

#### *--input_files, -i*

Supply the file with paths to fna files that need to be included

#### *--threads, -t THREADS*

Supply number of threads used

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 16

#### *--gtdb_version_url, -g URL*

to use a different version of gtdb, supply the URL here

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | https://data.gtdb.ecogenomic.org/releases/latest/bac120_metadata.tsv.gz

#### *--completeness, -c COMPLETENESS*

Supply the minimum completeness threshold to select genomes on

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 95

#### *--contamination, -C CONTAMINATION*

Supply the maximum contamination threshold to select genomes on

| Attributes      | &nbsp;
|-----------------|-------------
| Default Value:  | 5


