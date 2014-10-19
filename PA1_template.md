# Reproducible Research: Peer Assessment 1

===========================================


## Loading and preprocessing the data

1.Load the data (i.e. read.csv())

```r
dat <- read.csv("activity.csv")
```

2.Process/transform the data (if necessary) into a format suitable for your analysis

## What is mean total number of steps taken per day?

1.Make a histogram of the total number of steps taken each day

```r
dat_ag <- aggregate(steps ~ date, dat, FUN=sum)
hist(dat_ag$steps, breaks = 10)
```

![plot of chunk unnamed-chunk-2](./PA1_template_files/figure-html/unnamed-chunk-2.png) 

2.Calculate and report the mean and median total number of steps taken per day

```r
mean(dat_ag$steps)
```

```
## [1] 10766
```

```r
median(dat_ag$steps)
```

```
## [1] 10765
```


## What is the average daily activity pattern?

1.Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)

```r
plot(dat$interval, dat$steps, type="l")
```

![plot of chunk unnamed-chunk-4](./PA1_template_files/figure-html/unnamed-chunk-4.png) 

2.Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```r
maxsteps <- max(dat$steps, na.rm=TRUE)
intervalWithMaxSteps <- dat[dat$steps == maxsteps & !is.na(dat$steps), 3]
intervalWithMaxSteps
```

```
## [1] 615
```


## Imputing missing values

1.Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)

```r
sum(is.na(dat$steps))
```

```
## [1] 2304
```

2.Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

* Strategy: replace with mean of the corresponding 5-minute interval


3.Create a new dataset that is equal to the original dataset but with the missing data filled in.

```r
mean_ag <- aggregate(steps ~ interval, dat, FUN=mean)
names(mean_ag)<-c("interval","means")
dat2 <- merge(dat, mean_ag, by = "interval", all=TRUE)
dat2 <- dat2[order(dat2$date),]
dat2$steps[is.na(dat2$steps)]<-dat2$means[is.na(dat2$steps)]
```

4.Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?

* As you can see in the results below the value of the mean is not affected by our substitution to the missing values. The median is slightly different is now it is equal to the mean 


```r
dat2_ag <- aggregate(steps ~ date, dat2, FUN=sum)
hist(dat2_ag$steps, breaks =10)
```

![plot of chunk unnamed-chunk-8](./PA1_template_files/figure-html/unnamed-chunk-8.png) 

```r
mean(dat2_ag$steps)
```

```
## [1] 10766
```

```r
median(dat2_ag$steps)
```

```
## [1] 10766
```


## Are there differences in activity patterns between weekdays and weekends?

1.Create a new factor variable in the dataset with two levels - "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.


```r
dat$wd <- as.factor(weekdays(as.Date(dat$date, '%Y-%m-%d')))
dat$f <- factor(dat$wd, labels = c("weekend", "weekday", "weekday", "weekday", "weekday", "weekday", "weekend"))
```

```
## Warning: duplicated levels in factors are deprecated
```

```r
dat$f2 <- factor(dat$f, levels = c("weekday", "weekend"))
```


2.Make a panel plot containing a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis).


```r
wkday <- dat[dat$f2 == "weekday",]
wkend <- dat[dat$f2 == "weekend",]
#par(mfrow = c(2,1))
with(wkday, plot(interval,steps, type="l"))
```

![plot of chunk unnamed-chunk-10](./PA1_template_files/figure-html/unnamed-chunk-101.png) 

```r
with(wkend, plot(interval,steps, type="l"))
```

![plot of chunk unnamed-chunk-10](./PA1_template_files/figure-html/unnamed-chunk-102.png) 







