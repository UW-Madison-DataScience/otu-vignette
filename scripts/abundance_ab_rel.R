#libraries required for OTU conversion from absolute to relative and filter
library("phyloseq")
library(microbiome)
library(readr)
library(dplyr)
library(OTUtable)

# import OTU table csv format
abund <- read_csv("data/computation analysis/abundance_table_tr.csv")
#OTU_ID should be in the header for selecting the OTU row
ab <- abund %>%
  select(-OTU_ID) %>%
  as.matrix
rownames(ab) <- abund$OTU_ID 
OTU = otu_table(ab, taxa_are_rows = TRUE)

# Conversion of absolute to relative abundance 
relative_ab <- microbiome::transform(OTU, "compositional")

# filter the OTU table with abundance cutoff and persistence
filtered_table <- filter_taxa(relative_ab, abundance = 0.1, persistence = 10)

#output the filtered abundance table
write.csv(filtered_table, file = "data/computation analysis/filtered_abundance_table.csv")

#plot the filtered table
barplot(filtered_table, main="Abundance table", horiz=TRUE, legend = rownames(filtered_table), cex.names=0.5)
barplot(filtered_table, main="Abundance table", cex.names=0.5, col = grey.colors(3))