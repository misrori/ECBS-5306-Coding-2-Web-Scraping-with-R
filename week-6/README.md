-   [MNB scraper](#mnb-scraper)
-   [Selenium demo](#selenium-demo)
-   [Shiny demo](#shiny-demo)

``` r
library(rvest)
library(data.table)
library(jsonlite)
library(httr)
library(XML)
library(leaflet)
```

MNB scraper
===========

Open this site and find the data source <https://fiokesatmkereso.mnb.hu/web/index.html>

``` r
head(my_df)
```

    ##    fiok atm am_megk am_haszn postak kp_fel_bankkartya nyitva_hetfo
    ## 1:    1   0       1        1      0                 1  07:30-16:30
    ## 2:    1   0       1        0      0                 1  08:00-17:00
    ## 3:    1   0       1        1      0                 1  07:45-17:00
    ## 4:    1   0       1        1      0                 1  07:30-16:30
    ## 5:    1   0       0        0      0                 1  07:30-16:30
    ## 6:    1   0       1        1      0                 1  07:30-16:30
    ##    nyitva_kedd nyitva_szerda nyitva_csutortok nyitva_pentek       orszag
    ## 1: 07:30-15:30   07:30-15:30      07:30-15:30   07:30-14:30 Magyarország
    ## 2: 08:00-15:30   08:00-15:30      08:00-15:30   08:00-14:00 Magyarország
    ## 3: 07:45-15:30   07:45-15:30      07:45-15:30   07:45-13:30 Magyarország
    ## 4: 07:30-15:30   07:30-15:30      07:30-15:30   07:30-14:30 Magyarország
    ## 5: 07:30-15:30   07:30-15:30      07:30-15:30   07:30-14:30 Magyarország
    ## 6: 07:30-15:30   07:30-15:30      07:30-15:30   07:30-14:30 Magyarország
    ##    irszam megye      varos          kozt_nev kozt_jelleg hazszam
    ## 1:   7000 Fejér  Sárbogárd         Ady Endre        utca     107
    ## 2:   7000 Fejér  Sárbogárd         Ady Endre        utca     162
    ## 3:   7000 Fejér  Sárbogárd         Ady Endre          út     170
    ## 4:   8127 Fejér        Aba     Petőfi Sándor        utca      95
    ## 5:   8124 Fejér      Káloz Bajcsy-Zsilinszky        utca       3
    ## 6:   8111 Fejér Seregélyes                Fő          út     169
    ##    center.lat center.lon nyitva_szombat emelet ajto tovabbi_adat
    ## 1:   46.88644   18.61978           <NA>   <NA> <NA>         <NA>
    ## 2:   46.88578   18.62023           <NA>   <NA> <NA>         <NA>
    ## 3:   46.88385   18.62113           <NA>   <NA> <NA>         <NA>
    ## 4:   47.02908   18.52152           <NA>   <NA> <NA>         <NA>
    ## 5:   46.95802   18.48856           <NA>   <NA> <NA>         <NA>
    ## 6:   47.11023   18.58040           <NA>   <NA> <NA>         <NA>
    ##    nyitva_vasarnap
    ## 1:            <NA>
    ## 2:            <NA>
    ## 3:            <NA>
    ## 4:            <NA>
    ## 5:            <NA>
    ## 6:            <NA>

Show your result in a map

Selenium demo
=============

Shiny demo
==========
