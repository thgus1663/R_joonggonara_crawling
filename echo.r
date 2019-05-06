library(rvest)
library(dplyr)

echosamsungurl='http://happyecoshop.co.kr/goods_list.php?Index=33&sty_num=1'
echoappleurl='http://happyecoshop.co.kr/goods_list.php?Index=32&sty_num=1'
echolgurl='http://happyecoshop.co.kr/goods_list.php?Index=146&sty_num=1'

echophone=c()
echoprice=c()
node=read_html(echosamsungurl)%>%html_nodes(".blo_list")
phone=html_nodes(node,'.roll_name')
txt1=gsub("<span class=\"roll_name\">","",phone)
txt1=gsub("</span>","",txt1)
echophone=c(echophone, txt1)
price=html_nodes(node,'.roll_won')
txt2=gsub("<span class=\"roll_won\">\n\t","",price)
echoprice=c(echoprice, txt2)

node=read_html(echoappleurl)%>%html_nodes(".blo_list")
phone=html_nodes(node,'.roll_name')
txt1=gsub("<span class=\"roll_name\">","",phone)
txt1=gsub("</span>","",txt1)
echophone=c(echophone, txt1)
price=html_nodes(node,'.roll_won')
txt2=gsub("<span class=\"roll_won\">\n\t","",price)
echoprice=c(echoprice, txt2)

node=read_html(echolgurl)%>%html_nodes(".blo_list")
phone=html_nodes(node,'.roll_name')
txt1=gsub("<span class=\"roll_name\">","",phone)
txt1=gsub("</span>","",txt1)
echophone=c(echophone, txt1)
price=html_nodes(node,'.roll_won')
txt2=gsub("<span class=\"roll_won\">\n\t","",price)
echoprice=c(echoprice, txt2)


a=cbind(echophone, echoprice)
a