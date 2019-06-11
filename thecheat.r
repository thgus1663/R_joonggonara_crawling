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

# 페이지 수 지정
totpage=1:4

# url을 저장할 벡터 생성
urlvec=c()

# 위 url과 페이지번호를 연결 
pages=paste0(cheaturl, totpage, sep='')

# 더치트 게시글에 해당하는 url을 연결할 부분
a="https://thecheat.co.kr"

for(i in 1:length(pages)){
  remDr$navigate(pages[i])
  body=remDr$getPageSource()[[1]]
  
  body=read_html(body, options = "HUGE")
  
  table <- body %>% html_nodes("table")
  
  td <- table %>% html_nodes("td") 
  
  text1 <- td %>% html_nodes("li")
  
  text2=text1[c(FALSE,TRUE)] # 홀수행엔 필요없는 것, 짝수행(게시글로 들어가는 url의 일부)이 필요한 것
  
  text3=gsub("<li>","",text2)
  
  text=gsub("</li>","",text3)
  
  table <- html_node(body, '.damageListArea')
  
  td <- table %>% html_nodes("a")
  td=td[c(TRUE, FALSE)]
  td=td[-c(length(td), length(td)-1)]

  ph=td %>% html_text()
  
  
  txt=html_attrs(td)
  
  pageone=paste0(a,txt) # 게시글로 들어가는 최종 url
  
  
  
  
  
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

total=data.frame(item=item,price=price,userid=userid,phonenum=phonenum)
write.csv(total, paste("D:/total",format(Sys.Date(),"%y-%m-%d"),".csv"))
remDr$close()

