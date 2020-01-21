install.packages(c("ggplot2",
                   "dplyr",
                   "tidyr", 
                   "readr", 
                   "OTUtable"))

if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
BiocManager::install("microbiome")
BiocManager::install("phyloseq")
