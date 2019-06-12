library(RSelenium) 
library(rvest)
library(drat)
drat:::add("shabbychef");
library(xml2)

pjs <- wdman::phantomjs()
Sys.sleep(3)
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open() #크롬 창 열기
remDr$navigate("https://nid.naver.com/nidlogin.login?mode=form&url=https%3A%2F%2Fwww.naver.com") #네이버 로그인페이지로 이동
txt_id<-remDr$findElement(using="id",value="id") 
txt_pw<-remDr$findElement(using="id",value="pw")

txt_id$setElementAttribute("value","ㅁㅁㅁ") 
Sys.sleep(3)
txt_pw$setElementAttribute("value","ㅁㅁㅁ") #아이디 비밀번호 입력
Sys.sleep(3)
btn <- remDr$findElement(using="xpath", value='//*[@id="frmNIDLogin"]/fieldset/input')
btn$clickElement() #로그인 버튼 누르기
Sys.sleep(3)


price=c()
date=c()
icon=c()
deal=c()
delivery=c()
userclass=c()
userid=c()
sms=c()

title=c()
url=c()
skt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=339&search.boardtype=L#'


remDr$navigate(skt_url)
Sys.sleep(2)


for(i in 1:60){
  btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
  btn1$clickElement() #더보기 버튼 누르기
  Sys.sleep(2)
}

box=remDr$findElements('class', 'board_box ')
Sys.sleep(1)
for(i in 1:length(box)){
  box1=box[[i]]$findChildElement('tag name', 'a')
  tit=box1$findChildElement('class','tit')
  title=c(title,as.character(tit$getElementText())) #제목을 벡터에 저장
  url=c(url,as.character(box1$getElementAttribute('href'))) #게시글로 가는 url 주소 벡터에 저장
}

for(i in 1:length(url)){
  remDr$navigate(url[i]) #벡터에 저장된 url에 차례로 접속
  Sys.sleep(1)
  body=NULL
  body=remDr$getPageSource()[[1]]
  body=read_html(body, options = "HUGE")
  error=html_node(body, '.error_content_body')
  if(length(error)!=0)
  {
    price=c(price, 0)
    date=c(date, 0)
    icon=c(icon, 0)
    deal=c(deal,0)
    delivery=c(delivery,0)
    userclass=c(userclass,0)
    userid=c(userid,0)
    sms=c(sms,0)
  }
  else  {
    prc=html_node(body, '.price')
    price=c(price, html_text(prc))
    
    dy=html_node(body, '.board_time')
    date=c(date, substr(html_text(dy), 6, 22))
    
    ic=html_node(body, '.tran_type')
    icon=c(icon, html_text(ic))
    
    pro=html_node(body, '.product_info')
    d=html_node(pro, '.deal')
    deal=c(deal,html_text(d))
    
    del=html_nodes(body, '.txt_desc')[2]
    delivery=c(delivery,substr(html_text(del), 7, 19))
    
    ucls=html_nodes(body, '.ellip')[2]
    userclass=c(userclass,html_text(ucls))
    
    id=html_node(body, '.user_id')
    userid=c(userid,html_text(id))
    
    smss=html_node(body, '.sms')
    sms=c(sms, gsub("판매자정보 안내", "",html_text(smss)))
  }
}


totaldf=data.frame(url=url, icon=icon, title=title, price=price, date=date, deal=deal,delivery=delivery,userclass=userclass,userid=userid, sms=sms)

write.csv(totaldf, paste("D:/1totaldata",format(Sys.Date(),"%y-%m-%d"), format(Sys.time(),"%H"),".csv"))
remDr$close()
