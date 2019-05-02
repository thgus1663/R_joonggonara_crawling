install.packages("taskscheduleR")
 
library(taskscheduleR)

taskscheduler_create(taskname = "mydailyscript", rscript = "D:\\joonggo.r", 
                     schedule = "DAILY", starttime = "10:29", startdate = format(Sys.Date(), "%Y/%m/%d"),
                     Rexe=file.path(Sys.getenv("R_HOME"),"bin","Rscript.exe"))

taskscheduler_delete("mydailyscript")