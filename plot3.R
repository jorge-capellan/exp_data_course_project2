
#Download the data
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

subset_data <- subset(data, fips=="24510")
head(subset_data,10)

pivot_data_BC2 <- aggregate(Emissions ~ year + type,subset_data,sum)
##we already have the dataset so let's plot a linear graph to see differences

png('plot3.png')
ggplot(pivot_data_BC2,level=type,aes(x=year,y=Emissions,color=type)) + geom_line()
dev.off()
