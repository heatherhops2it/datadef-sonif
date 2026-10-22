## Goal of this script is to investigate the R packages rredlist and rfishbase





# Load libraries ----------------------------------------------------------

library(rredlist)   # install.packages("rredlist")
library(rfishbase)   # install.packages("rfishbase")
library(tidyverse)




# Q1: What is in rfishbase? -----------------------------------------------

## https://github.com/ropensci/rfishbase

## Note 2026/10/15 11:45 Hopper - rfishbase may take a while to access data. Estimated time to retrieve Fundulus diaphanus maturity data with 'maturity()' was 5.09 seconds.

## Note 2026/10/15 12:41 Hopper - cannot access function 'fishbase()'. This seems to be a major issue.



# Q2: What is in rredlist? ------------------------------------------------

## https://github.com/ropensci/rredlist
## You need to get an IUCN API key before you can use any of the functions in rredlist. Use function rl_use_iucn()

## Search filters on iucnredlist.org correspond to functions within rredlist




# Working w Karianne 2026/10/22 -------------------------------------------

## 2026/10/22 all fish, latest assessment, only global assessments. 
df <- rl_class(class = "Actinopterygii", latest = TRUE, scope_code = 1)

## get the fish table from Karianne's code (looking at rfishbase)

## combine fish table w assessment table
df2 <- df$assessments |> 
  mutate(sci_name = taxon_scientific_name) |>    # rename columns for joining
  left_join(fish) |> 
  filter(!red_list_category_code %in% c("LC", "EX", "EW")) |>  # remove certain categories
  mutate(url = str_replace(url, pattern = "https://www.iucnredlist.org/species/", replacement = "")) |>   # get rid of extraneous info from url
  separate_wider_delim(url, names = c("url", "search_id"),delim = "/")  # separate out columns to get the number string (search_id) we need




# for loop to get assessment info per sp ----------------------------------

## next task: loop the search_id from df2 to look for threats and conservation actions. use rl_assessment().




