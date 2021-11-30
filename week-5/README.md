-   [Task forbes](#task-forbes)
-   [Cocktail api](#cocktail-api)
-   [What is the most common ingredient?](#what-is-the-most-common-ingredient)
-   [Skyscaner api](#skyscaner-api)
-   [Task process the Quotes table, replace the ids with names](#task-process-the-quotes-table-replace-the-ids-with-names)
-   [MNB scraper](#mnb-scraper)

``` r
library(rvest)
library(data.table)
library(jsonlite)
library(httr)
library(XML)
```

Task forbes
===========

Find the json when you load this page: <https://www.forbes.com/lists/global2000/> <br> Try with GET.

``` r
paste0(substring(content(df, 'text'), 1, 500), '.......')
```

    ## No encoding supplied: defaulting to UTF-8.

    ## [1] "\n<!doctype html>\n<html lang=\"en\">\n\t<head>\n\t\t<meta http-equiv=\"Content-Language\" content=\"en_US\">\n\n\t\t<script type=\"text/javascript\">\n\t\t\t(function () {\n\t\t\t\tfunction isValidUrl(toURL) {\n\t\t\t\t\t// Regex taken from welcome ad.\n\t\t\t\t\treturn (toURL || '').match(/^(?:https?:?\\/\\/)?(?:[^.(){}\\\\\\/]*)?\\.?forbes\\.com(?:\\/|\\?|$)/i);\n\t\t\t\t}\n\n\t\t\t\tfunction getUrlParameter(name) {\n\t\t\t\t\tname = name.replace(/[\\[]/, '\\\\[').replace(/[\\]]/, '\\\\]');\n\t\t\t\t\tvar regex = new RegExp('[\\\\?&]' + name + '=([^&#]*)');\n\t\t\t\t\tvar resu......."

Try with curl converter

``` r
head(df$organizationList$organizationsLists[1:4])
```

    ##          name year month                                    uri
    ## 1 Global 2000 2021     5                                   icbc
    ## 2 Global 2000 2021     5                         jpmorgan-chase
    ## 3 Global 2000 2021     5                     berkshire-hathaway
    ## 4 Global 2000 2021     5                china-construction-bank
    ## 5 Global 2000 2021     5 saudi-arabian-oil-company-saudi-aramco
    ## 6 Global 2000 2021     5                                  apple

Cocktail api
============

<https://www.thecocktaildb.com/api.php><br> Get all the cocktail which has vodka inside.

``` r
head(df)
```

    ##                              strDrink
    ## 1                         155 Belmont
    ## 2                            501 Blue
    ## 3 57 Chevy with a White License Plate
    ## 4                           747 Drink
    ## 5                 A Gilligan's Island
    ## 6              A midsummernight dream
    ##                                                           strDrinkThumb
    ## 1 https://www.thecocktaildb.com/images/media/drink/yqvvqs1475667388.jpg
    ## 2 https://www.thecocktaildb.com/images/media/drink/ywxwqs1461867097.jpg
    ## 3 https://www.thecocktaildb.com/images/media/drink/qyyvtu1468878544.jpg
    ## 4 https://www.thecocktaildb.com/images/media/drink/i9suxb1582474926.jpg
    ## 5 https://www.thecocktaildb.com/images/media/drink/wysqut1461867176.jpg
    ## 6 https://www.thecocktaildb.com/images/media/drink/ysqvqp1461867292.jpg
    ##   idDrink
    ## 1   15346
    ## 2   17105
    ## 3   14029
    ## 4  178318
    ## 5   16943
    ## 6   15675

What is the most common ingredient?
===================================

``` r
head(all_ing[order(-N)])
```

    ##            ingreds  N
    ## 1:           Vodka 10
    ## 2: Cranberry Juice  2
    ## 3:    Orange juice  2
    ## 4:            7-Up  1
    ## 5:           Anise  1
    ## 6:    Blue Curacao  1

Skyscaner api
=============

<https://skyscanner.github.io/slate/#api-documentation>

``` r
# tripdays <- 1:15
# origins <- list(list('c'= 'HU', 'a' = "BUD"), list('c'='MT', 'a'= 'MLA'), list('c'='ES', 'a'='BCN'), list('c'='UK', 'a'='STN'), list('c'='UK', 'a'= 'STN'))
# currency <- 'EUR'

from <- Sys.Date()+20
to <- Sys.Date()+30
origin_country <- 'HU'
currency <- 'HUF'
origin_city_id <- 'BUD'
api_key <- readRDS('/home/mihaly/R_codes/ECBS-5306-Coding-2-Web-Scraping-with-R/week-5/api_key.rds')

sky_url<-paste0("https://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/",origin_country,"/",currency,"/en-US/",origin_city_id,"-sky/Anywhere/",from,"/",to,"?apiKey=",api_key)
df <- fromJSON(sky_url, flatten = T)
head(df$Quotes)
```

    ##   QuoteId MinPrice Direct       QuoteDateTime OutboundLeg.CarrierIds
    ## 1       1    11733   TRUE 2021-11-30T12:11:00                   1090
    ## 2       2    12012   TRUE 2021-11-30T12:45:00                   1090
    ## 3       3    16914   TRUE 2021-11-30T12:53:00                   1878
    ## 4       4    18309   TRUE 2021-11-30T11:53:00                   1090
    ## 5       5    21422   TRUE 2021-11-30T12:23:00                   1090
    ## 6       6    22250   TRUE 2021-11-30T12:39:00                   1090
    ##   OutboundLeg.OriginId OutboundLeg.DestinationId OutboundLeg.DepartureDate
    ## 1                43268                     82398       2021-12-20T00:00:00
    ## 2                43268                     45336       2021-12-20T00:00:00
    ## 3                43268                     42514       2021-12-20T00:00:00
    ## 4                43268                     45436       2021-12-20T00:00:00
    ## 5                43268                     43129       2021-12-20T00:00:00
    ## 6                43268                     42414       2021-12-20T00:00:00
    ##   InboundLeg.CarrierIds InboundLeg.OriginId InboundLeg.DestinationId
    ## 1                  1090               82398                    43268
    ## 2                  1090               45336                    43268
    ## 3                  1090               42514                    43268
    ## 4                  1090               45436                    43268
    ## 5                  1878               43129                    43268
    ## 6                  1090               42414                    43268
    ##   InboundLeg.DepartureDate
    ## 1      2021-12-30T00:00:00
    ## 2      2021-12-30T00:00:00
    ## 3      2021-12-30T00:00:00
    ## 4      2021-12-30T00:00:00
    ## 5      2021-12-30T00:00:00
    ## 6      2021-12-30T00:00:00

Task process the Quotes table, replace the ids with names
=========================================================

``` r
head(dt)
```

    ##   QuoteId MinPrice Direct       QuoteDateTime OutboundLeg.CarrierIds
    ## 1       1    11733   TRUE 2021-11-30T12:11:00                Ryanair
    ## 2       2    12012   TRUE 2021-11-30T12:45:00                Ryanair
    ## 3       3    16914   TRUE 2021-11-30T12:53:00               Wizz Air
    ## 4       4    18309   TRUE 2021-11-30T11:53:00                Ryanair
    ## 5       5    21422   TRUE 2021-11-30T12:23:00                Ryanair
    ## 6       6    22250   TRUE 2021-11-30T12:39:00                Ryanair
    ##   OutboundLeg.OriginId OutboundLeg.DestinationId OutboundLeg.DepartureDate
    ## 1             Budapest                    London       2021-12-20T00:00:00
    ## 2             Budapest                Copenhagen       2021-12-20T00:00:00
    ## 3             Budapest                    Berlin       2021-12-20T00:00:00
    ## 4             Budapest                  Brussels       2021-12-20T00:00:00
    ## 5             Budapest                      Bari       2021-12-20T00:00:00
    ## 6             Budapest                 Barcelona       2021-12-20T00:00:00
    ##   InboundLeg.CarrierIds InboundLeg.OriginId InboundLeg.DestinationId
    ## 1               Ryanair               82398                    43268
    ## 2               Ryanair               45336                    43268
    ## 3               Ryanair               42514                    43268
    ## 4               Ryanair               45436                    43268
    ## 5              Wizz Air               43129                    43268
    ## 6               Ryanair               42414                    43268
    ##   InboundLeg.DepartureDate
    ## 1      2021-12-30T00:00:00
    ## 2      2021-12-30T00:00:00
    ## 3      2021-12-30T00:00:00
    ## 4      2021-12-30T00:00:00
    ## 5      2021-12-30T00:00:00
    ## 6      2021-12-30T00:00:00

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
