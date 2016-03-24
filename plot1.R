fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "Fnei.zip", method = "curl")
unzip("Fnei.zip")

##Read the file in a variable
dataFile <- "./SummarySCC_PM25.rds"
data <- readRDS(dataFile)
head(data,2)

dataFile2 <- "./Source_Classification_Code.rds"
code <- readRDS(dataFile2)
head(code,2)

head(data,2)
head(code,2)
pivot_data <- aggregate(Emissions ~ year,data,sum)

png('plot1.png')
barplot(height=pivot_data$Emissions, names.arg=pivot_data$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()
