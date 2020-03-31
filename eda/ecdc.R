# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

library(tidyverse)

load(file = file.path('data', 'ecdc.rda'))

tbl_ecdc %>% 
  filter(population > 50e6) %>% 
  ggplot(aes(date_rep, cumulative_reported, color = country)) + 
  geom_line(show.legend = FALSE) + 
  theme_minimal()

tbl_top_countries <- tbl_ecdc %>% 
  group_by(country) %>% 
  summarise(max_cumul = max(cumulative_reported)) %>% 
  ungroup() %>% 
  arrange(desc(max_cumul)) %>% 
  head(10)

tbl_ecdc_threshold %>% 
  inner_join(tbl_top_countries) %>% 
  ggplot(aes(days_since, cumulative_reported, color = country)) + 
  geom_line(size = 2) + 
  theme_minimal()
