# tahoe_lab_inc_analysis
## Analysis of laboratory incubations of periphyton collected from Lake Tahoe as part of a project funded by the Lahontan Regional Water Quality Board.


*R Session Info:*
R version 4.2.2 (2022-10-31 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 26100)

Matrix products: default

locale:
[1] LC_COLLATE=English_United States.utf8 
[2] LC_CTYPE=English_United States.utf8   
[3] LC_MONETARY=English_United States.utf8
[4] LC_NUMERIC=C                          
[5] LC_TIME=English_United States.utf8    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
[1] compiler_4.2.2 tools_4.2.2  

### Important Scripts

**Exporting QAQC'd Metabolism Data:**
- "Tahoe_Peri_data_joining.Rmd"

**Figure 1 Code**
*Contains Code for Fig 1 e-f*
- "Fig1d.Rmd"
- "Fig1e_f.Rmd"

**Metabolism Data Prep and Site Descriptive Plots:**
*Contains Figs 2 & 3*
- "Tahoe_Peri_in_situ_conditions.Rmd"

**Statistical Modeling**
*Contains Fig 4, and data contained in Table 1*
- "Tahoe_Peri_model_building.Rmd"

**Nutrient Uptake Data Analysis**
*Contains Figs 5-7*
- "Tahoe_Peri_nut_uptake_analysis.Rmd"

**All other scripts**
- "main_background_metab_analysis.R" is an analysis of background nutrient uptake rates from phytoplankton and bacterioplankton in experiments.

- "temp_randomization_analysis" is an analysis of if randomization of warming treatments on periphyton samples could have resulted in thermal shock.


All other scripts with filenames that begin with a date are individual files to parse and wrangle individual experiment data files before being joined together in "Tahoe_Peri_data_joining.Rmd".



#####################
### Metadata for "main_data_lahontan.csv"
#### Column Meanings:
Chamber: Chamber ID #

temp_C: temperature treatment in degrees C

total_DW_g: total periphyton dry weight in grams

rock_SA_m2: surface area of rock in square meters

NEP_mg_d, ER_mg_d, GPP_mg_d: raw, non-normalized periphyton metabolic rates in mg oxygen produced/consumed per day

treatment: temperature treatment coded as a factor for separate statistical analyses

GPP_mgO2_d_m2, NEP_mgO2_d_m2, ER_mgO2_d_m2: periphyton metabolic rates in mg of oxygen produced/consumed per day per square meter

nutrient_treatment: nutrient treatment applied (ambient = no nutrients added, enriched = nutrients added to 6.5 times average groundwater concentrations)

nutrients: numerical variable for nutrient treatment (0 = ambient, 1 = enriched)

NO3_N_ug_L_initial: initial concentration of nitrate and nitrite in water used to fill metabolic chambers; expressed as micrograms N per liter

NH4_N_ug_L_initial: initial concentration of ammonium in water used to fill metabolic chambers; expressed as micrograms N per liter

SRP_ug_L_initial: initial concentration of soluble reactive phosphorus (phosphate) in water used to fill metabolic chambers; expressed as micrograms P per liter

DP_ug_L_initial: initial concentration of dissolved phosphorus in water used to fill metabolic chambers; expressed as micrograms P per liter

exp_ID: unique ID number assigned to each individual experiment for statistical analysis purposes

rock_ID: unique ID number assigned to each individual rock for statistical analysis purposes

total_chla_ug: total amount of chlorophyll-a on the sample rock in micrograms

date: date the rocks were harvested for the experiment

total_AFDW_g_2: total ash-free dry weight of periphyton in grams

GPP_mgO2_d_gAFDW_2, NEPmgO2_d_gAFDW_2, ER_mgO2_d_gAFDW_2: periphyton metabolic rates in milligrams of oxygen produced/consumed per day per gram of periphyton ash-free dry weight

AI: autotrophic index calculated as the ratio between AFDW:Chl-a

periphyton_PP_ug_L: periphyton particulate phosphorus in micrograms per liter (only available for 3/1/21 experiment as methods were changed for subsequent experiments)

periphyton_PP_ug_g: periphyton particulate phosphorus expressed in micrograms per gram of periphyton

periphyton_particulate_N_ug_g: periphyton particulate nitrogen concentration expressed in micrograms per gram of periphyton

periphyton_particulate_C_ug_g: periphyton particulate carbon concentration expressed in micrograms per gram of periphyton

periphyton_particulate_N_ug_L: periphyton particulate nitrogen concentration expressed in micrograms per liter of periphyton slurry filtered (only for 3/1/21 samples before methods were changed)

periphyton_particulate_C_ug_L: periphyton particulate carbon concentration expressed in micrograms per liter of periphyton slurry filtered (only for 3/1/21 samples before methods were changed)

NO3_N_final: post-experiment concentration of nitrate in chambers (only applicable to enriched chambers) which was used to calculate nutrient uptake rates. Units are micrograms N per liter.

NH4_N_final: post-experiment concentration of ammonium in chambers (only applicable to enriched chambers) which was used to calculate nutrient uptake rates. Units are micrograms N per liter.

SRP_final: post-experiment concentration of soluble reactive phosphorus in chambers (only applicable to enriched chambers) which was used to calculate nutrient uptake rates. Units are micrograms P per liter.

DP_final: post-experiment concentration of dissolved phosphorus in chambers (only applicable to enriched chambers) which was used to calculate nutrient uptake rates. Units are micrograms P per liter.


NO3_rate: periphyton uptake rate of nitrite and nitrate in micrograms N per hour per gram of periphyton ash-free dry weight

NH4_rate: periphyton uptake rate of ammonium in micrograms N per hour per gram of ash-free dry weight

SRP_rate: periphyton uptake rate of soluble reactive phosphorus in micrograms P per hour per gram of ash-free dry weight

DP_rate: periphyton uptake rate of dissolved phosphorus in micrograms of P per hour per gram of ash-free dry weight

###############


**Individual experiment datasheet column meanings:**

drained_wt_g: weight in grams of chamber and rock with no water

filled_wt_g: same as above, but with water added to chamber

Tank_a: ambient experiment tank #

Tank_e: enriched experiment tank #

water_wt_g: weight in grams of water inside chamber

water_vol_L: volume of water in chamber in liters

total_wet_wt_g: total wet weight of periphyton harvested from rock in grams

PP_wt_g, chla_wt_g, PC_PN_wet_wt_g: wet weight (in grams) subsamples of periphyton for each specific analysis

PC_PN_tin_wt_g, AFDW_tin_wt_g: weights of pre-tared sample containers for PCPN and AFDW

SWW_g: sediment wet weight (grams) of AFDW subsample

SDW_60C_g: sediment dry weight (grams) of AFDW subsample after drying at 60C for 24 hrs

SCW_500C_g: sediment combusted weight (grams) of AFDW subsample after combusting at 500C for 1hr

total_DW_g: total dry weight (grams) of periphyton scaled up to the whole rock

total_AFDW_g: total ash-free dry weight (grams) of periphyton scaled up to the whole rock (using methods from Scott Hackley of TERC; AFDW = SDW_60C-SCW_500C)

rock_SA_m2: rock surface area covered by periphyton in sq. meters approximated as an ellipsoid and assuming an average periphyton coverage of 67% 