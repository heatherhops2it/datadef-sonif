## Goal of this script is to investigate the R packages rredlist and rfishbase





# Load libraries ----------------------------------------------------------

library(rredlist)    #install.packages("rredlist")
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







#API Key Setup ------------------------------------------------
#usethis::edit_r_environ()
#IUCN_REDLIST_KEY="rlts_Kcjg1bD5qDIMXA0fROAExw7wRYgzoo0aTBTo"


# Working w Karianne 2026/10/22 -------------------------------------------

## 2026/10/22 all fish, latest assessment, only global assessments. 
df <- rl_class(class = "Actinopterygii", latest = TRUE, scope_code = 1)  #Scope code is to get global data only, not global and europe


#Karianne's code for fishbase: 

fish <- fb_tbl("species") %>% 
  mutate(sci_name = paste(Genus, Species)) %>% 
  select(sci_name, Genus, Species, FBname)

#View(fish)



## get the fish table from Karianne's code (looking at rfishbase)

## combine fish table w assessment table
df2 <- df$assessments |> 
  mutate(sci_name = taxon_scientific_name) |>    # rename columns for joining
  left_join(fish) |> 
  filter(!red_list_category_code %in% c("LC", "EX", "EW")) |>  # remove certain categories
  mutate(url = str_replace(url, pattern = "https://www.iucnredlist.org/species/", replacement = "")) |>   # get rid of extraneous info from url
  separate_wider_delim(url, names = c("url", "search_id"),delim = "/")  # separate out columns to get the number string (search_id) we need

View(df2)


# for loop to get assessment info per sp ----------------------------------

## next task: loop the search_id from df2 to look for threats and conservation actions. use rl_assessment().


#For Threats, need to repeate with conservation actions

#Karianne is not 100% sure how this code works I need to run through it 

# 1. Create a clean list to store the results
threats_list <- list()

# 2. Extract the unique IDs to loop through
unique_ids <- unique(df2$search_id)

# 3. The Loop: Just grab the data box and save it. Nothing else.
for (id in unique_ids) {
  # tryCatch handles errors by running a fallback instruction instead of crashing
  out <- tryCatch({
    rl_threats(code = id)
  }, error = function(e) {
    NULL  # If it errors out, return NULL and keep going
  })
  
  # Only save the data if 'out' successfully fetched something
  if (!is.null(out)) {
    threats_list[[as.character(id)]] = out
  }
}

# 5. Clean up the data AFTER the loop is totally done
# Grab only the "result" table from each box and stack them into one master table
threats_extracted <- bind_rows(lapply(threats_list, function(box) box$result), .id = "search_id")

# 6. Turn the ID column back into numbers so it matches df2 perfectly
threats_extracted$searxh_id <- as.numeric(threats_extracted$search_id)

# 7. Append it directly back to your original table
df2_with_threats <- left_join(df2, threats_extracted, by = "search_id")

View(df2_with_threats)
