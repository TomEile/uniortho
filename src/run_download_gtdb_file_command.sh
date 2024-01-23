echo "# this file is located in 'src/run_download_gtdb_file_command.sh'"
echo "# code for 'uniortho run download_gtdb_file' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args



##check whether the gtdb db is already present, otherwise download

[ -d $ddata ] || mkdir -p $ddata

wget ./../../ https://data.gtdb.ecogenomic.org/releases/release214/214.0/bac120_metadata_r214.tar.gz


