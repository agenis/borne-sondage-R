# details
#########

# This function works in combination with 
# - an USB pedal switch tuned to press 1, 1/2 or 1/2/3
# - the freeware Auto Keyboard set to the key [ENTER]
# design: marc.agenis-nevers@veolia.com

# packages
##########
# No package required

# functions
###########

Initialize = function() {
  timer.out <<- data.frame('datetime'=Sys.time(), 'key'=NA)
}

ReadKeyboard = function(script) { 
  press <- readline(prompt="# ")
  if (press != "") {
    timer.out <<- rbind(timer.out, list(Sys.time(), as.numeric(substring(press, 1, 1))))
    if (nrow(timer.out) > 10) {
      PlotSatisfaction(timer.out)
    }
  }
  press <- ReadKeyboard()
  return(n)
}

PlotSatisfaction = function(df) {
  freq <- attributes(diff.POSIXt(range(timer.out$datetime)))$units
  freq <- substr(freq, 1, nchar(freq)-1) 
  par(mfrow=c(3, 1))
  hist(timer.out[timer.out$key==1, ]$datetime, breaks=freq, main="unhappy",     col="orange", xlab=freq)
  hist(timer.out[timer.out$key==2, ]$datetime, breaks=freq, main="indifferent", col="grey", xlab=freq)
  hist(timer.out[timer.out$key==3, ]$datetime, breaks=freq, main="happy",       col="green", xlab=freq)
}

# RUN
#####

cat("\n\n\n\n\n\n\n\n\n\n\n")
Initialize()
ReadKeyboard()




