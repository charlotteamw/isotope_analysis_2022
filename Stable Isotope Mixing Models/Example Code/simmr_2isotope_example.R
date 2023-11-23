## Example code for simmer using "geese" data set

install.packages("simmr")
library(simmr)

library(readxl)
path <- system.file("extdata", "geese_data.xls", package = "simmr")
geese_data <- lapply(excel_sheets(path), read_excel, path = path)

targets <- geese_data[[1]]
sources <- geese_data[[2]]
TEFs <- geese_data[[3]]
concdep <- geese_data[[4]]


geese_simmr <- simmr_load(
  mixtures = targets[, 1:2],
  source_names = sources$Sources,
  source_means = sources[, 2:3],
  source_sds = sources[, 4:5],
  correction_means = TEFs[, 2:3],
  correction_sds = TEFs[, 4:5],
  concentration_means = concdep[, 2:3],
  group = as.factor(paste("Day", targets$Time))
)



## biplot of samples
plot(geese_simmr,
     group = 1:8,
     xlab = expression(paste(delta^13, "C (\u2030)",
                             sep = ""
     )),
     ylab = expression(paste(delta^15, "N (\u2030)",
                             sep = ""
     )),
     title = "Isospace plot of Inger et al Geese data",
     mix_name = "Geese"
)

##this is the code to run the model
simmr_groups_out <- simmr_mcmc(geese_simmr)

##we can also use the code below instead
simmr_groups_out_ffvb <- simmr_ffvb(geese_simmr)

## simmr will automatically run the model for each group
## we can run the summary for each of the groups
summary(simmr_groups_out,
        type = "quantiles",
        group = 1
)
summary(simmr_groups_out,
        type = "quantiles",
        group = c(1, 3)
)
summary(simmr_groups_out,
        type = c("quantiles", "statistics"),
        group = c(1, 3)
)

##now plot proportions for each group

plot(simmr_groups_out,
     type = "boxplot",
     group = 2,
     title = "simmr output group 2"
)
plot(simmr_groups_out,
     type = c("density", "matrix"),
     group = 6,
     title = "simmr output group 6"
)

## we can also compare groups for the proportions of particular sources 

compare_groups(simmr_groups_out,
               source = "Zostera",
               groups = 1:2
)
compare_groups(simmr_groups_out,
               source = "Zostera",
               groups = 1:3
)




