
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

##Step 1: merge 2 datasets so the SCC column makes sense

dataset <- merge(data,code,by=c("SCC"))
head(dataset,2)

clean_dataset <- dataset[,c("SCC","fips","Pollutant","Emissions","type","year","Data.Category","Short.Name")]
head(clean_dataset,10) 


subset3 <- clean_dataset[clean_dataset$fips=="24510" & clean_dataset$type == "ON-ROAD", ]
head(subset3,2)

pivot3 <- aggregate(Emissions ~ year,subset3,sum)

png('plot5.png')
barplot(height=pivot3$Emissions, names.arg=pivot3$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Motor vehicle emissions at various years'))
dev.off()
