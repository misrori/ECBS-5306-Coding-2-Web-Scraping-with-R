

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

title <- 

link <- 

teaser <- 

df <- data.frame('title' = title, 'link'= link, 'teaser'= teaser)

# now put it into a function
get_coindesk_one_page <- function(url) {
 
  
  
  df <- data.frame('title' = title, 'link'= link, 'teaser'= teaser)
  return(df)
}

# check how the url is changing when you load the next page
links <- paste0()

# instead of a for loop use lapply
list_of_pages <- lapply(links, get_coindesk_one_page)
# the result is a list of tables

# row bind all the data
df <- rbindlist(list_of_pages)





# Infoworld scraper

url <- 'https://www.infoworld.com/category/data-science/'

get_one_page <- function(url) {
 
  return(df)
}  

# try your function
df <- get_one_page(url = url)

links <- paste0()

# lapply

# rbindlist








# Yachtworld scraper
# The base url is https://www.yachtworld.co.uk/boats-for-sale/
  
  
url <- 'https://www.yachtworld.co.uk/yacht/2021-ryck-280-8036770/'

t_list <- list()

t <- read_html(url)
t_list[['title']] 
t_list[['length']] 
t_list[['price']] 
t_list[['location']]

# keys and values
keys  
values  

if (length(keys)==length(values)) {
  # send the value to the key
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
