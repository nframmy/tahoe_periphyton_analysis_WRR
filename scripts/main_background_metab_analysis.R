# Script to investigate whether background metabolism (due to either phytoplankton or bacterioplankton remaining in the filtered water) would affect the oxygen mass balance and thus the metabolic rate calculations of the periphyton. We confirmed that background metabolic rates were low and this was not a significant source of error.


library(ggplot2)
library(tidyverse)
library(lubridate)
library(ggpubr)
library(plotly)
library(reshape2)
library(DescTools)

# changing working directory from /scripts to /tahoe_lab_inc_analysis
knitr::opts_knit$set(root.dir = '..')

# loading in dataframes
aug <- read_csv("data/210808_pineland_a_e/aug_background_rates.csv")
aug$jar <- as.factor(aug$jar)
aug <- aug %>%
  mutate(month = rep("August", 8)) # adding month column

oct <- read.csv("data/211010_pineland_a_e/oct_background_rates.csv")
oct <- oct %>%
  mutate(month = rep("October", 8)) # adding month column
oct$jar <- as.factor(oct$jar)

nov <- read.csv("data/211128_pineland_a_e/nov_background_rates.csv")
nov <- nov %>%
  mutate(month = rep("November", 8)) # adding month column
nov$jar <- as.factor(nov$jar)

feb <- read_csv("data/220227_pineland_a_e/feb_background_rates.csv")
feb <- feb %>%
  mutate(month = rep("February", 8)) # adding month column
feb$jar <- as.factor(feb$jar)


# combining dataframes
combine <- bind_rows(aug, oct, nov, feb)

# converting dataframe from wide to long format to plot multiple y variables
combine <- combine %>%
  rename(GPP = avg_GPP, ER = avg_ER) %>% # renaming columns for plotting
  pivot_longer(cols = c(GPP, ER),
                        names_to = "rate_type",
                        values_to = "rate",
                        values_drop_na = T)
combine_export <- combine %>%
  pivot_wider(names_from = "rate_type", values_from = "rate")

######## Table S2 --------
 
write_csv(combine_export, "data/background_metab_rates.csv")

# computing average background GPP and ER rates
combine_export %>%
  #group_by(month) %>%
  summarize(avg_GPP = mean(GPP), avg_ER = mean(ER))

# plotting results of background metabolic rates
bkgrd_plot <- combine %>%
  ggplot(aes(x = temp, y = rate, color = treatment, shape = month)) +
  facet_grid(rows = vars(rate_type)) +
  geom_point() +
  geom_hline(aes(yintercept = 0)) +
  theme_classic() +
  labs(x = expression('Temperature (\u00B0C)'),
       y = expression(Background~Rates~(mgO[2]~day^{-1}~chamber^{-1})))

# saving plot
ggsave("plots/background_rate_analysis/background_metab_plot.png", plot = bkgrd_plot, height = 4, width = 7, dpi = 300)
