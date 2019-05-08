install.packages("rvest")
install.packages("dplyr")

girlsamsungurl1='http://www.snphone.co.kr/shop/?ca_id=COMAAA&select_key=&input_key=&Search_Order=&Search_Price=#brand_tap'
girlsamsungurl2='http://www.snphone.co.kr/shop/?SCD=&ca_id=COMAAA&Search_Order=&Search_Price=&select_key=&input_key=&p=1&p=2'
girlappleurl='http://www.snphone.co.kr/shop/?mode=search&ca_id=COMAAB'
girllgurl='http://www.snphone.co.kr/shop/?ca_id=COMAAH&select_key=&input_key=&Search_Order=&Search_Price=#brand_tap'

url=c(girlsamsungurl1, girlsamsungurl2, girlappleurl, girllgurl)

girlphone=c()
girlprice=c()

for(i in 1:4)
{
  phone=read_html(url[i])%>%html_nodes(".txt_prd")%>%html_nodes(".name")
  txt1=gsub("<p class=\"name\">\r\n\t\t\t\t\t\t\t\t","",phone)
  txt1=gsub("\t\t\t\t\t\t\t</p>","",txt1)
  girlphone=c(girlphone, txt1)
  price=read_html(url[i])%>%html_nodes(".price_b")
  txt2=gsub("<p class=\"price_b\"><span>ÆÇ¸Å°¡</span>","",price)
  txt2=gsub("<font>WON</font></p>","",txt2)
  girlprice=c(girlprice, txt2)
}

a=data.frame(phone1=girlphone, price1=girlprice)
write.csv(a, "D:/girldata.csv")


