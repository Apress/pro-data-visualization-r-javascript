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


# Code from Ch 7 Starts Here:
totalBugsBySeverity <- c(sum(bugsBySeverity[,1]), sum(bugsBySeverity[,2]), sum(bugsBySeverity[,3]))
barplot(totalBugsBySeverity, main="Total Bugs by Severity")
axis(1, at=1: length(totalBugsBySeverity), lab=c("Blocker", "Critical", "Minor"))

t(bugsBySeverity)
barplot(t(bugsBySeverity), col=c("#CCCCCC", "#666666", "#AAAAAA"))
legend("topleft", inset=.01, title="Legend", c("Blocker", "Criticals", "Minors"), fill=c("#CCCCCC", "#666666", "#AAAAAA"))

barplot(t(bugsBySeverity), beside=TRUE, col=c("#CCCCCC", "#666666", "#AAAAAA"))
legend("topleft", inset=.01, title="Legend", c("Blocker", "Criticals", "Minors"), fill=c("#CCCCCC", "#666666", "#AAAAAA"))

prodIncidentsFile <- "http://jonwestfall.com/data/productionincidents.csv";
prodData <- read.table(prodIncidentsFile, sep=",", header=TRUE)
prodData

prodIncidentByFeature <- aggregate(prodData$ID, by=list(Feature=prodData$Feature), FUN=length)
barplot(prodIncidentByFeature$x)
prodIncidentByFeature <- prodIncidentByFeature[order(prodIncidentByFeature$x),]
opar <- par(no.readonly=TRUE)
par(las=3)
barplot(prodIncidentByFeature$x, xlab="Number of Incidents", names.arg=prodIncidentByFeature$Feature, horiz=TRUE, space=1, cex.axis=0.6, cex.names=0.8, main="Production Incidents by Feature", col= "#CCCCCC")
par(opar)

prodIncidentByFeatureBySeverity <- table(factor(prodData$Feature),prodData$Severity)
prodIncidentByFeatureBySeverity

opar <- par(no.readonly=TRUE)
par(las=3, mar=c(5,5,5,5))
barplot(t(prodIncidentByFeatureBySeverity), xlab="Number of Incidents", names.arg=rownames(prodIncidentByFeatureBySeverity), horiz=TRUE, space=1, cex.axis=0.6, cex.names=0.8, main="Production Incidents by Feature", col=c("#CCCCCC", "#666666", "#AAAAAA", "#333333"))
legend("bottom", inset=.01, title="Legend", c("Sev1", "Sev2"), fill=c("#CCCCCC", "#666666"))
par(opar)

