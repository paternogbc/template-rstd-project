# Exploratory analysis of study variables
# Gustavo Paterno
# Last update: 2019-10-28


# Load packages -----------------------------------------------------------
library(tidyverse)
library(cowplot)

# Load data ---------------------------------------------------------------
d <- read.csv("data/processed/processed_anura_call_data.csv")


# 1. Statistical dsitribution of variables---------------------------------
var_stats <-
  data.frame(
  var = c("Dominant Frequency", "Snout-vent length"),
  avg      = round(c(mean(d$freq), mean(d$size)), digits = 1),
  sd       = round(c(sd(d$freq), sd(d$size)), digits = 1),
  min      = c(min(d$freq), min(d$size)),
  max      = c(max(d$freq), max(d$size))
)
var_stats

# 2. Distribution of numeric variables ------------------------------------

# 2.1 Dominant frequency------
g1 <-
  ggplot(d, aes(x = freq)) +
  geom_histogram(fill = "steelblue", color = "white") +
  theme_classic(base_size = 18) +
  labs(x = "Dominant frequency (hertz)",
       y = "Number of species")

# 2.2 Dominant frequency (log)------
g2 <-
  ggplot(d, aes(x = freq)) +
  geom_histogram(fill = "steelblue", color = "white") +
  scale_x_continuous(trans = "log10") +
  theme_classic(base_size = 18) +
  labs(x = "Dominant frequency (hertz)[log10]",
       y = "Number of species")

# 3.1 Body size------
g3 <-
  ggplot(d, aes(x = size)) +
  geom_histogram(fill = "darkgreen", color = "white", alpha = .7) +
  theme_classic(base_size = 18) +
  labs(x = "Snout-vent length (mm)",
       y = "Number of species")
g3

# 3.2 Dominant frequency (log)------
g4 <-
  ggplot(d, aes(x = size)) +
  geom_histogram(fill = "darkgreen", color = "white", alpha = .7) +
  scale_x_continuous(trans = "log10") +
  theme_classic(base_size = 18) +
  labs(x = "Snout-vent length (mm)[log10]",
       y = "Number of species")

# 4. All figures togther-----
gall <- plot_grid(g1, g2, g3, g4, labels = c("A", "B", "C", "D"))
gall

# 5. Export table---------------
write.csv(x = var_stats, file = "output/supp/Stab_descripive_stats_study_variables.csv", 
          row.names = FALSE)
# 6. Export figure---------------
ggsave(filename = "output/supp/Sfig_exploratory_analysis_study_variables.png",
       plot = gall, width = 12, height = 8)
