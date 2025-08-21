# Pineland Enriched DO data merging

# July 23, 2021
# Author: Nick Framsted
# Script Purpose: During the ER portion of the June Pineland Enriched experiment, the Tank 4 Presens instrument had issues and had to be connected to a different device which happened to have it's clock offset by 1hr 5mins relative to the original device. This script adjusts time of tank 4 Presens DO data by 1hr 5mins to account for this time discrepancy and joins this data to the master data file with data from tanks 1-3.

#Input data sets: csv containing Tank 4 ER portion dissolved oxygen data, csv containing data for tanks 1-4 for the NEP portion, and tanks 1-3 during the ER portion of the experiment.
k
#Output dataset: csv file containing all NEP and ER DO data for all tanks.





library(ggplot2)
library(tidyverse)
library(lubridate)
library(ggpubr)
library(plotly)
library(reshape2)
library(DescTools)
# changing working directory from /scripts to /tahoe_lab_inc_analysis
knitr::opts_knit$set(root.dir = '..')

# importing and cleaning up data
dat <- read_csv("data/210613_pineland_a_e/210613_pineland_enriched_tank4_O2.csv", skip = 1)
head(dat)
#View(dat)

# formatting time column to period
class(dat$Time)
dat$Time <- as.period(dat$Time)
dat$Time <- dat$Time - # subtracting 1 hr 5 mins from time col
  hours(1) - 
  minutes(5)
dat$Time <- hms::hms(dat$Time) # converting time col back to original format
#View(dat)

# Loading data from the rest of the tanks to merge with tank 4 data
dat_tanks <- read_csv("data/210613_pineland_a_e/210613_pineland_enriched_O2.csv", skip = 1)
head(dat_tanks)

# merging rows of the two dataframes
dat_whole <- bind_rows(dat_tanks, dat)
#View(dat_whole)

# exporting new data file with all DO data to data folder
write_csv(dat_whole, "data/210613_pineland_a_e/210613_pineland_e_O2_main.csv")
