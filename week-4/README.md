-   <a href="#tables-jsons-in-htmls" id="toc-tables-jsons-in-htmls">Tables,
    jsons in htmls</a>
-   <a href="#jsonlite" id="toc-jsonlite">Jsonlite</a>
-   <a href="#json-in-html-document-payscale"
    id="toc-json-in-html-document-payscale">Json in html document
    payscale</a>
-   <a href="#get-post" id="toc-get-post">GET &amp; POST</a>
-   <a href="#task-exchange-rate" id="toc-task-exchange-rate">Task exchange
    rate</a>
-   <a href="#nasdaq-data" id="toc-nasdaq-data">Nasdaq data</a>

``` r
library(rvest)
library(data.table)
library(jsonlite)
library(httr)
library(tidyverse)
```

# Tables, jsons in htmls

``` r
t <-read_html('https://www.yachtworld.co.uk/yacht/1989-palmer-johnson-motorsailer-8587552/')
all <- rbindlist(t %>% html_table())

all <- all[!duplicated(all)]
df<- data.table(all %>%
  pivot_wider(names_from = X1, values_from = X2)
)


json_data <- 
  fromJSON(
    t %>%
      html_node(xpath = "//script[@type='application/ld+json']")%>%
      html_text()
  )

data_list <- t %>%
  html_nodes(xpath = "//script[@type='application/ld+json']")%>%
  html_text()

fromJSON(
  data_list[2]  
)
```

# Jsonlite

``` r
t_list <- fromJSON('{"first_json": "hello ceu", "year":2021, "class":"BA"} ')

# with nested dfs use , flatten = T

toJSON(t_list)

toJSON(t_list, auto_unbox = T)
toJSON(t_list, auto_unbox = T, pretty = T)
```

# Json in html document payscale

``` r
t <- read_html('https://www.payscale.com/research/US/Job=Product_Manager%2C_Software/Salary')


td  <- fromJSON(t %>%
                        html_nodes(xpath = "//script[@type='application/json']")%>%
                        html_text()
)

# toJSON(td, pretty = T, auto_unbox = T)
# toJSON(td2, pretty = T, auto_unbox = T)

# http://jsonviewer.stack.hu/
```

# GET & POST

``` r
# https://github.com/daroczig/CEU-R-mastering

# https://exchangerate.host/#/#our-services

# https://www.youtube.com/watch?v=UObINRj2EGY


url <- 'https://api.exchangerate.host/convert?from=USD&to=EUR'
data <- fromJSON(url)
print(data)

t <- GET('https://api.exchangerate.host/convert', query=list(from="USD", to="EUR"))



t <- fromJSON(content(t, "text"))

t <- GET('https://api.exchangerate.host/convert', query=list(from="USD", to="EUR"), verbose(info = T))

t
```

# Task exchange rate

<a href="https://exchangerate.host/#/#our-services"
class="uri">https://exchangerate.host/#/#our-services</a> Write a
function which will return exchange rates, inputs: `start_date`,
`end_date`, `base`, `to`. Check Time-Series endpoint

``` r
# 

start_date <- '2022-10-01'
end_date <- Sys.Date()
base <- 'USD'
to <- 'HUF'


response <- GET(
    'https://api.exchangerate.host/timeseries',
    query = list(
      start_date = start_date,
      end_date = end_date,
      base=base,
      symbols=to
    )
  )

df <- fromJSON(content(response, "text"))


#data.frame('date'= names(df$rates), 'value'= as.numeric(unlist(df$rates)))



exchange_currency <- function(start_date, end_date, base, to) {
  
  response <- GET(
      'https://api.exchangerate.host/timeseries',
      query = list(
        start_date = start_date,
        end_date = end_date,
        base=base,
        symbols=to
      )
    )
  
  df <- fromJSON(content(response, "text"))
  
  
  return(data.frame('date'= names(df$rates), 'value'= as.numeric(unlist(df$rates))))

}
```

``` r
df <- exchange_currency(start_date = Sys.Date() -30 , end_date = Sys.Date(), base = 'USD', to = "HUF")
head(df)
```

# Nasdaq data

<https://www.nasdaq.com/market-activity/stocks/screener>

``` r
t <- fromJSON('https://api.nasdaq.com/api/screener/stocks?tableonly=true&limit=25&offset=150')
t$data$table$rows[1:5]
```

    ##    symbol                                                               name
    ## 1     CSX                                       CSX Corporation Common Stock
    ## 2      WM                                Waste Management, Inc. Common Stock
    ## 3     PNC              PNC Financial Services Group, Inc. (The) Common Stock
    ## 4     HCA                                  HCA Healthcare, Inc. Common Stock
    ## 5     BMO                                      Bank Of Montreal Common Stock
    ## 6     CNQ                    Canadian Natural Resources Limited Common Stock
    ## 7     PBR                   Petroleo Brasileiro S.A.- Petrobras Common Stock
    ## 8     ETN                             Eaton Corporation, PLC Ordinary Shares
    ## 9     USB                                          U.S. Bancorp Common Stock
    ## 10     BX                                       Blackstone Inc. Common Stock
    ## 11    AMX America Movil, S.A.B. de C.V. American Depository Receipt Series L
    ## 12   FISV                                          Fiserv, Inc. Common Stock
    ## 13    SHW                        Sherwin-Williams Company (The) Common Stock
    ## 14    OXY                      Occidental Petroleum Corporation Common Stock
    ## 15     CL                             Colgate-Palmolive Company Common Stock
    ## 16   AMOV   America Movil, S.A.B. de C.V. Class A American Depositary Shares
    ## 17     MU                               Micron Technology, Inc. Common Stock
    ## 18   MUFG                  Mitsubishi UFJ Financial Group, Inc. Common Stock
    ## 19    CME                                CME Group Inc. Class A Common Stock
    ## 20    BNS                     Bank Nova Scotia Halifax Pfd 3 Ordinary Shares
    ## 21    AON                          Aon plc Class A Ordinary Shares (Ireland)
    ## 22   LRCX                              Lam Research Corporation Common Stock
    ## 23    BSX                         Boston Scientific Corporation Common Stock
    ## 24   EQIX                                    Equinix, Inc. Common Stock REIT
    ## 25    TFC                          Truist Financial Corporation Common Stock
    ##    lastsale netchange pctchange
    ## 1    $32.07      0.15     0.47%
    ## 2   $164.01      0.77    0.472%
    ## 3   $166.50      1.52    0.921%
    ## 4   $237.28      2.54    1.082%
    ## 5    $99.38      0.67    0.679%
    ## 6    $59.97     -0.81   -1.333%
    ## 7    $10.14     -0.02   -0.197%
    ## 8   $165.36     -1.12   -0.673%
    ## 9    $44.11      0.20    0.455%
    ## 10   $88.52      0.72     0.82%
    ## 11   $20.44     -0.04   -0.195%
    ## 12  $102.08      1.09    1.079%
    ## 13  $250.00      6.55     2.69%
    ## 14   $71.12     -1.65   -2.267%
    ## 15   $76.93      0.56    0.733%
    ## 16   $20.22      0.05    0.248%
    ## 17   $58.93      0.31    0.529%
    ## 18    $5.22      0.04    0.772%
    ## 19  $176.00      1.75    1.004%
    ## 20   $53.12      0.40    0.759%
    ## 21  $304.24      0.45    0.148%
    ## 22  $461.40      5.78    1.269%
    ## 23   $43.89      0.35    0.804%
    ## 24  $671.77     15.70    2.393%
    ## 25   $46.43      0.01    0.022%
