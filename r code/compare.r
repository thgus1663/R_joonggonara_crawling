#�ֱ�
jg=read.csv("D:/recentdata.csv", header=T, stringsAsFactors = F)
names(jg)=c("X.1","X","url","icon","title","price","date","deal","delivery","nickname","userid","sms")

ktjg=read.csv("D:/ktdata.csv", header=T, stringsAsFactors = F)
names(ktjg)=c("X.1","X","url","icon","title","price","date","deal","delivery","nickname","userid","sms")

#����
jg1=read.csv("D:/pastdatajg.csv", header=T, stringsAsFactors = F)



#��ġƮ
thecheat=read.csv("D:/totalthecheat.csv", header=T, stringsAsFactors = F)
thecheat[,4]=paste0("(", thecheat[,4], ")")



sch1=c()
sch2=c()
schp=c()
sch1c=c()
sch2c=c()
schpc=c()


###########skt###################
#�ֱ� �����Ϳ� ��ġƮ ���̵� ���ؼ� ��ġ�ϴ� �߰��� 125
for(i in 1:dim(thecheat)[1]){
  sch1=rbind(sch1, jg[jg[,11]==thecheat[i, 4],]) 
}
sch1 = sch1[!duplicated(sch1[,'X.1']),]

#�ֱ� �����Ϳ� ��ġƮ ���̵� ���ؼ� ��ġ�ϴ� ��ġƮ 11
for(i in 1:dim(sch1)[1]){
  sch1c=rbind(sch1c, thecheat[thecheat[,4]==sch1[i, 11],]) 
}
sch1c = sch1c[!duplicated(sch1c[,'X']),]



#�߰��� �޴��� ��ȣ �ִ°͸� ����
jgphone=jg[substr(jg[,12], 1, 3)=="010",]
jgphone=jgphone[!is.na(jgphone[,'X.1']), ]
#��ġƮ ����ȣ �������ΰ͸�
ctphone=thecheat[nchar(thecheat[,5])==13,]

#�ֱ� �����Ϳ� ��ġƮ ����ȣ ���ؼ� ��ġ�ϴ� �߰��� 48403
for(i in 1:dim(ctphone)[1]){
  sch2=rbind(sch2, jgphone[substr(jgphone[,12], 12, 13)==substr(ctphone[i, 5], 12,13),])
}
sch2 = sch2[!duplicated(sch2[,'X.1']),]

#�ֱ� �����Ϳ� ��ġƮ ����ȣ ���ؼ� ��ġ�ϴ� ��ġƮ
jgpn=unique(substr(sch2[, 12],12,13))
for(i in 1:length(jgpn)){
  sch2c=rbind(sch2c, ctphone[substr(ctphone[, 5], 12,13)==jgpn[i],]) 
}
sch2c = sch2c[!duplicated(sch2c[,'X']),]

#���� �����Ϳ� ��ġƮ ���̵� ���ؼ� ��ġ�ϴ� �߰���73
for(i in 1:dim(thecheat)[1]){
  schp=rbind(schp, jg1[jg1[,11]==thecheat[i, 4],])
}
schp = schp[!duplicated(schp[,'X.2']),]

#���� �����Ϳ� ��ġƮ ���̵� ���ؼ� ��ġ�ϴ� ��ġƮ10
for(i in 1:dim(schp)[1]){
  schpc=rbind(schpc, thecheat[thecheat[,4]==schp[i, 11],]) 
}
schpc = schpc[!duplicated(schpc[,'X']),]










############kt###################
ktsch1=c()
ktsch2=c()
ktsch1c=c()
ktsch2c=c()

#�ֱ� �����Ϳ� ��ġƮ ���̵� ���ؼ� ��ġ�ϴ� �߰��� 125
for(i in 1:dim(thecheat)[1]){
  ktsch1=rbind(ktsch1, ktjg[ktjg[,11]==thecheat[i, 4],]) 
}
ktsch1 = ktsch1[!duplicated(ktsch1[,'X.1']),]

#�ֱ� �����Ϳ� ��ġƮ ���̵� ���ؼ� ��ġ�ϴ� ��ġƮ 11
for(i in 1:dim(ktsch1)[1]){
  ktsch1c=rbind(ktsch1c, thecheat[thecheat[,4]==ktsch1[i, 11],]) 
}
ktsch1c = ktsch1c[!duplicated(ktsch1c[,'X']),]



#�߰��� �޴��� ��ȣ �ִ°͸� ����
ktjgphone=ktjg[substr(ktjg[,12], 1, 3)=="010",]
ktjgphone=ktjgphone[!is.na(ktjgphone[,'X.1']), ]
#��ġƮ ����ȣ �������ΰ͸�


#�ֱ� �����Ϳ� ��ġƮ ����ȣ ���ؼ� ��ġ�ϴ� �߰��� 48403
for(i in 1:dim(ctphone)[1]){
  ktsch2=rbind(ktsch2, ktjgphone[substr(ktjgphone[,12], 12, 13)==substr(ctphone[i, 5], 12,13),])
}
ktsch2 = ktsch2[!duplicated(ktsch2[,'X.1']),]

#�ֱ� �����Ϳ� ��ġƮ ����ȣ ���ؼ� ��ġ�ϴ� ��ġƮ
ktjgpn=unique(substr(ktsch2[, 12],12,13))
for(i in 1:length(ktjgpn)){
  ktsch2c=rbind(ktsch2c, ctphone[substr(ctphone[, 5], 12,13)==ktjgpn[i],]) 
}
ktsch2c = ktsch2c[!duplicated(ktsch2c[,'X']),]




write.csv(sch1, "D:/recentid.csv")
write.csv(sch1c, "D:/recentidct.csv")
write.csv(ktsch1, "D:/ktrecentid.csv")
write.csv(ktsch1c, "D:/ktrecentidct.csv")
write.csv(sch2, "D:/recentph.csv")
write.csv(sch2c, "D:/recentphct.csv")
write.csv(schp, "D:/pastid.csv")
write.csv(schpc, "D:/pastidct.csv")