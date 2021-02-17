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

keep_columns <- c(56,45, 49, 47, 48, 53, 54, 55)
chao_summary[,keep_columns]

fold_change_gt_4 <- which(chao_summary$fold_change>4)
fold_change_gt_2 <- which(chao_summary$fold_change>2)
fold_change_positive <- which(chao_summary$fold_change>0)
fold_change_negative <- which(chao_summary$fold_change<0)
really_interesting_rows <- which(chao_summary$fold_change>2 & chao_summary$n_degs>0 & chao_summary$n_dems>0 & chao_summary$n_dmgs>0)
length(really_interesting_rows)
interesting_rows_temp <- which(chao_summary$fold_change>2 & (chao_summary$n_degs + chao_summary$n_dems)>0 & chao_summary$n_dmgs>0)
length(interesting_rows_temp)
interesting_rows <- interesting_rows_temp[!(interesting_rows_temp %in% really_interesting_rows)]
length(interesting_rows)

#View(chao_summary[interesting_rows,])
chao_summary[interesting_rows,]$pe_n
chao_summary[interesting_rows,]$ct_n
chao_summary[interesting_rows,]$multiomics_score
chao_summary[interesting_rows,]$n_degs
chao_summary[interesting_rows,]$n_dems
chao_summary$n_dems + chao_summary$n_degs
chao_summary[interesting_rows,]$n_dmgs

hist(chao_summary$multiomics_score)
hist(chao_summary[fold_change_gt_4,]$fold_change)
hist(chao_summary[fold_change_gt_2,]$fold_change)
hist(chao_summary$fold_change)

#export really interesting rows and columns
chao_summary_really_interesting <- chao_summary[really_interesting_rows, keep_columns]
chao_table_really_interesting_file <- paste(chao_data_out,"/chao_really_interesting_features_table.csv",sep="")
write.csv(chao_summary_really_interesting, chao_table_really_interesting_file)

chao_summary_interesting <- chao_summary[interesting_rows, keep_columns]
chao_table_interesting_file <- paste(chao_data_out,"/chao_interesting_features_table.csv",sep="")
write.csv(chao_summary_interesting, chao_table_interesting_file)



options(ggrepel.max.overlaps = Inf)
# p <- ggplot(data = chao_summary)

# interesting rows
p <- ggplot(data = chao_summary[really_interesting_rows,])
p_schymanski <- p +
  geom_point(aes(methylation_n, expression_n, col=selection_tier)) +
  #geom_point(aes(col=schymanski), size = 3) +
  geom_text_repel(aes(methylation_n, expression_n, label=chem_name, col=selection_tier), nudge_x = 0.1) +
  xlab("Methylation Score") + 
  ylab("Expression Score") +
  ggtitle("Interesting Features = non-zero expression AND non-zero methylation AND fold change > +2",
          subtitle="Plots represent 8 k-means molecular features groups, expression and methylation axes from multiomics score components") + 
  #geom_point(aes(size=fold_change)) +
  #geom_text(label=chem_name) +
  #geom_point(aes(col=schymanski), size = 3) +
  #scale_color_discrete(name = "schymanski") +
  #facet_wrap(~ feature_cluster) +
  facet_grid(feature_cluster ~ selection_tier) +
  #theme_tufte()
  theme_fivethirtyeight()

p_schymanski

chaoetal_features <- paste(chao_graphics,"/chao_interesting_features.jpg",sep="")
jpeg(chaoetal_features, width = 12, height = 7, units = "in",res=600)
  p_schymanski
dev.off()

