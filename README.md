# ps209
R package for ps209 students

Provides functions useful for students of UCLA Political Science 209 in Winter 2019.  At the moment, the package 
provides only one function, `step_through_pipes`.  The purpose of `step_through_pipes` is provide a convenient way to 
see the result of each intermediate step in block of piped expressions as might constructed when manipulating 
data with `dplyr`

For example,

```{r}
library(tidyverse)
step_through_pipes({
    starwars %>%
       mutate(bmi=mass/((height/100)^2)) %>%
       select(name:mass, bmi) %>%
       filter(bmi<22) %>%
       gather(feature, value)
})
```

results in 

```
============================
. %>%
   select(name:mass, bmi)
============================
# A tibble: 6 x 4
  name           height  mass   bmi
  <chr>           <int> <dbl> <dbl>
1 Luke Skywalker    172    77  26.0
2 C-3PO             167    75  26.9
3 R2-D2              96    32  34.7
4 Darth Vader       202   136  33.3
5 Leia Organa       150    49  21.8
6 Owen Lars         178   120  37.9

======================
. %>%
   filter(bmi < 22)
======================
# A tibble: 6 x 4
  name          height  mass   bmi
  <chr>          <int> <dbl> <dbl>
1 Leia Organa      150    49  21.8
2 Chewbacca        228   112  21.5
3 Jar Jar Binks    196    66  17.2
4 Roos Tarpals     224    82  16.3
5 Ayla Secura      178    55  17.4
6 Ki-Adi-Mundi     198    82  20.9

============================
. %>%
   gather(feature, value)
============================
# A tibble: 6 x 2
  feature value        
  <chr>   <chr>        
1 name    Leia Organa  
2 name    Chewbacca    
3 name    Jar Jar Binks
4 name    Roos Tarpals 
5 name    Ayla Secura  
6 name    Ki-Adi-Mundi 

Pipe completed!
```
