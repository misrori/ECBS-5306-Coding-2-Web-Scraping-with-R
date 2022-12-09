require(httr)
library(data.table)
cookies = c(
  '_ga' = 'GA1.2.1046633689.1670507020',
  '_gid' = 'GA1.2.1319713889.1670507020',
  'LBSESSSION' = '!xMVSLdvkoDuv5UPLizWREpXk4TP/dI9T+bB7oCQUGZCdRkk2Ydjbo2SPMgU9NmkwvtYshYkundZP4A==',
  'TS01db72bd' = '012f7c1fff48aa87738362c80cf548ad2c7c70f7897275dac15eef50188540a0e78b5b98db4fd45eff7263c5aa289e041e2cf7de9550d2a8bc6c3d1445bfdbbaa35b0c52cc'
)

headers = c(
  `Accept` = 'application/xml, text/xml, */*; q=0.01',
  `Accept-Language` = 'hu-HU,hu;q=0.9,en-US;q=0.8,en;q=0.7',
  `Connection` = 'keep-alive',
  `Content-Type` = 'text/xml; charset="UTF-8"',
  `Origin` = 'https://fiokesatmkereso.mnb.hu',
  `Referer` = 'https://fiokesatmkereso.mnb.hu/web/index.html',
  `SOAPAction` = 'http://tempuri.org/IAtmService/GetAtmsAndBranches',
  `Sec-Fetch-Dest` = 'empty',
  `Sec-Fetch-Mode` = 'cors',
  `Sec-Fetch-Site` = 'same-origin',
  `User-Agent` = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36',
  `X-Requested-With` = 'XMLHttpRequest',
  `sec-ch-ua` = '"Chromium";v="106", "Google Chrome";v="106", "Not;A=Brand";v="99"',
  `sec-ch-ua-mobile` = '?0',
  `sec-ch-ua-platform` = '"Linux"'
)

data = '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">\n<s:Body>\n<GetAtmsAndBranches xmlns="http://tempuri.org/">\n<value>\n<entity_list_request>\n  <attributes>\n    <fiok>1</fiok>\n    <atm>1</atm>\n    <am_megk>0</am_megk>\n    <am_haszn>0</am_haszn>\n    <postak>0</postak>\n  </attributes>\n  <coordinates>\n    <lefttop>\n      <lat>51.06963706805956</lat>\n      <lon>14.77856138100921</lon>\n    </lefttop>\n    <rightbottom>\n      <lat>44.371692717851815</lat>\n      <lon>19.052243021634208</lon>\n    </rightbottom>\n  </coordinates>\n  <intezmenyek>\n  </intezmenyek>\n  <limit>\n    <from>1</from>\n    <to>5225</to>\n  </limit>\n</entity_list_request>\n</value>\n</GetAtmsAndBranches>\n</s:Body>\n</s:Envelope>'

res <- httr::POST(url = 'https://fiokesatmkereso.mnb.hu/WcfPublicInterfaceForAtm/AtmService/AtmService.svc/GetAtmsAndBranches', httr::add_headers(.headers=headers), httr::set_cookies(.cookies = cookies), body = data)

str(content(res, 'text'))

# Load the library xml2
library(xml2)
# Read the xml file
mnb_xml <- read_xml(content(res, 'text'))

library(XML)
mnb <- xmlToList(content(res, 'text'))






my_df <- 
  rbindlist(lapply( mnb$Body$GetAtmsAndBranchesResponse$GetAtmsAndBranchesResult$entity_list_response, function(x){
    return(cbind(data.frame(x$attributes[x$attributes!='NULL']), data.frame(x$location[x$location!='NULL']), data.frame(x$coordinates[x$coordinates!='NULL'])))
    
  }), fill = T)
my_df$center.lon <- as.numeric(substring(my_df$center.lon,1,9))*10
my_df$center.lat <- as.numeric(substring(my_df$center.lat,1,9))*10

saveRDS(my_df, 'clean_data.rds')

library(leaflet)
leaflet(my_df) %>% addTiles() %>%
  addMarkers(~as.numeric(center.lon), ~as.numeric(center.lat),clusterOptions = markerClusterOptions(),
             popup = ~paste(sep = "<br/>", as.character(varos), as.character(megye) )) 

