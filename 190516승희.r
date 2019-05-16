library(RSelenium) 
library(rvest)

pjs <- wdman::phantomjs()
Sys.sleep(5)
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open() #크롬 창 열기
remDr$navigate("https://nid.naver.com/nidlogin.login?mode=form&url=https%3A%2F%2Fwww.naver.com") #네이버 로그인페이지로 이동
txt_id<-remDr$findElement(using="id",value="id") 
txt_pw<-remDr$findElement(using="id",value="pw")
Sys.sleep(5)

txt_id$setElementAttribute("value","★") 
Sys.sleep(3)
txt_pw$setElementAttribute("value","★") #아이디 비밀번호 입력
Sys.sleep(3)
btn <- remDr$findElement(using="xpath", value='//*[@id="frmNIDLogin"]/fieldset/input')
btn$clickElement() #로그인 버튼 누르기

title=c()
price=c()
date=c()
icon=c()
content=c()
deal=c()
delivery=c()
userclass=c()
userid=c()

skt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=339&search.boardtype=L#'
kt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=424&search.boardtype=L'
lgu_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=425&search.boardtype=L'
skt_kt_lgu=c(skt_url, kt_url, lgu_url) #게시판 url 벡터를 만들어줌

remDr$navigate(skt_url)
Sys.sleep(2)
  
  
for(i in 1:60){
    btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
    btn1$clickElement() #더보기 버튼 누르기
    Sys.sleep(1)
}
url=c()
box=remDr$findElements('class', 'board_box ')
Sys.sleep(15)
for(i in 1:length(box)){
    box1=box[[i]]$findChildElement('tag name', 'a')
    tit=box1$findChildElement('class','tit')
    title=c(title,as.character(tit$getElementText())) #제목을 벡터에 저장
    url=c(url,as.character(box1$getElementAttribute('href'))) #게시글로 가는 url 주소 벡터에 저장
}
  
for(i in 1:length(url)){
    remDr$navigate(url[i]) #벡터에 저장된 url에 차례로 접속
    Sys.sleep(3)
    body=remDr$getPageSource()[[1]]
    body=read_html(body)
    error=html_node(body, '.error_content_body')
    if(length(error)!=0)
    {
      price=c(price, 0)
      date=c(date, 0)
      icon=c(icon, 0)
      content=c(content, 0)
      deal=c(deal,0)
      delivery=c(delivery,0)
      userclass=c(userclass,0)
      userid=c(userid,0)
    }
    else
    {
      prc=remDr$findElement('class', 'price')
      price=c(price, as.character(prc$getElementText()))
      dy=remDr$findElement('class', 'board_time')
      date=c(date, as.character(dy$getElementText()))
      ic=remDr$findElement('class', 'tran_type')
      icon=c(icon, as.character(ic$getElementText()))
      pro=remDr$findElement('class', 'product_info')
      d=pro$findChildElement('class', 'deal')
      deal=c(deal,as.character(d$getElementText()))
      del=pro$findChildElements('class', 'txt_desc')[[2]]
      delivery=c(delivery,as.character(del$getElementText()))
      ucls=pro$findChildElement('class', 'ellip')
      userclass=c(userclass,as.character(ucls$getElementText()))
      id=pro$findChildElement('class', 'user_id')
      userid=c(userid,as.character(id$getElementText()))
    }
    
}

remDr$close()
totaldf=data.frame(icon=icon, title=title, price=price, date=date, deal=deal,delivery=delivery,userclass=userclass,userid=userid)

write.csv(totaldf, paste("D:/totaldata",format(Sys.Date(),"%y-%m-%d"), format(Sys.time(),"%H"),".csv"))
