library(tidyverse)

load(file = file.path('data', 'ecdc.rda'))

tbl_ecdc %>% 
  filter(population > 50e6) %>% 
  ggplot(aes(DateRep, cumulative_reported, color = country)) + 
  geom_line(show.legend = FALSE) + 
  theme_minimal()
