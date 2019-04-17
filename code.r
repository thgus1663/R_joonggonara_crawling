2019.04.16

로그인, 본문 안의 내용 가져오기 성공
#-------------------------------------------------------------------------------------------------------cmd
#cmd에 입력할 내용
# cd C:\rselenium
# java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.9.1.jar -port 4445
#-------------------------------------------------------------------------------------------------------r
library(rvest)
library(XML)
library(dplyr)
library(stringr)
library(xml2)
library(RSelenium)
library(httr) 

remDr <- remoteDriver(remoteServerAddr = "localhost" , 
                      port = 4445L,
                      browserName = "chrome")
remDr$open() #크롬 창 열기
remDr$navigate("https://nid.naver.com/nidlogin.login?mode=form&url=https%3A%2F%2Fwww.naver.com") #네이버 로그인 창 열기
txt_id<-remDr$findElement(using="id",value="id") 
txt_pw<-remDr$findElement(using="id",value="pw")

txt_id$setElementAttribute("value","********")
txt_pw$setElementAttribute("value","************") #아이디 비밀번호 입력
btn <- remDr$findElement(using="xpath", value='//*[@id="frmNIDLogin"]/fieldset/input') 
btn$clickElement() #로그인 버튼 누르기

title=c()
price=c()
date=c()
icon=c()
skt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=339&search.boardtype=L#'
kt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=424&search.boardtype=L'
lgu_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=425&search.boardtype=L'
skt_kt_lgu=c(skt_url, kt_url, lgu_url) #게시판 url 벡터를 만들어줌

for(j in 1:length(skt_kt_lgu)){
  remDr$navigate(skt_kt_lgu[j])
  #num=1 #몇 번 더보기 누를것인가
  #for(i in 1:num){
  #   btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
  #   btn1$clickElement() #더보기 버튼 누르기
  # } 
  url=c()
  box=remDr$findElements('class', 'board_box ')
  for(i in 1:length(box)){
    box1=box[[i]]$findChildElement('tag name', 'a')
    tit=box1$findChildElement('class','tit')
    title=c(title,as.character(tit$getElementText())) #제목을 벡터에 저장
    url=c(url,as.character(box1$getElementAttribute('href'))) #게시글로 가는 url 주소 벡터에 저장
  }
  
  for(i in 1:length(url)){
    remDr$navigate(url[i]) #벡터에 저장된 url에 차례로 접속
    prc=remDr$findElement('class', 'price')
    price=c(price, as.character(prc$getElementText()))
    dy=remDr$findElement('class', 'board_time')
    date=c(date, as.character(dy$getElementText()))
    ic=remDr$findElement('class', 'tran_type')
    icon=c(icon, as.character(ic$getElementText()))
  }
}

totaldf=cbind(icon, title, price, date)


