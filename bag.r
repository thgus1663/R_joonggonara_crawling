library(RSelenium) 

#pjs <- wdman::phantomjs()
remDr <- remoteDriver(browserName = "phantomjs", port = 4567L)

remDr$open() # ũ�� â ����
remDr$navigate("https://nid.naver.com/nidlogin.login?mode=form&url=https%3A%2F%2Fwww.naver.com") # �α��� �� �������� �̵�

txt_id<-remDr$findElement(using="id",value="id") # ������ �ҽ����� id�̰� ���� id�� ���� ã�� txt_id��
txt_pw<-remDr$findElement(using="id",value="pw") # ���� ���� id�̰� ���� pw
login_btn<-remDr$findElement(using="class",value="btn_global") # �α��� ��ư�� Ŭ������ btn_global

txt_id$setElementAttribute("value","ddddd") # �ܡܡܡܡܿ� ���̵� �Է�
txt_pw$setElementAttribute("value","ddddd") # �ܡܡܡܡܿ� ��й�ȣ �Է�
login_btn$clickElement() # �α��� ��ư Ŭ��

#�߰��󿡼� ��ǰ[����]�� url�ּ�
url="https://m.cafe.naver.com/ArticleList.nhn?search.clubid=10050146&search.menuid=782&search.boardtype=L" 

#������ �׸��� ������ ���� ����
title=c()
price=c()
date=c()
icon=c()


remDr$navigate(url) #�� url�� �̵�
href=c() #�� �Խñ��� Ŭ������ �� �̵��ϴ� ��ũ�� ������ ���� ����
board=remDr$findElements('class', 'board_box ')

#�� ȭ�鿡 ���̴� �Խ��� ��� �� ��ŭ �ݺ�
for(i in 1:length(board)){
  box=board[[i]]$findChildElement('tag name', 'a')
  tit=box$findChildElement('class','tit')
  title=c(title,as.character(tit$getElementText())) #������ ���Ϳ� ����
  href=c(href,as.character(box$getElementAttribute('href'))) #�Խñ۷� ���� url �ּ� ���Ϳ� ����
}

#������ �����ߴ� �����۸�ũ�� ������ŭ �ݺ�
for(j in 1:length(href)){
  remDr$navigate(href[j]) #���Ϳ� ����� url�� ���ʷ� ����
  pr=remDr$findElement('class', 'price') #������ ��Ÿ���� �κ��� ã��
  price=c(price, as.character(pr$getElementText())) #ã�� ������ �ϳ��� ���Ϳ� �߰��Ͽ� ����, �ؿ��� ������ �������
  dd=remDr$findElement('class', 'board_time')
  date=c(date, as.character(dd$getElementText()))
  ic=remDr$findElement('class', 'tran_type')
  icon=c(icon, as.character(ic$getElementText()))
}

#������� �װ��� ���͸� ���� ���������������� ����
tot_data=as.data.frame(cbind(icon, title, price, date))

