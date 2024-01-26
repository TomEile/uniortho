#!/usr/bin/env Rscript

suppressPackageStartupMessages(require('tidyverse'))

#library(svglite)
args= commandArgs(trailingOnly=TRUE)
if (length(args)<4) {
  stop("Not enough arguments found, please supply pangenome, ani matrix, ani treshold and optionally an output folder", call.=FALSE)
} else if (length(args)==3) {
  # default output file
  args[4]="../results/uniquegenes.tsv"
}

ani_clean <- function(skani_filepath){

  M <- read.table(skani_filepath, skip=1, header=FALSE)
  colnames(M) <- c("V1", M$V1)
  M %>% pivot_longer(!V1, values_to="ani") %>%
    separate(V1, sep="fnas/", into=c(NA, "qseq")) %>%
    separate(name, sep="fnas/", into=c(NA, "rseq")) %>%
    separate(qseq, sep=".fna", into=c("qseq", NA)) %>%
    separate(rseq, sep=".fna", into=c("rseq", NA)) %>%
    mutate(qseq=str_sub(qseq, 1, 15), rseq=str_sub(rseq, 1, 15)) %>%
    select(qseq, rseq, ani)
}

pan_clean<-function(filepath){
  pangenome <- read.delim(filepath, header=FALSE) %>% 
    mutate(V2=str_sub(V2,1,15)) 
  colnames(pangenome)<-c("gene","genome","gene_family") 
  pangenome
}

return_pangenome <-function(anipath,panpath, treshold=99.98){
  ANI_data<-ani_clean(anipath)
   
  filtered_strains<-ANI_data %>%
    filter(ani!=100&ani>treshold) %>% 
    .$rseq
  
  #return how many there are lost give it in a print
  if(length(filtered_strains)>0){
    print(paste0("There are ",length(filtered_strains)," strains too similar and excluded from this analysis"))
  }
  pangenome<-pan_clean(panpath)
  
  genelist<-pangenome %>% 
    filter(!genome%in%filtered_strains) %>% 
    count(gene_family) %>% 
    left_join(pangenome,., by="gene_family") %>% 
    filter(genome==ANI_data$qseq[[1]][1])
  
  return(genelist)
  
}

pan<-return_pangenome(args[2],args[1], args[3])

#part to make the subset
for (g in 2:100){
  subs_temp<-pan %>%
    filter(n<g) %>%
    nrow()
  if (subs_temp<2){
    next
  }
  if(subs_temp>1){
    subset_pan<-pan %>%
      filter(n<g)
    break
  }
}

#Write all output
write_delim(pan,file=paste0(args[4], "/pangenome_count.tsv"))
write_delim(subset_pan,file=paste0(args[4], "/uniquegenes.tsv"))

#return anigraph, in the future, this can be made optional


