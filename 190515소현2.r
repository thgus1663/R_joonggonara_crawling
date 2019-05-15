library(RSelenium) 
library(rvest)

pjs <- wdman::phantomjs()
Sys.sleep(5)
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open() #ũ�� â ����
remDr$navigate("https://nid.naver.com/nidlogin.login?mode=form&url=https%3A%2F%2Fwww.naver.com") #���̹� �α��� â ����
txt_id<-remDr$findElement(using="id",value="id") 
txt_pw<-remDr$findElement(using="id",value="pw")
Sys.sleep(5)

txt_id$setElementAttribute("value","1")
Sys.sleep(3)
txt_pw$setElementAttribute("value","1") #���̵� ��й�ȣ �Է�
Sys.sleep(3)
btn <- remDr$findElement(using="xpath", value='//*[@id="frmNIDLogin"]/fieldset/input')
btn$clickElement() #�α��� ��ư ������

title=c()
price=c()
date=c()
icon=c()
content=c()
url=c()
title=c()
skt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=339&search.boardtype=L#'
kt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=424&search.boardtype=L'
lgu_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=425&search.boardtype=L'
skt_kt_lgu=c(skt_url, kt_url, lgu_url) #�Խ��� url ���͸� �������


url_save = function(urlvec){
  remDr$navigate(urlvec)
  for(i in 1:10){
    btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
    btn1$clickElement() #������ ��ư ������
    Sys.sleep(1)
    i=i+1
  }
  
  box=remDr$findElements('class', 'board_box ')
  return(box)
}
box2=url_save(kt_url)
length(box2)