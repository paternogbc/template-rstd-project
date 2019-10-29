# Script to perform ANCOVA model-------------------------------------------
# freq ~ size * enviroment
# Gustavo Paterno
# Last update: 2019-10-21

# Start----
# Packages ----------------------------------------------------------------
library(tidyverse)
library(sjPlot)

# Load data ---------------------------------------------------------------
dat <- read.csv(file = "data/processed/processed_anura_call_data.csv")

# Check variable classes
str(dat)

# 1. Fit ANOCOVA model------------------------------------------------------
mod1 <- lm(freq_log ~ size_log, data = dat)
summary(mod1)
anova(mod1)

sjPlot::tab_model(mod1)

# 2. Format tables-----------------------------------------------------------
sum_table <- broom::tidy(summary(mod1))
sum_table

ano_table <- broom::tidy(anova(mod1))
ano_table

# 3. Save tables----------------------------------------------------------------
write.csv(x = sum_table, 
          file = "output/tables/summary_table_linear_regression.csv",
          row.names = FALSE)
write.csv(x = ano_table, 
          file = "output/tables/anova_table_linear_regression.csv",
          row.names = FALSE)

# 4. Save model object----------------------------------------------------------
saveRDS(object = mod1, file = "output/temp/temp_linear_regression_model.Rds")

# END----