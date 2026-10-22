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

## Using functions like rl_class() returns list of species that fit that criterion 
df <- rl_class(class = "Actinopterygii", latest = TRUE)
