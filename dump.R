
-------
  s <- sapply(unique(dat$date), function(x) sum(dat[dat$date == x,1], na.rm = TRUE))
hist(s, breaks = 60)
mean(dat$steps, na.rm=TRUE)
m1 <- sapply(unique(dat$date), function(x) mean(dat[dat$date == x,1], na.rm = TRUE))
m1[is.nan(m1)]<-0
m1
------
  
  #install.packages("lubridate")
  #library("lubridate")
  
  