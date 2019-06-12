library(RSelenium)
library(rvest)
library(drat)
drat:::add("shabbychef");
library(xml2)

pjs <- wdman::phantomjs()

Sys.sleep(3)
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open() #??? a ????

cheaturl="https://thecheat.co.kr/rb/?m=bbs&bid=cheat&page_num=&search_term=&se=&p="

totpage=1:30

urlvec=c()

pages=paste0(cheaturl, totpage, sep='')

a="https://thecheat.co.kr"
pageone=c()
for(i in 1:length(pages)){
  remDr$navigate(pages[i])
  body=remDr$getPageSource()[[1]]
  
  body=read_html(body, options = "HUGE")
  table <- html_node(body, '.damageListArea')
  td <- table %>% html_nodes("a")
  td=td[c(TRUE, FALSE)]
  td=td[-c(length(td), length(td)-1)]
  txt=html_attrs(td)
  pageone=c(pageone, paste0(a,txt))
}




incident=c()
upload=c()
for(j in 1:length(pageone)){
  remDr$navigate(pageone[j])
  Sys.sleep(2)
  table2=remDr$getPageSource()[[1]]
  table2=read_html(table2, options = "HUGE")
  table3 <- table2 %>% html_nodes(".formTypeD")
  
  td1 <- table3 %>% html_nodes("td") 
  inc <- td1 %>% html_nodes("b") %>% html_text()
  incident=c(incident,inc[1])
  
  up <- table2 %>% html_nodes(".userInfoHead")
  upload1 <- up %>% html_nodes("span") %>% html_text()
  if(length(upload1)==0) {upload=c(upload, 0)}
  else{
    upload2=substr(upload1,1,10)
    upload=c(upload,upload2)
  }
  
  
}
remDr$close()

total=data.frame(incident=incident,upload=upload, stringsAsFactors = F)
total=na.omit(total) #�̻��� �ִ� �� ����

# .�� -�� �ٲ�(��¥ �Լ��� ���� ���ؼ� ��¥�� -�� ���� �Ǿ��־�� �Ѵ�)
total$incident=gsub("\\.","-",total$incident)
total$upload=gsub("\\.","-",total$upload)


datediff=as.Date(total$upload)-as.Date(total$incident)
quantile(datediff,c(0,0.25,0.5,0.75,1),na.rm=T)
mean(datediff,na.rm=T)

datediff=as.numeric(datediff[datediff>=0]) # ������ ���� �Ұ��� �ϹǷ� ����(1158��)
hist(datediff)

############## �̻��� ã��##############
outlier=boxplot(datediff)

# 19�̻��� �̻����̰�, NA�� �ٲ�
datediff=ifelse(datediff>18,NA,datediff)

# NA�� ���Ե� �� ����
datediff=na.omit(datediff)

hist(datediff,main="�̻��� ������ ������׷�")

summary(datediff)
