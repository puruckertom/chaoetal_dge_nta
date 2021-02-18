colnames(chao_summary)
#[1] "feature"          "mode"             "formula"          "score"            "mass"             "rt"               "CT_1"            
#[8] "CT_2"             "CT_3"             "CT_4"             "CT_5"             "CT_6"             "CT_7"             "CT_8"            
#[15] "CT_9"             "CT_10"            "CT_11"            "CT_12"            "CT_13"            "CT_14"            "CT_15"           
#[22] "CT_16"            "CT_17"            "PE_1"             "PE_2"             "PE_3"             "PE_4"             "PE_5"            
#[29] "PE_6"             "PE_7"             "PE_8"             "PE_9"             "PE_10"            "PE_11"            "PE_12"           
#[36] "PE_13"            "PE_14"            "PE_15"            "PE_16"            "PE_17"            "PE_18"            "ct_n"            
#[43] "pe_n"             "total_n"          "fold_change"      "wilcoxrank"       "n_degs"           "n_dems"           "n_dmgs"          
#[50] "deg_score"        "dem_score"        "dmg_score"        "multiomics_score" "feature_cluster"  "selection_tier"   "chem_name"       
#[57] "chem_formula"     "schymanski"       "expression"       "methylation"      "expression_n"     "methylation_n"


chaoetal_group_stats <- chao_summary %>% 
  group_by(feature_cluster) %>%
  summarize(no_features = length(feature_cluster),
            detect_proportion = mean(total_n)/35,
            mean_omics = mean(multiomics_score))
chao_table_group_stats_file <- paste(chao_data_out,"/chao_group_stats_table.csv",sep="")
write.csv(chaoetal_group_stats, chao_table_group_stats_file)

#build dataset
keep_data <- c(7:41,54, 45, 42, 43, 44, 6, 5, 53, 47, 48, 49)
cluster_abundances <- chao_summary[,keep_data]
#View(cluster_abundances)
dim(cluster_abundances)
cluster_abundances$feature_means <- rowMeans(cluster_abundances[,1:35])

cluster_abundances$feature_cluster <- as.factor(cluster_abundances$feature_cluster)
cluster_abundances$feature_cluster

#abundances by cluster group
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=feature_means)) + 
  geom_boxplot()
p
chaoetal_cluster_abundances_jpg <- paste(chao_graphics,"/chaoetal_cluster_abundances.jpg",sep="")
jpeg(chaoetal_cluster_abundances_jpg, width = 6, height = 4, units = "in",res=600)
  p
dev.off()

#fold change by cluster group
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=fold_change)) + 
  geom_boxplot()
p
chaoetal_cluster_foldchanges_jpg <- paste(chao_graphics,"/chaoetal_cluster_foldchanges.jpg",sep="")
jpeg(chaoetal_cluster_foldchanges_jpg, width = 6, height = 4, units = "in",res=600)
  p
dev.off()

#total detects by cluster group
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=total_n)) + 
  geom_boxplot()
p
chaoetal_cluster_totaldetects_jpg <- paste(chao_graphics,"/chaoetal_cluster_totaldetects.jpg",sep="")
jpeg(chaoetal_cluster_totaldetects_jpg, width = 6, height = 4, units = "in",res=600)
  p
dev.off()

#total detects by cluster group for normotensive
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=ct_n)) + 
  geom_boxplot()
p

#total detects by cluster group for preeclamptic
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=pe_n)) + 
  geom_boxplot()
p

View(chao_det_freq)
colnames(chao_det_freq)

#total detects by cluster group and treatment
p <- ggplot(chao_det_freq, aes(x=cluster, y=det, fill=type)) + 
  geom_boxplot()
p
chaoetal_cluster_treatmentdetects_jpg <- paste(chao_graphics,"/chaoetal_cluster_treatmentdetects.jpg",sep="")
jpeg(chaoetal_cluster_treatmentdetects_jpg, width = 6, height = 4, units = "in",res=600)
  p
dev.off()

#retention time by cluster group
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=rt)) + 
  geom_boxplot()
p

#mass by cluster group
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=mass)) + 
  geom_boxplot()
p

#n_dmgs by cluster group
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=n_dmgs)) + 
  geom_boxplot()
p

#n_dems by cluster group
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=n_dems)) + 
  geom_boxplot()
p

#n_degs by cluster group
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=n_degs)) + 
  geom_boxplot()
p

#multiomics score by cluster group
p <- ggplot(cluster_abundances, aes(x=feature_cluster, y=multiomics_score)) + 
  geom_boxplot()
p
