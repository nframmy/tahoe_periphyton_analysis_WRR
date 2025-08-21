# Script to test whether temperature and nutrient effects differed between rocks exposed to a single temperature vs. those that switched temperatures between nutrient trials

# libraries -----
library(ggplot2)
library(tidyverse)
library(lubridate)
library(broom)

# Data import ------
# dataframe with metabolic rate data, but preliminary experiment data is excluded
dat_clean <- read_csv("data/main_analysis/cleaned_rate_data.csv")

# Constant temp data
constant_temp <- dat_clean %>% 
  group_by(month, exp_ID, rock_ID) %>% 
  arrange(month, exp_ID, rock_ID) %>% 
  filter(temp_C == lag(temp_C) | temp_C == lead(temp_C))

# randomized temp data
randomized_temp <- dat_clean %>% 
  group_by(month, exp_ID, rock_ID) %>% 
  arrange(month, exp_ID, rock_ID) %>% 
  filter(temp_C != lag(temp_C) | temp_C != lead(temp_C))

# sample sizes
samp_size <- dat_clean %>% 
  group_by(month, exp_ID, rock_ID) %>% 
  arrange(month, exp_ID, rock_ID) %>% 
  mutate(temp_regime = case_when(
    temp_C != lag(temp_C) | temp_C != lead(temp_C) ~ "randomized",
    temp_C == lag(temp_C) | temp_C == lead(temp_C) ~ "constant"
    )) %>% 
  pivot_longer(c(GPP_mgO2_d_gAFDW_2, ER_mgO2_d_gAFDW_2, NEP_mgO2_d_gAFDW_2), names_to = "parameter", values_to = "value") %>% 
  group_by(temp_regime, month, parameter) %>% 
  summarise(n())

# Models ----
response_vars <- c("GPP_mgO2_d_gAFDW_2", "NEP_mgO2_d_gAFDW_2", "ER_mgO2_d_gAFDW_2")

# constant temp samples
constant_models <- response_vars %>%
  set_names() %>%   # keeps names in the output
  map(~ lm(as.formula(paste(.x, "~ temp_C + nutrient_trt + month")), data = constant_temp))


# randomized temp samples
randomized_models <- response_vars %>%
  set_names() %>%   # keeps names in the output
  map(~ lm(as.formula(paste(.x, "~ temp_C + nutrient_trt + month")), data = randomized_temp))


# Model Summaries -----
# Tidy the parameter estimates for each model set and name the model set they belong to
tidy_constant <- constant_models %>% map_dfr(tidy, .id = "response_var") %>% mutate(model_set = "Constant")

tidy_randomized <- randomized_models %>% map_dfr(tidy, .id = "response_var") %>% 
  mutate(model_set = "Randomized")

# combine data frames
all_models <- bind_rows(tidy_constant, tidy_randomized)

# Compare Estimates -----
# Create a new facet labels
new_labels <- c(
  ER_mgO2_d_gAFDW_2 = "ER",
  GPP_mgO2_d_gAFDW_2 = "GPP",
  NEP_mgO2_d_gAFDW_2 = "NEP"
)

p <- ggplot(all_models, aes(x = term, y = estimate, color = model_set)) +
  geom_point(position = position_dodge(width = 0.5)) +
  geom_errorbar(aes(ymin = estimate - std.error, ymax = estimate + std.error))+
  facet_wrap(~ response_var, scales = "free", labeller = labeller(response_var = new_labels)) +
  scale_color_discrete(name = "Temperature Regime")+
  theme_bw()+
  labs(x = "Model Parameter", y = "Estimate")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
        legend.position = "bottom")

# Figure S2 -----
ggsave("plots/final_paper/FigureS2.png", plot = p, height = 4, width = 6.5, dpi = 600)


