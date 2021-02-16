if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("affy")

browseVignettes("affy")

library(affyio)

if(Sys.info()[4]=="DZ2626UTPURUCKE"){
  chao_root <- file.path("c:", "git", "chaoetal_dge_nta")
}
if(Sys.info()[4]=="LZ2626UTPURUCKE"){
  chao_root <- file.path("c:","git","chaoetal_dge_nta")
}


print(paste("Root directory location: ", chao_root, sep=""))

chao_data_in <- file.path(chao_root, "data_in")
chao_graphics <- file.path(chao_root, "graphics")

#check to see if directories are accessible
boo = file.exists(file.path(chao_data_in,"/GSM1891992_P1.CEL"))
print(paste("check to see if R can access cel files OK: ", boo))

