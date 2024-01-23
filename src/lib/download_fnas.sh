## Add any function here that is needed in more than one parts of your
## application, or that you otherwise wish to extract from the main function
## scripts.
##
## Note that code here should be wrapped inside bash functions, and it is
## recommended to have a separate file for each function.
##
## Subdirectories will also be scanned for *.sh, so you have no reason not
## to organize your code neatly.
##
download_fnas() {
  #inspect_args
fin="$1"
dout=$2

[ -d $dout ] || mkdir -p $dout

for acc in $(cat "$fin" | cut -f 1) ; do
  if $(ls $dout | grep -q ${acc:3}); then
    echo "skipping download of ${acc:3}"
    continue
  fi
  echo "downloading ${acc:3}..."

  url=ftp.ncbi.nlm.nih.gov/genomes/all/${acc:3:3}/${acc:7:3}/${acc:10:3}/${acc:13:3}/${acc:3}*/${acc:3}*_genomic.fna.gz
  exitcode=1 
  attempt=1
  while [[ $exitcode -ne 0 ]] && [[ $attempt -le 5 ]] ; do
    if [[ $attempt -ne 1 ]] ; then sleep 10 ; echo attempt $attempt ; fi
    rsync --copy-links --times --verbose \
      --exclude *_cds_from_genomic.fna.gz \
      --exclude *_rna_from_genomic.fna.gz \
      rsync://$url $dout > /dev/null 2>&1
    exitcode=$?
    attempt=$((attempt + 1))
    # echo $exitcode $attempt
    if [[ $exitcode -ne 0 ]] && [[ $attempt -eq 6 ]] ; then 
      echo failure
      echo $acc >> $dout/failed.txt
    fi
  done
done


}
