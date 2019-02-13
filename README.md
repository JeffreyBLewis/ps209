# ps209
R package for ps209 students

Provides functions useful for students of UCLA Political Science 209 in Winter 2019.  At the moment, the package 
provides only one function, `step_through_pipes`.  The purpose of `step_through_pipes` is provide a convenient way to 
see the result of each intermediate step in block of piped expressions as might constructed when manipulating 
data with `dplyr`

For example,

```
library(tidyverse)
    step_through_pipes({
    starwars %>%
       mutate(bmi=mass/((height/100)^2)) %>%
       select(name:mass, bmi) %>%
       filter(bmi<22) %>%
       gather(feature, value)
})
```
