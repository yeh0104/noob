library(biomaRt)

ensembl <- useMart("ENSEMBL_MART_SNP", dataset = "hsapiens_snp")

snp_list <- scan("54snp.txt", what="character")

#searchAttributes(mart = ensembl) search all the attributes in the mart

info <- getBM(attributes=c("chrom_start","chrom_end","refsnp_id"),
  filters="snp_filter", values= snp_list,
  mart=ensembl, uniqueRows=TRUE)

colnames(info) <- c("chrom_start","chrom_end","name")

write.table(info, "test.bed", row.names = T)
