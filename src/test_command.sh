blast_check=${args[--blast]}
blast_db=${args[database]}
outf="test_out"

if [[ $blast_check == 1 ]]; then
    script_in_bin "process_blast_check.py"
    if [[ ! -s "test_out/blast/results" ]]; then
    uniortho run "s__Sumerlaea chitinivorans" -C 10 -o $outf --blast "$blast_db"
    else 
        echo "$(blue Blast results already exist. Skipping blast)"
    fi
    python3 $HOME/.local/bin/process_blast_check.py $outf/blast/results $outf/uniquegenes.tsv $outf
else
    uniortho run "s__Sumerlaea chitinivorans" -C 10 -o $outf
fi
