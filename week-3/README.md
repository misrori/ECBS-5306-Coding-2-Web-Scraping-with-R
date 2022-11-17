    library(rvest)
    library(data.table)

# Yachtworld scraper

The base url is <https://www.yachtworld.co.uk/boats-for-sale/>

    # scraper for one page 
    url <- 'https://www.yachtworld.co.uk/yacht/2021-ryck-280-8036770/'
    t_list <- list()

    t <- read_html(url)
    t_list[['title']] <- t %>% html_node('.heading') %>% html_text()
    t_list[['length']] <- t %>% html_nodes('.boat-length') %>% html_text()
    t_list[['price']] <- t %>% html_nodes('.payment-total') %>% html_text()
    t_list[['location']] <- t %>% html_node('.location') %>% html_text()


    keys <- t %>% html_nodes('.datatable-title') %>% html_text()
    values <- t %>% html_nodes('.datatable-value') %>% html_text()
    if (length(keys)==length(values)) {
      for (i in 1:length(keys)) {
        t_list[[keys[i]]] <- values[i]
      }
    }



    get_one_yachts  <- function(url) {
      t_list <- list()
      
      t <- read_html(url)
      t_list[['title']] <- t %>% html_node('.heading') %>% html_text()
      t_list[['length']] <- t %>% html_nodes('.boat-length') %>% html_text()
      t_list[['price']] <- t %>% html_nodes('.payment-total') %>% html_text()
      t_list[['location']] <- t %>% html_node('.location') %>% html_text()
      
      
      keys <- t %>% html_nodes('.datatable-title') %>% html_text()
      values <- t %>% html_nodes('.datatable-value') %>% html_text()
      if (length(keys)==length(values)) {
        for (i in 1:length(keys)) {
          t_list[[keys[i]]] <- values[i]
        }
      }
      return(t_list)

    }

    get_one_yachts('https://www.yachtworld.co.uk/yacht/2021-ryck-280-8036770/')

    ## $title
    ## [1] "2021 RYCK 2809m"
    ## 
    ## $length
    ## [1] "9m"
    ## 
    ## $price
    ## [1] "€149,633 (£130,628) "
    ## 
    ## $location
    ## [1] "Workum, Netherlands"
    ## 
    ## $Year
    ## [1] "2021"
    ## 
    ## $Make
    ## [1] "RYCK"
    ## 
    ## $Model
    ## [1] "280"
    ## 
    ## $Class
    ## [1] "Sports Cruiser"
    ## 
    ## $Length
    ## [1] "9m"
    ## 
    ## $`Fuel Type`
    ## [1] "Petrol"
    ## 
    ## $`Hull Material`
    ## [1] "Fibreglass"
    ## 
    ## $`Hull Shape`
    ## [1] "Modified Vee"
    ## 
    ## $`Offered By`
    ## [1] "West Yachting B.V. - West Yachting"
    ## 
    ## $`Length Overall`
    ## [1] "9.51m"
    ## 
    ## $Beam
    ## [1] "28m"
    ## 
    ## $`Fresh Water Tank`
    ## [1] "1 x 88 l ()"
    ## 
    ## $`Fuel Tank`
    ## [1] "1 x 300 l ()"
    ## 
    ## $`Holding Tank`
    ## [1] "1 x 35 l ()"
    ## 
    ## $`Double Berths`
    ## [1] "1"
    ## 
    ## $Cabins
    ## [1] "1"
    ## 
    ## $Heads
    ## [1] "1"

    # get_all_link 
    get_one_page_link  <- function(url) {
      t  <- read_html(url)
      all_link <- t %>% html_nodes('a') %>% html_attr('href')
      boat_link <- all_link[startsWith(all_link, 'https://www.yachtworld.co.uk/yacht/')] 
      return(boat_link)
    }
    # try
    get_one_page_link('https://www.yachtworld.co.uk/boats-for-sale/?page=2')

    ##  [1] "https://www.yachtworld.co.uk/yacht/2019-robalo-r247-dc-8511807/"                 
    ##  [2] "https://www.yachtworld.co.uk/yacht/2023-robalo-r230-center-console-8435628/"     
    ##  [3] "https://www.yachtworld.co.uk/yacht/2021-robalo-r230-center-console-8446550/"     
    ##  [4] "https://www.yachtworld.co.uk/yacht/2023-robalo-r317-dual-console-8519153/"       
    ##  [5] "https://www.yachtworld.co.uk/yacht/2020-robalo-r317-8526118/"                    
    ##  [6] "https://www.yachtworld.co.uk/yacht/2021-robalo-r242-8583687/"                    
    ##  [7] "https://www.yachtworld.co.uk/yacht/2010-sea-ray-470-sundancer-8596789/"          
    ##  [8] "https://www.yachtworld.co.uk/yacht/2014-chris--craft-capri-21-8490123/"          
    ##  [9] "https://www.yachtworld.co.uk/yacht/2011-novurania-chapman-transition-28-8597982/"
    ## [10] "https://www.yachtworld.co.uk/yacht/2021-pathfinder-2400-trs-8585928/"            
    ## [11] "https://www.yachtworld.co.uk/yacht/2023-robalo-r302-8596020/"                    
    ## [12] "https://www.yachtworld.co.uk/yacht/2001-viking-61-convertible-8088719/"          
    ## [13] "https://www.yachtworld.co.uk/yacht/2022-robalo-226-cayman-7475962/"              
    ## [14] "https://www.yachtworld.co.uk/yacht/2022-robalo-r242ex-7524372/"                  
    ## [15] "https://www.yachtworld.co.uk/yacht/2023-robalo-202-explorer-8257514/"

    pages_for_link  <- paste0('https://www.yachtworld.co.uk/boats-for-sale/?page=', 1:5)

    boat_links <- sapply(pages_for_link,get_one_page_link)




    data_list <- lapply(boat_links[1:20], get_one_yachts)

    df <- rbindlist(data_list, fill = T)

# Tasks : ultimatespecs scraper

Open that site:
<https://www.ultimatespecs.com/car-specs/Tesla/M8552/Model-S> and get
the links of the cars

    t <- read_html('https://www.ultimatespecs.com/car-specs/Tesla')
    linkek <- t %>% html_nodes('.someOtherRow a') %>% html_attr('href')

    links <- paste0('https://www.ultimatespecs.com',linkek[endsWith(linkek, '.html')])

Write a function that will take one link and return with a list
containing the specifications, the name, and the link.

    get_one_car_details <- function(url) {
      #Sys.sleep(sample(10:30, 1))
      print(url)
      t_list <- list()
      
      t <- read_html(url)
      t_list[['name']] <- t %>% html_node('h1') %>% html_text()
      t_list[['link']] <- url

      
      keys <- t %>% html_nodes('.tabletd') %>% html_text()
      keys<- trimws(gsub(':', '', keys, fixed = T))
      
      values <- t %>% html_nodes('.tabletd_right') %>% html_text()
      values <- trimws(values)
      
      if (length(keys)==length(values)) {
        for (i in 1:length(keys)) {
          t_list[[keys[i]]] <- values[i]
        }
      }
      return(t_list)

    }

    # if it runs to error, that means that you have to many request
    t <- get_one_car_details('https://www.ultimatespecs.com/car-specs/Tesla/106267/Tesla-Model-S-70.html')

    str(t)

    df <- rbindlist(lapply(links[1:5], get_one_car_details), fill = T)

    saveRDS(df, 'TSLAcars.rds')
    head(df,1)
