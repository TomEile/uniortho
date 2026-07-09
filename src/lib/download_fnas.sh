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

while IFS=$'\t' read -r acc assembly_name; do
  if $(ls $dout | grep -q ${acc:3}); then
    echo "$(blue skipping download of ${acc:3})"
    continue
  fi
  url=https://ftp.ncbi.nlm.nih.gov/genomes/all/${acc:3:3}/${acc:7:3}/${acc:10:3}/${acc:13:3}/${acc:3}_"$assembly_name"/${acc:3}_"$assembly_name"_genomic.fna.gz
  echo "$(green downloading ${acc:3}...)"
     exitcode=1 
     attempt=1
     while [[ $exitcode -ne 0 ]] && [[ $attempt -le 5 ]] ; do
       
       if [[ $attempt -ne 1 ]] ; then sleep 10 ; echo attempt $attempt ; fi
       if wget -q -P "$dout" "$url"; then
            exitcode=0
        else
            exitcode=$?
       fi
       attempt=$((attempt + 1))
       #echo $exitcode $attempt
       if [[ $exitcode -ne 0 ]] && [[ $attempt -eq 6 ]] ; then 
         echo "$(red could not find .fna of ${acc:3}, skipping...)"
         echo $acc >> $dout/failed.txt
       fi
     done
done < <(cut -f1,50 "$fin")

}
