# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

library(tidyverse)

load(file = file.path('data', 'covid_tracking.rda'))
load(file = file.path('data', 'us_states.rda'))

tbl_historical <- tbl_historical %>% 
  left_join(tbl_state, by = c('state' = 'state_postal'))

tbl_labels <- tbl_historical %>% 
  group_by(state) %>% 
  arrange(desc(date), .by_group = TRUE) %>% 
  slice(1)

tbl_historical %>% 
  filter(!is.na(positive_increase)) %>% 
  ggplot(aes(date, positive_increase)) + 
  geom_line(aes(color = state), show.legend = FALSE) + 
  facet_wrap(~division, scales = 'free')

tbl_historical %>% 
  filter(!is.na(positive_increase)) %>% 
  ggplot(aes(date, positive_increase)) + 
  geom_line(aes(color = state), show.legend = FALSE) + 
  geom_smooth(aes(color = state), show.legend = FALSE, se = FALSE) + 
  facet_wrap(~division, scales = 'free') + 
  geom_label(aes(label = state), data = tbl_labels)

tbl_historical %>% 
  filter(!is.na(total_test_results_increase)) %>% 
  ggplot(aes(date, total_test_results_increase)) + 
  geom_smooth(aes(color = state), show.legend = FALSE, se = FALSE) + 
  facet_wrap(~division, scales = 'free') + 
  geom_label(aes(label = state), data = tbl_labels)

tbl_historical %>% 
  arrange(desc(total_test_results_increase)) %>% 
  slice(-1) %>% 
  ggplot(aes(total_test_results_increase, positive_increase)) + 
  geom_point()

tbl_historical %>% 
  filter(!is.na(positive_increase)) %>% 
  filter(division == "South Atlantic") %>% 
  ggplot(aes(date, positive_increase)) + 
  geom_line(aes(color = state), show.legend = FALSE) + 
  geom_smooth(aes(color = state), show.legend = FALSE, se = FALSE) + 
  facet_wrap(~state, scales = 'free')

tbl_historical %>% 
  filter(!is.na(positive_increase)) %>% 
  filter(division == "West South Central") %>% 
  ggplot(aes(date, positive_increase)) + 
  geom_line(aes(color = state), show.legend = FALSE) + 
  geom_smooth(aes(color = state), show.legend = FALSE, se = FALSE) + 
  facet_wrap(~state, scales = 'free')

tbl_historical %>% 
  filter(!is.na(positive_increase)) %>% 
  filter(division == "East North Central") %>% 
  ggplot(aes(date, positive_increase)) + 
  geom_line(aes(color = state), show.legend = FALSE) + 
  geom_smooth(aes(color = state), show.legend = FALSE, se = FALSE) + 
  facet_wrap(~state, scales = 'free')

tbl_historical %>% 
  filter(!is.na(positive_increase)) %>% 
  filter(division != "Territories") %>% 
  ggplot(aes(date, positive_increase)) + 
  geom_line(aes(color = state), show.legend = FALSE) + 
  geom_smooth(aes(color = state), show.legend = FALSE, se = FALSE) + 
  facet_wrap(~state, scales = 'free')

tbl_historical %>% 
  filter(!is.na(death_increase)) %>% 
  filter(division != "Territories") %>% 
  ggplot(aes(date, death_increase)) + 
  geom_line(aes(color = state), show.legend = FALSE) + 
  geom_smooth(aes(color = state), show.legend = FALSE, se = FALSE) + 
  facet_wrap(~state, scales = 'free')

tbl_historical %>% 
  filter(!is.na(positive_increase)) %>% 
  filter(division == "South Atlantic") %>% 
  ggplot(aes(total_test_results, positive_increase)) + 
  geom_point(aes(color = state), show.legend = FALSE) + 
  facet_wrap(~state, scales = 'free')

tbl_historical %>% 
  filter(!is.na(positive_increase)) %>% 
  filter(division == 'South Atlantic') %>% 
  ggplot(aes(date, positive_increase)) + 
  geom_line(aes(color = state), show.legend = FALSE) + 
  geom_smooth(aes(color = state), show.legend = FALSE, se = FALSE) + 
  facet_wrap(~state, scales = 'free_y') + 
  geom_label(aes(label = state), data = filter(tbl_labels, division == 'South Atlantic'))

tbl_historical %>% 
  filter(!is.na(positive_increase)) %>% 
  filter(division == 'South Atlantic') %>% 
  ggplot(aes(date, positive_increase)) + 
  geom_line(aes(color = state), show.legend = FALSE) + 
  geom_smooth(aes(color = state), show.legend = FALSE, se = FALSE) + 
  geom_label(aes(label = state), data = filter(tbl_labels, division == 'South Atlantic'))
