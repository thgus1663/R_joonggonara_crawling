library(RSelenium) 

#pjs <- wdman::phantomjs()
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)

remDr$open() # 크롬 창 열기
remDr$navigate("https://nid.naver.com/nidlogin.login?mode=form&url=https%3A%2F%2Fwww.naver.com") # 로그인 할 페이지로 이동

txt_id<-remDr$findElement(using="id",value="id") # 페이지 소스에서 id이고 값이 id인 것을 찾아 txt_idㄹ
txt_pw<-remDr$findElement(using="id",value="pw") # 위와 같이 id이고 값이 pw
login_btn<-remDr$findElement(using="class",value="btn_global") # 로그인 버튼의 클래스가 btn_global

txt_id$setElementAttribute("value","ddddd") # ●●●●●에 아이디 입력
txt_pw$setElementAttribute("value","ddddd") # ●●●●●에 비밀번호 입력
login_btn$clickElement() # 로그인 버튼 클릭

#중고나라에서 명품[가방]의 url주소
url="https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=782&search.boardtype=L" 

#가져올 항목을 저장할 벡터 생성
title=c()
price=c()
date=c()
icon=c()


remDr$navigate(url) #위 url로 이동
href=c() #각 게시글을 클릭했을 때 이동하는 링크를 저장할 벡터 생성
board=remDr$findElements('class', 'board_box ')

#한 화면에 보이는 게시판 목록 수 만큼 반복
for(i in 1:length(board)){
  box=board[[i]]$findChildElement('tag name', 'a')
  tit=box$findChildElement('class','tit')
  title=c(title,as.character(tit$getElementText())) #제목을 벡터에 저장
  href=c(href,as.character(box$getElementAttribute('href'))) #게시글로 가는 url 주소 벡터에 저장
}

#위에서 저장했던 하이퍼링크의 개수만큼 반복
for(j in 1:length(href)){
  remDr$navigate(href[j]) #벡터에 저장된 url에 차례로 접속
  pr=remDr$findElement('class', 'price') #가격을 나타내는 부분을 찾음
  price=c(price, as.character(pr$getElementText())) #찾은 가격을 하나씩 벡터에 추가하여 저장, 밑에도 동일한 방법으로
  dd=remDr$findElement('class', 'board_time')
  date=c(date, as.character(dd$getElementText()))
  ic=remDr$findElement('class', 'tran_type')
  icon=c(icon, as.character(ic$getElementText()))
}

#만들었던 네가지 벡터를 합쳐 데이터프레임으로 생성
tot_data=as.data.frame(cbind(icon, title, price, date))

