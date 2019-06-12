cheat=c()

date1=as.Date(Sys.Date())
date2=as.Date("2019-06-01")
ago=as.numeric(date1-date2)
for(i in 0:ago){
  cheat=rbind(cheat,read.csv(paste("D:/total",format(Sys.Date()-i,"%y-%m-%d"),".csv"),head=TRUE))
         
}
cheat