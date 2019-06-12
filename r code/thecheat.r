library(RSelenium)
library(rvest)
library(drat)
drat:::add("shabbychef");
library(xml2)

pjs <- wdman::phantomjs()

Sys.sleep(3)
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open() #크롬 창 열기

cheaturl="https://thecheat.co.kr/rb/?m=bbs&bid=cheat&page_num=&search_term=&se=&p="

totpage=1:70

urlvec=c()

pages=paste0(cheaturl, totpage, sep='')

a="https://thecheat.co.kr"

for(i in 1:length(pages)){
  remDr$navigate(pages[i])
  body=remDr$getPageSource()[[1]]
  
  body=read_html(body, options = "HUGE")
  
  table <- body %>% html_nodes("table")
  
  td <- table %>% html_nodes("td") 
  
  text1 <- td %>% html_nodes("li")
  
  text2=text1[c(FALSE,TRUE)]
  
  text3=gsub("<li>","",text2)
  
  text=gsub("</li>","",text3)
  length(text)
  table <- html_node(body, '.damageListArea')
  
  td <- table %>% html_nodes("a")
  td=td[c(TRUE, FALSE)]
  td=td[-c(length(td), length(td)-1)]
  
  ph=td %>% html_text()
  
  
  txt=html_attrs(td)
  
  pageone=paste0(a,txt)
  
  
  
  
  
  for(j in 1:length(text)){
    
    if(text[j]=="cafe.naver.com"&& ph[j]=="휴대폰/주변기기"){
      
      urlvec=c(urlvec, pageone[j])
    }
  }
  
}
item=c()
price=c()
userid=c()
phonenum=c()
for(k in 1:length(urlvec)){
  remDr$navigate(urlvec[k])
  Sys.sleep(2)
  table2=remDr$getPageSource()[[1]]
  table2=read_html(table2, options = "HUGE")
  table3 <- table2 %>% html_nodes(".formTypeD")
  
  td1 <- table3 %>% html_nodes("td") 
  
  tt <- td1 %>% html_nodes("li") %>% html_text()
  item=c(item,tt[1])
  
  id <- td1 %>% html_nodes("b") %>% html_text()
  userid=c(userid,id[3])
  
  a=table2 %>% html_node(".formTypeD") %>% html_nodes("tr")
  a=a[3] %>% html_nodes("td")
  price=c(price,html_text(a)[2])
  phonenum=c(phonenum,id[6])
}

totalthecheat=data.frame(item=item,price=price,userid=userid,phonenum=phonenum)
write.csv(totalthecheat, "D:/totalthecheat.csv")
remDr$close()
