#[1] "feature"          "mode"             "formula"          "score"            "mass"             "rt"               "CT_1"            
#[8] "CT_2"             "CT_3"             "CT_4"             "CT_5"             "CT_6"             "CT_7"             "CT_8"            
#[15] "CT_9"             "CT_10"            "CT_11"            "CT_12"            "CT_13"            "CT_14"            "CT_15"           
#[22] "CT_16"            "CT_17"            "PE_1"             "PE_2"             "PE_3"             "PE_4"             "PE_5"            
#[29] "PE_6"             "PE_7"             "PE_8"             "PE_9"             "PE_10"            "PE_11"            "PE_12"           
#[36] "PE_13"            "PE_14"            "PE_15"            "PE_16"            "PE_17"            "PE_18"            "ct_n"            
#[43] "pe_n"             "total_n"          "fold_change"      "wilcoxrank"       "n_degs"           "n_dems"           "n_dmgs"          
#[50] "deg_score"        "dem_score"        "dmg_score"        "multiomics_score" "feature_cluster"  "selection_tier"   "chem_name"       
#[57] "chem_formula"     "schymanski"       "expression"       "methylation"   

fold_change_gt_4 <- which(chao_summary$fold_change>4)
fold_change_gt_2 <- which(chao_summary$fold_change>2)
fold_change_positive <- which(chao_summary$fold_change>0)
fold_change_negative <- which(chao_summary$fold_change<0)
interesting_rows <- which(chao_summary$fold_change>2 & chao_summary$expression>0 & chao_summary$methylation>0)

#View(chao_summary[interesting_rows,])

hist(chao_summary$multiomics_score)
hist(chao_summary[fold_change_gt_4,]$fold_change)
hist(chao_summary[fold_change_gt_2,]$fold_change)
hist(chao_summary$fold_change)

options(ggrepel.max.overlaps = Inf)
# p <- ggplot(data = chao_summary)

# interesting rows
p <- ggplot(data = chao_summary[interesting_rows,])
p_schymanski <- p +
  geom_point(aes(methylation, expression, col=schymanski)) +
  #geom_point(aes(col=schymanski), size = 3) +
  geom_text_repel(aes(methylation, expression, label=chem_name, col=schymanski), nudge_x = 0.1) +
  xlab("Methylation Score") + 
  ylab("Expression Score") +
  ggtitle("Interesting Features = non-zero expression AND non-zero methylation AND fold change > +2 /n something else") + 
  #geom_point(aes(size=fold_change)) +
  #geom_text(label=chem_name) +
  #geom_point(aes(col=schymanski), size = 3) +
  #scale_color_discrete(name = "schymanski") +
  facet_wrap(~ feature_cluster) +
  #theme_tufte()
  theme_fivethirtyeight()

chaoetal_features <- paste(chao_graphics,"/chao_interesting_features.jpg",sep="")
jpeg(chaoetal_features, width = 12, height = 7, units = "in",res=600)
  p_schymanski
dev.off()

