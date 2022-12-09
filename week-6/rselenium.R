library(RSelenium)
library(rvest)
library(xml2)
rs_driver_obj <- rsDriver(browser = 'chrome', chromever = '106.0.5249.61', port = as.integer(14865))

remDr <- rs_driver_obj$client

remDr$navigate('https://www.bbc.com/')
# remDr$setWindowSize(width = 800, height = 300)
#accept all the cookies
Sys.sleep(25)
webElem <- remDr$findElement("css", "body")

for (i in 1:5) {
  webElem$sendKeysToElement(list(key = "page_down"))
  Sys.sleep(4)
}


remDr$navigate('https://www.cnbc.com/business/')
#accept all the cookies
Sys.sleep(25)
webElem <- remDr$findElement("css", "body")



for (i in 1:5) {
  webElem$sendKeysToElement(list(key = "end"))
  t_b <- remDr$findElement("css", '.LoadMoreButton-loadMore')
  t_b$clickElement()
  Sys.sleep(4)
}

t_page <- remDr$getPageSource()
t <- read_html(t_page[[1]])
t %>% html_nodes('.Card-title') %>% html_text()
write_html(t, 'cnbc.html')

