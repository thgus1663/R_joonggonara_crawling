install.packages("RSelenium")
library(RSelenium) 
library(XML)
library(stringr)
install.packages("rvest")
library(rvest)

pjs <- wdman::phantomjs()
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)
remDr$open() #ũ�� â ����
remDr$navigate("https://nid.naver.com/nidlogin.login?mode=form&url=https%3A%2F%2Fwww.naver.com") #���̹� �α��� â ����
txt_id<-remDr$findElement(using="id",value="id") 
txt_pw<-remDr$findElement(using="id",value="pw")

txt_id$setElementAttribute("value","111")
txt_pw$setElementAttribute("value","111") #���̵� ��й�ȣ �Է�
btn <- remDr$findElement(using="xpath", value='//*[@id="frmNIDLogin"]/fieldset/input') 
btn$clickElement() #�α��� ��ư ������

title=c()
price=c()
date=c()
icon=c()
content=c()
skt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=339&search.boardtype=L#'
kt_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=424&search.boardtype=L'
lgu_url='https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=425&search.boardtype=L'
skt_kt_lgu=c(skt_url, kt_url, lgu_url) #�Խ��� url ���͸� �������

for(j in 1:length(skt_kt_lgu)){
  remDr$navigate(skt_kt_lgu[j])

  
  #num=1 #�� �� ������ �������ΰ�
  #for(i in 1:num){
  #   btn1 <- remDr$findElement(using="xpath", value='//*[@id="btnNextList"]/a') 
  #   btn1$clickElement() #������ ��ư ������
  # } 
  url=c()
  box=remDr$findElements('class', 'board_box ')
  for(i in 1:length(box)){
    box1=box[[i]]$findChildElement('tag name', 'a')
    tit=box1$findChildElement('class','tit')
    title=c(title,as.character(tit$getElementText())) #������ ���Ϳ� ����
    url=c(url,as.character(box1$getElementAttribute('href'))) #�Խñ۷� ���� url �ּ� ���Ϳ� ����
  }
  
  for(i in 1:length(url)){
    remDr$navigate(url[i]) #���Ϳ� ����� url�� ���ʷ� ����
    body=remDr$getPageSource()[[1]]
    body=read_html(body)
    error=html_node(body, '.error_content_body')
    if(length(error)!=0)
    {
      price=c(price, NA)
      date=c(date, NA)
      icon=c(icon, NA)
      content=c(content, NA)
    }
    else
    {
      prc=remDr$findElement('class', 'price')
      price=c(price, as.character(prc$getElementText()))
      dy=remDr$findElement('class', 'board_time')
      date=c(date, as.character(dy$getElementText()))
      ic=remDr$findElement('class', 'tran_type')
      icon=c(icon, as.character(ic$getElementText()))
      body=remDr$getPageSource()[[1]]
      body=read_html(body)
      txt1=html_node(body, '#postContent') %>% html_nodes(xpath='//*[@id=\"postContent\"]/p[2]')
      txt2=html_node(body, '#postContent') %>% html_nodes('.NHN_Writeform_Main')
      if(length(txt1)!=0){
        //
      }else{
        //
      }
    }

  }
}

totaldf=cbind(icon, title, price, date, content)


