echo "# this file is located in 'src/run_download_fnas_command.sh'"
echo "# code for 'uniortho run download_fnas' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

[ -d $ddata ] || mkdir -p $ddata

wget ./../../ https://data.gtdb.ecogenomic.org/releases/release214/214.0/bac120_metadata_r214.tar.gz


#01_download_fnas.sh*
#echo $dout
#./01_download_fnas.sh $fin $dout

#if you have non-public genomes, add your own fnas files in the correct folder before running the next steps: maybe automate
#02_run_prodigal.sh*
#./02_run_prodigal.sh $fin

#03_run_pangenome.sh*
#./03_run_pangenome.sh $fin

#run fastANI on all files
#still to include

#./04_fastANI.sh $fin $id


#Rscript 05_uniquegenes.R $dout/pan/pangenome.tsv $dout/fastani/${id}_ani.txt $id

./06_fetch_genes.sh $dout

if (( $SECONDS > 3600 )) ; then
	    let hours=SECONDS/3600
	        let minutes=(SECONDS%3600)/60
		    let seconds=(SECONDS%3600)%60
		        echo "Completed in $hours hour(s), $minutes minute(s) and $seconds second(s)" 
		elif (( $SECONDS > 60 )) ; then
			    let minutes=(SECONDS%3600)/60
			        let seconds=(SECONDS%3600)%60
				    echo "Completed in $minutes minute(s) and $seconds second(s)"
			    else
				        echo "Completed in $SECONDS seconds"
fi
