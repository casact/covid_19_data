# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Data was manually transcribed from https://en.wikipedia.org/wiki/List_of_regions_of_the_United_States#Census_Bureau-designated_regions_and_divisions

library(tidyverse)

tbl_state <- tibble(
  region = c(
    rep('Northeast', 9)
    , rep('Midwest', 12)
    , rep('South', 17)
    , rep('West', 13)
    , rep('Territories', 5)
  )
  , division = c(
    rep('New England', 6)
    , rep('Mid-Atlantic', 3)
    , rep('East North Central', 5)
    , rep('West North Central', 7)
    , rep('South Atlantic', 9)
    , rep('East South Central', 4)
    , rep('West South Central', 4)
    , rep('Mountain', 8)
    , rep('Pacific', 5)
    , rep('Territories', 5)
  )
  , state_postal = c(
      'CT', 'ME', 'MA', 'NH', 'RI', 'VT'
      , 'NJ', 'NY', 'PA'
      , 'IL', 'IN', 'MI', 'OH', 'WI'
      , 'IA', 'KS', 'MN', 'MO', 'NE', 'ND', 'SD'
      , 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'DC', 'WV'
      , 'AL', 'KY', 'MS', 'TN'
      , 'AR', 'LA', 'OK', 'TX'
      , 'AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY'
      , 'AK', 'CA', 'HI', 'OR', 'WA'
      , 'AS', 'GU', 'MP', 'PR', 'VI'
  )
)

tbl_state <- tbl_state %>% 
  left_join(
    tibble(
      state_postal = c(state.abb, 'DC', 'AS', 'GU', 'MP', 'PR', 'VI')
      , state_name = c(state.name, 'Washington, DC', 'American Samoa', 'Guam', 'Northern Mariana Islands', 'Puerto Rico', 'Virgin Islands')
    )
    , by = 'state_postal'
  )

save(
  file = file.path('data', 'us_states.rda')
  , tbl_state)
