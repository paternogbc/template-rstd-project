# Script to plot linear regression model-----------------------------------
# freq ~ size * enviroment
# Gustavo Paterno
# Last update: 2019-10-21

# Start----
# Packages ----------------------------------------------------------------
library(tidyverse)
library(ggpubr)

# Load data ---------------------------------------------------------------
dat <- read.csv(file = "data/processed/processed_anura_call_data.csv")

# Check variable classes
str(dat)

# 1. Plot Linear regression-----
# Freq ~ size
p1 <- ggplot(dat, aes(y = freq_log, x = size_log)) +
  geom_point(shape = 21, size = 4, color = "black", fill = "tomato", alpha = .5) +
  geom_smooth(method = lm, fill = "gray", color = "black") +
  stat_cor(label.x = 5, size = 6) +
  stat_regline_equation(label.x = 5, label.y = 9, size = 6) +
  theme_classic(base_size = 24) +
  labs(y = "Dominant frequency (herzt) [log]",
       x = "Log snout−vent length (mm) [log]")
p1
# 2. Save plot-----
ggsave(plot = p1, 
       filename = "output/figures/Fig_01_linear_regression_freq_size.png",
       width = 8, height = 7)
# END----