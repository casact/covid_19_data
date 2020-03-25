library(tidyverse)

load(file.path('data', 'jhu.rda'))
tbl_by_country %>% 
  ggplot(aes(Last_Update, Confirmed, color = country)) + 
  geom_line(show.legend = FALSE)
