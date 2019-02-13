# ps209
An R package for ps209 students

Provides functions useful for students of UCLA Political Science 209 in Winter 2019.  At the moment, the package 
provides only one function, `step_through_pipes`.  The purpose of `step_through_pipes` is to provide a convenient way to 
see the head of the result of each intermediate step in a block of piped expressions as might be constructed when manipulating 
data with `dplyr`.  The code is still being perfected and somtimes it will fail when faced with complex pipes that are difficult to parse.

here is an example of `step_through_pipes` in action,

```{r}
library(tidyverse)
thin_character_dat <- step_through_pipes({
    starwars %>%
       mutate(bmi=mass/((height/100)^2)) %>%
       select(name:mass, bmi) %>%
       filter(bmi<22) %>%
       gather(feature, value)
})
```

results in 

```
Stepping through pipes:
===========================================
. %>% mutate(bmi = mass/((height/100)^2))
===========================================
# A tibble: 6 x 14
  name  height  mass hair_color skin_color eye_color birth_year
  <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl>
1 Luke…    172    77 blond      fair       blue            19  
2 C-3PO    167    75 NA         gold       yellow         112  
3 R2-D2     96    32 NA         white, bl… red             33  
4 Dart…    202   136 none       white      yellow          41.9
5 Leia…    150    49 brown      light      brown           19  
6 Owen…    178   120 brown, gr… light      blue            52  
# … with 7 more variables: gender <chr>, homeworld <chr>,
#   species <chr>, films <list>, vehicles <list>,
#   starships <list>, bmi <dbl>

===============================
. %>% select(name:mass, bmi)
===============================
# A tibble: 6 x 4
  name           height  mass   bmi
  <chr>           <int> <dbl> <dbl>
1 Luke Skywalker    172    77  26.0
2 C-3PO             167    75  26.9
3 R2-D2              96    32  34.7
4 Darth Vader       202   136  33.3
5 Leia Organa       150    49  21.8
6 Owen Lars         178   120  37.9

=========================
. %>% filter(bmi < 22)
=========================
# A tibble: 6 x 4
  name          height  mass   bmi
  <chr>          <int> <dbl> <dbl>
1 Leia Organa      150    49  21.8
2 Chewbacca        228   112  21.5
3 Jar Jar Binks    196    66  17.2
4 Roos Tarpals     224    82  16.3
5 Ayla Secura      178    55  17.4
6 Ki-Adi-Mundi     198    82  20.9

======================================
. %>% gather(feature, value, -name)
======================================
# A tibble: 6 x 3
  name          feature value
  <chr>         <chr>   <dbl>
1 Leia Organa   height    150
2 Chewbacca     height    228
3 Jar Jar Binks height    196
4 Roos Tarpals  height    224
5 Ayla Secura   height    178
6 Ki-Adi-Mundi  height    198

==========----==================
. %>%  arrange(name, feature)
================================
# A tibble: 6 x 3
  name        feature value
  <chr>       <chr>   <dbl>
1 Adi Gallia  bmi      14.8
2 Adi Gallia  height  184  
3 Adi Gallia  mass     50  
4 Ayla Secura bmi      17.4
5 Ayla Secura height  178  
6 Ayla Secura mass     55  

Pipes completed!
```
