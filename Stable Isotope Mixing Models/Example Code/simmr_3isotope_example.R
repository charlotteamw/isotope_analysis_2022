
# Example data set from simmer : 3 isotopes (d13C, d15N and d34S), 30 observations, 4 sources
data(simmr_data_2)
simmr_3 <- with(
  simmr_data_2,
  simmr_load(
    mixtures = mixtures,
    source_names = source_names,
    source_means = source_means,
    source_sds = source_sds,
    correction_means = correction_means,
    correction_sds = correction_sds,
    concentration_means = concentration_means
  )
)

# Get summary
print(simmr_3)

# Plot 3 times
plot(simmr_3)
plot(simmr_3, tracers = c(2, 3))
plot(simmr_3, tracers = c(1, 3))
# See vignette('simmr') for fancier axis labels

# MCMC run
simmr_3_out <- simmr_mcmc(simmr_3)

# Print it
print(simmr_3_out)

# Summary
summary(simmr_3_out)
summary(simmr_3_out, type = "diagnostics")
summary(simmr_3_out, type = "quantiles")
summary(simmr_3_out, type = "correlations")

# Plot
plot(simmr_3_out)
plot(simmr_3_out, type = "boxplot")
plot(simmr_3_out, type = "histogram")
plot(simmr_3_out, type = "density")
plot(simmr_3_out, type = "matrix")
