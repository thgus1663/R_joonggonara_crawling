library(taskscheduleR)

my="D:/script.r"

taskscheduler_create(taskname = "mydailyscript", rscript = my, 
                     schedule = "HOURLY", starttime = "00:00", startdate = format(Sys.Date(), "%Y/%m/%d"))

taskscheduler_delete("mydailyscript")
 