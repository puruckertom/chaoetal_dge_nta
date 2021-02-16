p1_cel_filename <- file.path(chao_data_in,"/GSM1891992_P1.CEL")

# read the cel file into a list
p1 <- read.celfile(p1_cel_filename)
#The list has four main items. HEADER, INTENSITY, MASKS, OUTLIERS. 
#HEADER is a list. 
p1$HEADER
#Note that INTENSITY is a list of three vectors MEAN, STDEV, NPIXELS. 
p1$INTENSITY
# Both of MASKS and OUTLIERS are matrices.
p1$MASKS
p1$OUTLIERS
