install.packages("MixSIAR", dependencies=TRUE)
library(MixSIAR)

mixsiar.dir <- find.package("MixSIAR")
file.path(mixsiar.dir, "example_scripts")
source(file.path(mixsiar.dir, "example_scripts", "mixsiar_script_wolves.R"))

paste0(mixsiar.dir,"/example_scripts/mixsiar_script_lake.R")

mix.filename <- system.file("extdata", "lake_consumer.csv", package = "MixSIAR")

mix <- load_mix_data(filename=mix.filename,
                     iso_names=c("d13C","d15N"),
                     factors=NULL,
                     fac_random=NULL,
                     fac_nested=NULL,
                     cont_effects="Secchi.Mixed")

# Replace the system.file call with the path to your file
source.filename <- system.file("extdata", "lake_sources.csv", package = "MixSIAR")

source <- load_source_data(filename=source.filename,
                           source_factors=NULL,
                           conc_dep=FALSE,
                           data_type="raw",
                           mix)
# Replace the system.file call with the path to your file
discr.filename <- system.file("extdata", "lake_discrimination.csv", package = "MixSIAR")

discr <- load_discr_data(filename=discr.filename, mix)
plot_data(filename="isospace_plot", plot_save_pdf=TRUE, plot_save_png=FALSE, mix,source,discr)
