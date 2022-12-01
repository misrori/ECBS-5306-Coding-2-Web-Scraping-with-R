-   <a href="#coingecko-api" id="toc-coingecko-api">Coingecko api</a>
-   <a href="#tradingview" id="toc-tradingview">TradingView</a>
-   <a href="#coctail-api" id="toc-coctail-api">Coctail api</a>

``` r
library(rvest)
library(data.table)
library(jsonlite)
library(httr)
library(tidyverse)
```

# Coingecko api

``` r
# coins/markets endpoint

get_one_page <- function(page_num) {
  print(page_num)
  headers = c(
    `accept` = 'application/json'
  )
  
  params = list(
    `vs_currency` = 'usd',
    `order` = 'market_cap_desc',
    `per_page` = '1000',
    `page` = as.character(page_num),
    `sparkline` = 'false'
  )
  
  res <- httr::GET(url = 'https://api.coingecko.com/api/v3/coins/markets',httr::add_headers(.headers=headers), query = params)
  if (res$status_code==429) {
    Sys.sleep(60)
    get_one_page(i)
  }
  df <- fromJSON(content(res, 'text'))

}


all_df_list  <- lapply(1:130, get_one_page)
all_df <- rbindlist(all_df_list)
```

# TradingView

``` r
data_from_tr <- function(data_js) {
  
  headers = c(
    `authority` = 'scanner.tradingview.com',
    `accept` = 'text/plain, */*; q=0.01',
    `accept-language` = 'hu-HU,hu;q=0.9,en-US;q=0.8,en;q=0.7',
    `content-type` = 'application/x-www-form-urlencoded; charset=UTF-8',
    `origin` = 'https://www.tradingview.com',
    `referer` = 'https://www.tradingview.com/',
    `sec-ch-ua` = '"Chromium";v="106", "Google Chrome";v="106", "Not;A=Brand";v="99"',
    `sec-ch-ua-mobile` = '?0',
    `sec-ch-ua-platform` = '"Linux"',
    `sec-fetch-dest` = 'empty',
    `sec-fetch-mode` = 'cors',
    `sec-fetch-site` = 'same-site',
    `user-agent` = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36'
  )
  
  res <- httr::POST(url = 'https://scanner.tradingview.com/america/scan', httr::add_headers(.headers=headers), body = data_js)
  df <- fromJSON(content(res, 'text'))
  df <- 
  rbindlist(
  lapply(df$data$d, function(x){
   as.list(x)
    # data.frame(t(as.data.frame(df$data$d[[1]], stringsAsFactors = F)))
  }))
  
  names(df) <- fromJSON(data)$columns
  
  return(df)
}
tr_all <- data_from_tr('{"filter":[{"left":"market_cap_basic","operation":"nempty"},{"left":"type","operation":"in_range","right":["stock","dr","fund"]},{"left":"subtype","operation":"in_range","right":["common","foreign-issuer","","etf","etf,odd","etf,otc","etf,cfd"]},{"left":"exchange","operation":"in_range","right":["AMEX","NASDAQ","NYSE"]},{"left":"is_primary","operation":"equal","right":true}],"options":{"lang":"en"},"markets":["america"],"symbols":{"query":{"types":[]},"tickers":[]},"columns":["logoid","name","close","market_cap_basic","price_earnings_ttm","price_revenue_ttm","earnings_per_share_basic_ttm","last_annual_eps","enterprise_value_ebitda_ttm","enterprise_value_fq","total_shares_outstanding_fundamental","description","type","subtype","update_mode","pricescale","minmov","fractional","minmove2","currency","fundamental_currency_code"],"sort":{"sortBy":"market_cap_basic","sortOrder":"desc"},"range":[0,6000]}')


# data = '{"filter":[{"left":"market_cap_basic","operation":"nempty"},{"left":"type","operation":"in_range","right":["stock","dr","fund"]},{"left":"subtype","operation":"in_range","right":["common","foreign-issuer","","etf","etf,odd","etf,otc","etf,cfd"]},{"left":"exchange","operation":"in_range","right":["AMEX","NASDAQ","NYSE"]},{"left":"is_primary","operation":"equal","right":true}],"options":{"lang":"en"},"markets":["america"],"symbols":{"query":{"types":[]},"tickers":[]},"columns":["logoid","name","close","market_cap_basic","price_earnings_ttm","price_revenue_ttm","earnings_per_share_basic_ttm","last_annual_eps","enterprise_value_ebitda_ttm","enterprise_value_fq","total_shares_outstanding_fundamental","description","type","subtype","update_mode","pricescale","minmov","fractional","minmove2","currency","fundamental_currency_code"],"sort":{"sortBy":"market_cap_basic","sortOrder":"desc"},"range":[0,300]}'
```

# Coctail api

``` r
library(jsonlite)
t <- fromJSON('https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Vodka')

x <- t$drinks$idDrink[3]

all_vodka_drink <- 
rbindlist(lapply(t$drinks$idDrink[1:20], function(x){
  df <- fromJSON(paste0('https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=', x))
  return(df$drinks)
}))

ingr <- all_vodka_drink[,names(all_vodka_drink)[grepl(pattern = 'strIngredient', names(all_vodka_drink))], with=F]



all_ing <- 
unlist(
lapply(1:ncol(ingr), function(x){
  as.character(unlist(ingr[,names(ingr)[x], with=FALSE]))
})
)

all_ing <- all_ing[!is.na(all_ing)]
ing_table <- data.table(table(all_ing))

library(ggplot2)
ggplot(ing_table, aes(x=reorder(all_ing, -N), y = N))+
  geom_col()+
  theme_bw()+
  theme(axis.text.x = element_text(angle = -60, vjust = 0.1))

# create a book 
# https://github.com/public-apis/public-apis
```
