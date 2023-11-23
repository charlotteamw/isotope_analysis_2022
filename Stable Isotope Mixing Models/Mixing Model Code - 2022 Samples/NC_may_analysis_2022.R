library(simmr)
library(readxl)

# Specify the file path to your Excel file
path <- "C:/Users/charl/Documents/Costello_Opeongo_DataAnalysis/Isotope Analysis 2022 OpeCostello/Stable Isotope Mixing Models/Isotope Data/2022_data_alliance.xlsx"

# Read the Excel file
ope_costello <- lapply(excel_sheets(path), read_excel, path = path)

targets <- ope_costello[[1]]
sources <- ope_costello[[2]]
TEFs <- ope_costello[[3]]

may_targets <- subset(targets, month == "may")
may_sources <- subset(sources, month == "may")
may_TEFs <- subset(TEFs, month == "may")

may_simmr <- simmr_load(
  mixtures = may_targets[, 1:2],
  source_names = may_sources$Sources,
  source_means = may_sources[, 4:5],
  source_sds = may_sources[, 6:7],
  correction_means = may_TEFs[, 4:5],
  correction_sds = may_TEFs[, 6:7],
  group = as.factor(paste(may_targets$location,  may_targets$tissue))
)

group_names <- levels(may_simmr$group)
print(group_names)

## Model for May samples
may_simmr_out <- simmr_mcmc(may_simmr)
summary(may_simmr_out)

################################################################################

## Bi-plots for May samples
## Sources not combined

## Creek Caught Fish
#liver
plot(may_simmr_out$input, group = c(1))

#muscle
plot(may_simmr_out$input, group = c(2))



## Lake Caught fish
#liver
plot(may_simmr_out$input, group = c(3))
#muscle
plot(may_simmr_out$input, group = c(4))



## Creek caught Creek Chub
#liver
plot(may_simmr_out$input, group = 3)
#muscle
plot(may_simmr_out$input, group = 4)


## Lake caught Creek Chub
#liver
plot(may_simmr_out$input, group = 16)

#muscle
plot(may_simmr_out$input, group = 17)



## Creek caught Golden Shiner
#liver
plot(may_simmr_out$input, group = 5)
#muscle
plot(may_simmr_out$input, group = 6)

## Lake caught Golden Shiner
#liver
plot(may_simmr_out$input, group = 18)
#muscle
plot(may_simmr_out$input, group = 19)



## Lake caught Pearl Dace
#liver
plot(may_simmr_out$input, group = 8)
#muscle
plot(may_simmr_out$input, group = 9)



## Lake caught BNM
#liver
plot(may_simmr_out$input, group = 12)
#muscle
plot(may_simmr_out$input, group = 13)



## Lake caught SMB
#liver
plot(may_simmr_out$input, group = 20)
#muscle
plot(may_simmr_out$input, group = 21)

###############################################################################

# Combine lake sources
may_simmr_com_source <- combine_sources(may_simmr_out,
                                        to_combine = c("odonate_lk_may", "mussel_lk_may", "mayfly_lk_may"),
                                        new_source_name = "may_lk_inverts"
)

# Combine creek sources
may_simmr_com_source1 <- combine_sources(may_simmr_com_source,
                                         to_combine = c("odonate_cr_may", "mussel_cr_may", "mayfly_cr_may"),
                                         new_source_name = "may_cr_inverts"
)

## Bi-plots for May samples
## Combined sources

## Creek Caught Common Shiner
# liver
plot(may_simmr_com_source1$input, group = 1)
## proportion of sources in diet for creek caught common shiner liver
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: creek caught common shiner liver diet proportions", 
     group = 1
)

# muscle
plot(may_simmr_com_source1$input, group = 2)
## proportion of sources in diet for creek caught common shiner muscle
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: creek caught common shiner muscle diet proportions", 
     group = 2
)



## Lake Caught Common Shiner
#liver
plot(may_simmr_com_source1$input, group = 14)
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: lake caught common shiner liver diet proportions", 
     group = 14
)
#muscle
plot(may_simmr_com_source1$input, group = 15)
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: lake caught common shiner muscle diet proportions", 
     group = 15
)


## Creek caught Creek Chub
#liver
plot(may_simmr_com_source1$input, group = 3)
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: creek caught creek chub liver diet proportions", 
     group = 3
)

#muscle
plot(may_simmr_com_source1$input, group = 4)
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: creek caught creek chub muscle diet proportions", 
     group = 4
)

## Lake caught Creek Chub
#liver
plot(may_simmr_com_source1$input, group = 16)
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: lake caught creek chub liver diet proportions", 
     group = 16
)
#muscle
plot(may_simmr_com_source1$input, group = 17)
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: lake caught creek chub muscle diet proportions", 
     group = 17
)


## Creek caught Golden Shiner
#liver
plot(may_simmr_com_source1$input, group = 5)
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: creek caught golden shiner liver diet proportions", 
     group = 5
)
#muscle
plot(may_simmr_com_source1$input, group = 6)
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: creek caught golden shiner muscle diet proportions", 
     group = 6
)

## Lake caught Golden Shiner
#liver
plot(may_simmr_com_source1$input, group = 18)
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: lake caught golden shiner liver diet proportions", 
     group = 18
)
#muscle
plot(may_simmr_com_source1$input, group = 19)
plot(may_simmr_com_source1,
     type = "boxplot",
     title = "simmr output: lake caught golden shiner muscle diet proportions", 
     group = 19
)



## Lake caught Pearl Dace
#liver
plot(may_simmr_com_source1$input, group = 8)
#muscle
plot(may_simmr_com_source1$input, group = 9)



## Lake caught BNM
#liver
plot(may_simmr_com_source1$input, group = 12)
#muscle
plot(may_simmr_com_source1$input, group = 13)



## Lake caught SMB
#liver
plot(may_simmr_com_source1$input, group = 20)
#muscle
plot(may_simmr_com_source1$input, group = 21)

################################################################################
##Combined targets (common shiner, golden shiner, and creek chub)

target_organisms <- c("creek chub", "golden shiner", "common shiner")

# Create a new grouping variable to combine the organisms
combined_group <- ifelse(may_targets$organism %in% target_organisms, paste(may_targets$location, "migratory_cyprinids", may_targets$tissue, sep = "_"), paste(may_targets$location, may_targets$organism, may_targets$tissue, sep = "_"))

# Update the simmr_load function to use the combined_group variable
migratory_simmr <- simmr_load(
  mixtures = may_targets[, 1:2],
  source_names = may_sources$Sources,
  source_means = may_sources[, 4:5],
  source_sds = may_sources[, 6:7],
  correction_means = may_TEFs[, 4:5],
  correction_sds = may_TEFs[, 6:7],
  group = as.factor(combined_group)
)

# Print updated group names
group_names <- levels(migratory_simmr$group)
print(group_names)


## Model for May samples
may_migratory_simmr_out <- simmr_mcmc(migratory_simmr)
summary(may_migratory_simmr_out)


# Combine lake sources
may_simmr_migratory_combined_source <- combine_sources(may_migratory_simmr_out,
                                        to_combine = c("odonate_lk_may", "mussel_lk_may", "mayfly_lk_may"),
                                        new_source_name = "may_lk_inverts"
)

# Combine creek sources
may_simmr_migratory_combined_source1 <- combine_sources(may_simmr_migratory_combined_source,
                                         to_combine = c("odonate_cr_may", "mussel_cr_may", "mayfly_cr_may"),
                                         new_source_name = "may_cr_inverts"
)

## Bi-plots for May samples
## Combined sources

## Creek Caught Cyprinids
# liver
plot(may_simmr_migratory_combined_source1$input, group = 1)

## proportion of sources in diet for creek caught cyprinid liver
plot(may_simmr_migratory_combined_source1,
     type = "boxplot",
     title = "simmr output: creek caught cyprinids - liver diet proportions", 
     group = 1
)


# muscle
plot(may_simmr_migratory_combined_source1$input, group = 2)
## proportion of sources in diet for creek caught cyprinid muscle
plot(may_simmr_migratory_combined_source1,
     type = "boxplot",
     title = "simmr output: creek caught cyprinids - muscle diet proportions", 
     group = 2
)

## Lake Caught Cyprinids
# liver
plot(may_simmr_migratory_combined_source1$input, group = 10)

## proportion of sources in diet for lake caught cyprinid liver
plot(may_simmr_migratory_combined_source1,
     type = "boxplot",
     title = "simmr output: lake caught cyprinids - liver diet proportions", 
     group = 10
)

# muscle
plot(may_simmr_migratory_combined_source1$input, group = 11)
## proportion of sources in diet for lake caught cyprinid muscle
plot(may_simmr_migratory_combined_source1,
     type = "boxplot",
     title = "simmr output: lake caught cyprinids - muscle diet proportions", 
     group = 11
)


## Lake Caught BNMs
# liver
plot(may_simmr_migratory_combined_source1$input, group = 8)

## proportion of sources in diet for lake caught BNM liver
plot(may_simmr_migratory_combined_source1,
     type = "boxplot",
     title = "simmr output: lake caught BNM - liver diet proportions", 
     group = 8
)

# muscle
plot(may_simmr_migratory_combined_source1$input, group = 9)
## proportion of sources in diet for lake caught BNM muscle
plot(may_simmr_migratory_combined_source1,
     type = "boxplot",
     title = "simmr output: lake caught BNM - muscle diet proportions", 
     group = 9
)

