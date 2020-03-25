library(tidyverse)

load(file = file.path('data', 'ecdc.rda'))

tbl_ecdc %>% 
  filter(population > 50e6) %>% 
  ggplot(aes(DateRep, cumulative_reported, color = country)) + 
  geom_line(show.legend = FALSE) + 
  theme_minimal()

tbl_threshold <- tbl_ecdc %>% 
  group_by(country) %>% 
  filter(cumulative_reported >= 100) %>% 
  arrange(DateRep, .by_group = TRUE) %>% 
  mutate(
    days_since = difftime(DateRep, head(DateRep, 1), units = "days") %>% as.numeric()
  ) %>% 
  ungroup()

tbl_top_countries <- tbl_ecdc %>% 
  group_by(country) %>% 
  summarise(max_cumul = max(cumulative_reported)) %>% 
  ungroup() %>% 
  arrange(desc(max_cumul)) %>% 
  head(10)

tbl_threshold %>% 
  inner_join(tbl_top_countries) %>% 
  ggplot(aes(days_since, cumulative_reported, color = country)) + 
  geom_line() + 
  theme_minimal()
