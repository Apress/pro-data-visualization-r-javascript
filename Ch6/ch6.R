bugExport <- "allbugs.csv"
bugs <- read.table(bugExport, header=TRUE, sep=",")
as.Date(bugs$Date,"%m/%d/%y")
order(as.Date(bugs$Date,"%m/%d/%y"))
bugs <- bugs[order(as.Date(bugs$Date," %m/%d/%y ")),]
write.table(bugs, col.names=TRUE, row.names=FALSE, file="allbugsOrdered.csv", quote = FALSE, sep = ",")

totalBugsByDate <- table(bugs$Date)
plot(totalBugsByDate, type="l", main="New Bugs by Date", col="red", ylab="Bugs")
runningTotalBugs <- cumsum(totalBugsByDate)
runningTotalBugs
plot(runningTotalBugs, type="l", xlab="", ylab="", pch=15, lty=1, col="red", main="Cumulative Defects Over Time", axes=FALSE)
axis(1, at=1: length(runningTotalBugs), lab= row.names(totalBugsByDate))
axis(2, las=1, at=10*0:max(runningTotalBugs))


bugsBySeverity <- table(factor(bugs$Date),bugs$Severity)
bugsBySeverity

plot(bugsBySeverity[,3], type="l", xlab="", ylab="", pch=15, lty=1, col="orange", main="New Bugs by Severity and Date", axes=FALSE)
lines(bugsBySeverity[,1], type="l", col="red", lty=1)
lines(bugsBySeverity[,2], type="l", col="yellow", lty=1)
axis(1, at=1: length(runningTotalBugs), lab= row.names(totalBugsByDate))
axis(2, las=1, at=0:max(bugsBySeverity[,3]))
legend("topleft", inset=.01, title="Legend", colnames(bugsBySeverity), lty=c(1,1,1), col= c("red", "yellow", "orange"))

plot(cumsum(bugsBySeverity[,3]), type="l", xlab="", ylab="", pch=15, lty=1, col="orange", main="Running Total of Bugs by Severity", axes=FALSE)
lines(cumsum(bugsBySeverity[,1]), type="l", col="red", lty=1)
lines(cumsum(bugsBySeverity[,2]), type="l", col="yellow", lty=1)
axis(1, at=1: length(runningTotalBugs), lab= row.names(totalBugsByDate))
axis(2, las=1, at=0:max(cumsum(bugsBySeverity[,3])))
legend("topleft", inset=.01, title="Legend", colnames(bugsBySeverity), lty=c(1,1,1), col= c("red", "yellow", "orange"))

