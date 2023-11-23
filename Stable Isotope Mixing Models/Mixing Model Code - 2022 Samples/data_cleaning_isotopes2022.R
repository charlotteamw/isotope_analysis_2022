library(tidyverse)

targets <-read.csv("all_targets.csv", header = TRUE)
sources <- read.csv("all_sources.csv", header = TRUE)

targets$tissue <- ifelse(grepl("L$", targets$ID), "liver", 
                         ifelse(grepl("M$", targets$ID), "muscle", NA))

sources_summary <- sources %>%
  group_by(organism, location) %>%
  summarise(mean_d_13C = mean(d_13C),
            sd_d_13C = sd(d_13C),
            mean_d_15N = mean(d_15N),
            sd_d_15N = sd(d_15N),
            mean_d_2H = mean(d_2H),
            sd_d_2NH = sd(d_2H))

targets_summary <- targets %>%
  group_by(organism, location, month, tissue) %>%
  summarise(mean_d_13C = mean(d_13C),
            sd_d_13C = sd(d_13C),
            mean_d_15N = mean(d_15N),
            sd_d_15N = sd(d_15N))

write.csv(sources_summary, "sources_summary.csv", row.names = FALSE)

write.csv(targets_summary, "targets_summary.csv", row.names = FALSE)
