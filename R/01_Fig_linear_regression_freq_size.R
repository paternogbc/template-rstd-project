# Script to plot linear regression model-----------------------------------
# freq ~ size * enviroment
# Gustavo Paterno
# Last update: 2019-10-21

# Start----
# Packages ----------------------------------------------------------------
library(tidyverse)

# Load data ---------------------------------------------------------------
dat <- read.csv(file = "data/processed/processed_anura_call_data.csv")

# Check variable classes
str(dat)

# 1. Plot Linear regression-----
# Freq ~ size
p1 <- ggplot(dat, aes(y = freq_log, x = size_log)) +
  geom_point(shape = 16, size = 3, color = "steelblue") +
  geom_smooth(method = lm, fill = "gray", color = "black") +
  theme_classic(base_size = 24) +
  labs(y = "Dominant frequency (herzt) [log]",
       x = "Log snout−vent length (mm) [log]")
p1

# 2. Save plot-----
ggsave(plot = p1, 
       filename = "output/figures/Fig_01_linear_regression_freq_size.png",
       width = 8, height = 7)
# END----