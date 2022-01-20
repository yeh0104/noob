#Always start with a nice and clean workspace
rm(list=ls())
library(biomaRt) #load library
ensembl <- useMart("ENSEMBL_MART_SNP", dataset = "hsapiens_snp") #set database
snp_list <- scan("50snp.txt",what="character") #create an object for the txt file containing SNP ids
snp_sequence <- getBM(attributes = c("refsnp_id", "snp"), 
                      filters = c("snp_filter", "upstream_flank", "downstream_flank"), 
                      checkFilters = FALSE, 
                      values = list(snp_list,300,300), #query sequence 300 upstream and downstream of the SNP site
                      mart = ensembl, 
                      bmHeader = TRUE)

new_seq <- sub("%.*%","R",snp_sequence$'Variant sequences') #remove all the characters, starting from % and end with %. Then replace with the letter R
snp_sequence$Prim_seq <- new_seq #create a column with the object new_seq in the data.frame snp_sequence and name it as "Prim_seq"
write.csv(snp_sequence,file="50snp_seq.csv", row.names=F) #export csv without title
