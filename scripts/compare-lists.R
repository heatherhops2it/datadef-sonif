## Goal of this script is to input the Appendix 1 from Cazalis et al. (2023) and cross-compare the DD fishes on it to the soniferous species list from Looby et al. (2023).
## Cazalis et al 2023: https://doi.org/10.1111/cobi.14139
## Looby et al 2023: https://doi.org/10.1038/s41597-023-02745-4



# Load libraries ----------------------------------------------------------

library(tidyverse)   # install.packages("tidyverse")
library(janitor)   # install.packages("janitor")



# Load in, clean Cazalis data ---------------------------------------------

cazalis <- read_csv("raw-data/cobi14139-0001-appendixs1.csv") |> 
  clean_names() |> 
  filter(group == "Fish") |>    # only fish
  filter(dd == "TRUE") |>     # only DD
  filter(zoos == "TRUE") |>     # only those in zoos
  mutate(taxon = scientific_name)
  
  separate(scientific_name, into = c("genus", "species"), sep = " ")


# Load in, clean Looby data -----------------------------------------------

looby <- read_csv("raw-data/Underwater Sonifery Data.csv") |> 
  clean_names()
  

# Combine datasheets ------------------------------------------------------

df_merged <- left_join(cazalis, looby, by = "taxon") |>   # combined by genus/species
    select(dd, zoos, prio_ds, taxo, taxo_valid, taxon_aphia_id, taxon, soniferous_category, reference_aphia_id) |>  # I don't want to see so many columns :dizzy:
    mutate(son_cat = soniferous_category)
  



# Graphing? ---------------------------------------------------------------
## to get a quick visual on the number of species that are DD, in zoos, and in different sound production categories
df_merged |> ggplot(aes(x = soniferous_category)) +
    geom_histogram(stat = "count") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 14)) +
    scale_x_discrete(labels = c("Unlikely", "Likely", "Active and passive", "Active", "Passive", "Unknown/undetermined", "NA")) 
  
  
  
