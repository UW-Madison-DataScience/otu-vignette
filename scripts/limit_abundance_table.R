#################################################
#Make abundance_table.txt smaller
#M.Kamenetsky
#2020-01-08
#################################################
library(dplyr)
library(tidyr)

full <- read.delim("data/abundance_table.txt", header=TRUE)
reduced <- full %>%
    dplyr::select(taxonomy, X.OTU.ID, L1S8,L1S140,L5S155, L6S20,L2S204,L2S175) %>%
    slice(1:100)
reduced_long <- reduced %>%
    tidyr::gather(sampleid, otus, L1S8:L2S175, factor_key=TRUE) %>%
    mutate(bodysite = if_else(sampleid == "L1S8"| sampleid=="L1S140", "gut",
                              if_else(sampleid=="L5S155" | sampleid=="L6S20", "tongue",
                                      if_else(sampleid=="L2S204" | sampleid=="L2S175", "leftpalm", "NA")))) %>%
    mutate(bodysite = as.factor(bodysite)) 
clean1 <- reduced_long %>%
    dplyr::filter(otus!=0) %>%
    dplyr::select(sampleid, otus, bodysite)


