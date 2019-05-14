library(RSelenium) 
library(rvest)

############################### ũ�� â ��� ���̹� �α��� �Ϸ� ################################################
pjs <- wdman::phantomjs()
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open() 
remDr$navigate("https://nid.naver.com/nidlogin.login?mode=form&url=https%3A%2F%2Fwww.naver.com") 
txt_id<-remDr$findElement(using="id",value="id") 
txt_pw<-remDr$findElement(using="id",value="pw")

txt_id$setElementAttribute("value","11")
txt_pw$setElementAttribute("value","11") 
btn <- remDr$findElement(using="xpath", value='//*[@id="frmNIDLogin"]/fieldset/input') 
btn$clickElement() 
###################################################################################################################


skt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=339&search.boardtype=L#'
kt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=424&search.boardtype=L'
lgu_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=425&search.boardtype=L'
skt_kt_lgu=c(skt_url, kt_url, lgu_url) #�Խ��� url ���͸� �������

title=c() #����
price=c() #����
date=c() #��¥
icon=c()  #�Ǹ�.���� ������
url=c() #�Խñ��ּ�
content=c() #�Խñۺ���


for(j in 1:length(skt_kt_lgu)){
  remDr$navigate(skt_kt_lgu[j])
  btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
  btn1$clickElement() #������ ��ư ������
  btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
  btn1$clickElement() #������ ��ư ������
  title=c()
  url=c()
  box=remDr$findElements('class', 'board_box ')
  for(i in 1:length(box)){
    box1=box[[i]]$findChildElement('tag name', 'a')
    tit=box1$findChildElement('class','tit')
    title=c(title,as.character(tit$getElementText())) #������ ���Ϳ� ����
    url=c(url,as.character(box1$getElementAttribute('href'))) #�Խñ۷� ���� url �ּ� ���Ϳ� ����
  }
}



url_save = function(urlvec){
  remDr$navigate(urlvec)
  btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
  btn1$clickElement() #������ ��ư ������
  btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
  btn1$clickElement() #������ ��ư ������
  url=c()
  title=c()
  box=remDr$findElements('class', 'board_box ')
  for(i in 1:length(box)){
    box1=box[[i]]$findChildElement('tag name', 'a')
    tit=box1$findChildElement('class','tit')
    title=c(title,as.character(tit$getElementText())) #������ ���Ϳ� ����
    url=c(url,as.character(box1$getElementAttribute('href'))) #�Խñ۷� ���� url �ּ� ���Ϳ� ����
  }
}

lapply(skt_kt_lgu, url_save)

url_save(skt_url)


totaldf=data.frame(icon=icon, title=title, price=price, date=date)

write.csv(totaldf, paste("D:/totaldata",Sys.Date(),".csv"))








girlsamsungurl1='http://www.snphone.co.kr/shop/?ca_id=COMAAA&select_key=&input_key=&Search_Order=&Search_Price=#brand_tap'
girlsamsungurl2='http://www.snphone.co.kr/shop/?SCD=&ca_id=COMAAA&Search_Order=&Search_Price=&select_key=&input_key=&p=1&p=2'
girlappleurl='http://www.snphone.co.kr/shop/?mode=search&ca_id=COMAAB'
girllgurl='http://www.snphone.co.kr/shop/?ca_id=COMAAH&select_key=&input_key=&Search_Order=&Search_Price=#brand_tap'

url=c(girlsamsungurl1, girlsamsungurl2, girlappleurl, girllgurl)

girlphone=c()
girlprice=c()

for(i in 1:4)
{
  phone1=read_html(url[i])%>%html_nodes(".txt_prd")%>%html_nodes(".name")
  txt1=gsub("<p class=\"name\">\r\n\t\t\t\t\t\t\t\t","",phone1)
  txt1=gsub("\t\t\t\t\t\t\t</p>","",txt1)
  girlphone=c(girlphone, txt1)
  price1=read_html(url[i])%>%html_nodes(".price_b")
  txt2=gsub("<p class=\"price_b\"><span>�ǸŰ�</span>","",price1)
  txt2=gsub("<font>WON</font></p>","",txt2)
  girlprice=c(girlprice, txt2)
}

a=data.frame(phone1=girlphone, price1=girlprice)
write.csv(a, paste("D:/girldata",Sys.Date(),".csv"))




remDr$navigate(skt_url)
btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
btn1$clickElement() #������ ��ư ������
btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
btn1$clickElement() #������ ��ư ������
title=c()
url=c()
box=remDr$findElements('class', 'board_box ')
for(i in 1:length(box)){
  box1=box[[i]]$findChildElement('tag name', 'a')
  tit=box1$findChildElement('class','tit')
  title=c(title,as.character(tit$getElementText())) #������ ���Ϳ� ����
  url=c(url,as.character(box1$getElementAttribute('href'))) #�Խñ۷� ���� url �ּ� ���Ϳ� ����
}
length(url)
