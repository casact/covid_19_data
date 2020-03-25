#' This script has been modified from original work found 
#' at: https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide

library(tidyverse)
library(httr)

url <- paste0(
  "https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-"
  , format(Sys.time(), "%Y-%m-%d")
  , ".xlsx")

GET(
  url
  , authenticate(":", ":", type="ntlm")
  , write_disk(tf <- tempfile(fileext = ".xlsx"))
)

tbl_ecdc <- read_excel(tf) %>% 
  rename(
    population = Pop_Data.2018
    , country = `Countries and territories`) %>% 
  select(-Day, -Month, -Year)

tbl_ecdc <- tbl_ecdc %>% 
  group_by(country) %>% 
  arrange(DateRep, .by_group = TRUE) %>% 
  mutate(
    cumulative_reported = cumsum(Cases)
    , cumulative_deaths = cumsum(Deaths)
  ) %>% 
  ungroup()

save(
  file = file.path('data', 'ecdc.rda')
  , tbl_ecdc
)
