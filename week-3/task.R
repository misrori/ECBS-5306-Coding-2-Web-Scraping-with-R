

library(rvest)
library(data.table)

# Typical HTML process task:
#   
# Create a function that will process one page and return with a data frame with one line
# Create the links that you want to process, you also can write a function that will extract the links first then save them into a vector
# `lapply` your function to your links, you will get a list of data frames
# `rbindlist` your result into one dataframe 



# Coindesk
t <- read_html('https://www.coindesk.com/tag/bitcoin/')

title <- t %>% html_nodes('.card-title') %>% html_text()

link <- paste0('https://www.coindesk.com', t %>% html_nodes('.card-title') %>% html_attr('href'))

teaser <- t %>% html_nodes('.content-text') %>% html_text()

df <- data.frame('title' = title, 'link'= link, 'teaser'= teaser)

# now put it into a function
get_coindesk_one_page <- function(url) {
  t <- read_html(url)
  title <- t %>% html_nodes('.card-title') %>% html_text()
  link <- paste0('https://www.coindesk.com', t %>% html_nodes('.card-title') %>% html_attr('href'))
  teaser <- t %>% html_nodes('.content-text') %>% html_text()
  df <- data.frame('title' = title, 'link'= link, 'teaser'= teaser)
  return(df)
}

df_3 <- get_coindesk_one_page('https://www.coindesk.com/tag/bitcoin/3/')
# check how the url is changing when you load the next page
links <- paste0('https://www.coindesk.com/tag/bitcoin/', 1:5, '/')

# instead of a for loop use lapply
list_of_pages <- lapply(links, get_coindesk_one_page)
# the result is a list of tables

# row bind all the data
df <- rbindlist(list_of_pages)





# Infoworld scraper

url <- 'https://www.infoworld.com/category/data-science/'

t <- read_html(url)
boxes <- t %>% html_nodes('.river-well')

process_one_box <- function(x) {
  title <- x %>% html_nodes('.post-cont a') %>% html_text()
  link <- paste0('https://www.infoworld.com', x %>% html_nodes('.post-cont a') %>% html_attr('href'))
  teaser <- x %>% html_nodes('h4') %>% html_text()
  
  df <- data.frame('title' = title, 'link'= link, 'teaser'= teaser)
  return(df)
}

one_page_list <- lapply(boxes, process_one_box)

one_page <- rbindlist(one_page_list)

one_page <- 
rbindlist(
lapply(boxes, function(x){
  title <- x %>% html_nodes('.post-cont a') %>% html_text()
  link <- paste0('https://www.infoworld.com', x %>% html_nodes('.post-cont a') %>% html_attr('href'))
  teaser <- x %>% html_nodes('h4') %>% html_text()
  
  df <- data.frame('title' = title, 'link'= link, 'teaser'= teaser)
  return(df)
  
})
)
one_box <- boxes[[1]]

one_box %>% html_nodes('.post-cont a') %>% html_text()


title <- t %>% html_nodes('.post-cont a') %>% html_text()
link <- paste0('https://www.infoworld.com', t %>% html_nodes('.post-cont a') %>% html_attr('href'))
teaser <- t %>% html_nodes('h4') %>% html_text()

df <- data.frame('title' = title, 'link'= link, 'teaser'= teaser)

process_one_box <- function(x) {
  title <- x %>% html_nodes('.post-cont a') %>% html_text()
  link <- paste0('https://www.infoworld.com', x %>% html_nodes('.post-cont a') %>% html_attr('href'))
  teaser <- x %>% html_nodes('h4') %>% html_text()
  
  df <- data.frame('title' = title, 'link'= link, 'teaser'= teaser)
  return(df)
}

get_one_page <- function(url) {
  
  t <- read_html(url)
  boxes <- t %>% html_nodes('.river-well')
  
  one_page_list <- lapply(boxes, process_one_box)
  
  one_page <- rbindlist(one_page_list)
  
  return(one_page)

}  


# try your function
df <- get_one_page(url = url)

df <-get_one_page('https://www.infoworld.com/napi/tile?def=loadMoreList&pageType=index&catId=3781&category=3781&includeMediaResource=true&createdTypeIds=1&categories=%5B3781%5D&days=-730&pageSize=20&offset=0&ignoreExcludedIds=true&brandContentOnly=false&includeBlogTypeIds=1%2C3&includeVideo=true&liveOnly=true&sortOrder=date&locale_id=0&startIndex=20')

links <- paste0()

# lapply

# rbindlist








# Yachtworld scraper
# The base url is https://www.yachtworld.co.uk/boats-for-sale/
  
  
url <- 'https://www.yachtworld.co.uk/yacht/2021-ryck-280-8036770/'

t_list <- list()

t <- read_html(url)
t_list[['title']] <- t %>% html_nodes('.heading') %>% html_text()
t_list[['length']] 
t_list[['price']] 
t_list[['location']]

# keys and values
keys   <- t %>% html_nodes('.datatable-title') %>% html_text()
values  <- t %>% html_nodes('.datatable-value') %>% html_text()

if (length(keys)==length(values)) {
  # send the value to the key
  for (i in 1:length(keys)) {
    print(i)
    t_list[[ keys[i] ]] <- values[i]
  }
}



# create a function, return with the list

get_one_yachts  <- function(url) {
  t_list <- list()

  return(t_list)
  
}



# Tasks : ultimatespecs scraper

# Open that site: https://www.ultimatespecs.com/car-specs/Tesla/M8552/Model-S and get the links of the cars


# get the link of the cars
t <- read_html('https://www.ultimatespecs.com/car-specs/Tesla/M8552/Model-S')

links



# Write a function that will take one link and return with a list containing the specifications, the name, and the link.


get_one_car_details <- function(url) {
  t_list <- list()
  
  return(t_list)
  
}

# lapply, rbindlist, use fill=T
df <- rbindlist(lapply(links, get_one_car_details), fill = T)
