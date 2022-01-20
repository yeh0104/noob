rm(list=ls())
library(biomaRt)
ensembl <- useMart("ENSEMBL_MART_SNP", dataset = "hsapiens_snp")
snp_list <- scan("50snp.txt",what="character")
snp_sequence <- getBM(attributes = c("refsnp_id", "snp"), 
                      filters = c("snp_filter", "upstream_flank", "downstream_flank"), 
                      checkFilters = FALSE, 
                      values = list(snp_list,300,300), 
                      mart = ensembl, 
                      bmHeader = TRUE)

new_seq <- sub("%.*%","R",snp_sequence$'Variant sequences')
snp_sequence$Prim_seq <- new_seq
write.csv(snp_sequence,file="50snp_seq.csv", row.names=F)
