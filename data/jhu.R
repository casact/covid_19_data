library(tidyverse)
library(lubridate)

read_one_day <- function(date_in) {
  
  # Must convert from standard to US
  date_in_us <- paste(
    sprintf("%02d", month(date_in))
    , sprintf("%02d", day(date_in))
    , year(date_in)
    , sep = "-")
  
  url <- paste0(
      'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/'
    , date_in_us
    , '.csv')
  
  tbl_out <- read_csv(url)
  
  names(tbl_out) <- gsub(" ", "_", names(tbl_out))
  names(tbl_out) <- gsub("/", "_", names(tbl_out))
  
  tbl_out$Last_Update = date_in
  
  tbl_out
}

convert_fips <- function(tbl_in) {
  
  if ('FIPS' %in% names(tbl_in)) {
    tbl_in$FIPS <- as.numeric(tbl_in$FIPS)
  }
  
  tbl_in
  
}

dates <- seq.Date(as.Date('2020-01-22'), as.Date('2020-03-23'), by = 'day')

lst_all <- map(dates, read_one_day)

tbl_all <- map_dfr(lst_all, convert_fips) %>%
  mutate(
    all_na_ob = is.na(Confirmed) & is.na(Deaths) & is.na(Recovered)
  ) %>% 
  filter(!all_na_ob) %>% 
  select(-all_na_ob)

tbl_countries <- tbl_all %>% 
  select(Country_Region) %>% 
  unique() %>% 
  mutate(
    country = case_when(
      Country_Region == "Taiwan*" ~ "Taiwan"
      , Country_Region == "Mainland China" ~ "China"
      , Country_Region == "Russian Federation" ~ "Russia"
      , Country_Region == "St. Martin" ~ "Saint Martin"
      , Country_Region == 'Iran (Islamic Republic of)' ~ 'Iran'
      , TRUE ~ Country_Region
    )
  )

tbl_by_country <- tbl_all %>% 
  inner_join(tbl_countries, by = 'Country_Region') %>% 
  group_by(country, Last_Update) %>% 
  summarise_at(vars(Confirmed, Deaths, Recovered), sum)

save(
  file = file.path('data', 'jhu.rda')
  , tbl_all
  , tbl_by_country
)

