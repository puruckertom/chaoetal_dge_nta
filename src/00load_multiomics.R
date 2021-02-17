
#Install and load supporting libraries.
print(Sys.info()[4])

library(dplyr)
library(ggplot2)
library(ggthemes)
library(ggrepel)

print("list of loaded packages: ")
print((.packages()))

#tom epa windows
if(Sys.info()[4]=="DZ2626UTPURUCKE"){
  chao_root <- file.path("c:", "git", "chaoetal_dge_nta")
}
if(Sys.info()[4]=="LZ2626UTPURUCKE"){
  chao_root <- file.path("c:","git","chaoetal_dge_nta")
}

print(paste("Root directory location: ", chao_root, sep=""))

chao_data_in <- file.path(chao_root, "data_in")
chao_data_out <- file.path(chao_root, "data_out")
chao_graphics <- file.path(chao_root, "graphics")

#check to see if directories are accessible
boo = file.exists(file.path(chao_data_in,"/SupplTables_v6sh3.csv"))
print(paste("check to see if R can access summary file OK: ", boo))

#load latest summary data set from Alex
chao_summary <- read.csv(file.path(chao_data_in,"/SupplTables_v6sh3.csv"), stringsAsFactors = TRUE)

#add some fields for expression and methylation
chao_summary$expression <- (chao_summary$deg_score + chao_summary$dem_score)/2
chao_summary$methylation <- chao_summary$dmg_score
chao_summary$expression_n <- (chao_summary$n_deg + chao_summary$n_dem)/2
chao_summary$methylation_n <- chao_summary$n_dmg

# turn schymanski into a factor
chao_summary$schymanski <- as.factor(as.integer(chao_summary$schymanski))
chao_summary$selection_tier <- as.factor(as.integer(chao_summary$selection_tier))

# consolidate chemical names and formulas
chao_summary$chem_name <- as.character(chao_summary$chem_name)
chao_summary$formula <- as.character(chao_summary$formula)
blank_chem_names <- which(chao_summary$chem_name=="")
chao_summary$chem_name[blank_chem_names] <- chao_summary$formula[blank_chem_names]
chao_summary$chem_name <- substr(chao_summary$chem_name, 1, 15)

#whats up
summary(chao_summary)
colnames(chao_summary)


