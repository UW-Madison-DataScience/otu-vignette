#################################################
#Make abundance_table.txt smaller
#M.Kamenetsky
#2020-01-08
#Update 1 (2020-01-13): Changed names of output
#datasets to reflect samples1 and samples2
#################################################
library(dplyr)
library(tidyr)

full <- read.delim("data/abundance_table.txt", header=TRUE)

#samples 1 (first viz)
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
write.csv(clean1, file="data/viz_cleansamples1.csv", row.names = FALSE)


#samples 2 (second viz)
reduced <- full %>%
    dplyr::select(taxonomy, X.OTU.ID, L1S57, L1S257, L5S203,L6S68,L3S378,L4S112) %>%
    slice(1:100)
reduced_long <- reduced %>%
    tidyr::gather(sampleid, otus, L1S57:L4S112, factor_key=TRUE) %>%
    mutate(bodysite = if_else(sampleid == "L1S57"| sampleid=="L1S257", "gut",
                              if_else(sampleid=="L5S203" | sampleid=="L6S68", "tongue",
                                      if_else(sampleid=="L3S378" | sampleid=="L4S112", "rightpalm", "NA")))) %>%
    mutate(bodysite = as.factor(bodysite)) 
clean2 <- reduced_long %>%
    dplyr::filter(otus!=0) %>%
    dplyr::select(sampleid, otus, bodysite)
write.csv(clean2, file="data/viz_cleansamples2.csv", row.names = FALSE)