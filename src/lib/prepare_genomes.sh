prepare_genomes(){
    data_folder="$1"
    gtdb_url="$2"
    species="$3"
    completeness="$4"
    contamination="$5"
    genomes_list="$6"
    outf="$7"

    [ -d $data_folder ] || mkdir -p $data_folder

    # download GTDB bac120 metadata if needed
    bac120_file=$(basename "${gtdb_url}" .tar.gz)

    if [[ -n $(find "$data_folder" -type f -name "$bac120_file*") ]]; then
        echo "$(blue $bac120_file already exists. Skipping download)"
    else
        echo "$(green $bac120_file File doesn\'t exist, downloading...)"
        wget $gtdb_url -P $data_folder
    fi

    # check if a selection of this species is already made
    selection="$data_folder/${species}_selection.tsv"
    selection_file_name=$(basename "${selection}")

    if [[ -n $(find $data_folder -type f -name "$selection_file_name*") ]]; then
        echo "$(blue $selection_file_name already exists.)"
    else
        echo "$(green $selection_file_name File doesn\'t exist, subsetting $bac120_file...)"
        # GTDB tax is in column 17; filter there
        # also filter for contam and completeness
        {
            zless $data_folder/$bac120_file \
            | awk -F "\t" -v species="$species" \
                -v complete="$completeness" -v contam="$contamination" \
                '$17 ~ species &&  $3 >= complete && $4 <= contam' > "$selection"
        }
    fi

    # raise error if no genomes are found
    if [[ ! -s "$selection" ]]; then
        echo "$(red No genomes found for $species. Exiting...)"
        exit 1
    fi

    download_fnas "$selection" $outf/fnas
    #if you have non-public genomes, add your own fnas files in the correct folder before running the next steps
    if [[ ! -n "$genomes_list" ]]; then
        while read f; do
            if [[ ! -s "$f" ]]; then
                echo "$(cyan File $f not found. Ignoring it...)"
            else
                cp $f $outf/fnas
            fi
        done < $genomes_list
    fi

    run_prodigal $outf

}
