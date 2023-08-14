boxplot(growth ~ revenue, data=df, main ="Box Plot", xlab= "Growth", ylab="Revenue")

## STEP 1: IMPORTING DATA
# Using Import Dataset then choosing From Text (base) I have uploaded the data and named it 'df'
# We will be working with tidyverse package which is already installed. To work with that package, I am going to call tidyverse package with following command
library(tidyverse)

# Before we start working with the dataet we need to be familiar with the data
# to view the structure of the dataframe, we use following command
str(dfCrimes)
# To check the dimention of dataframe, we use following command
dim(dfCrimes)
# to view the dataframe in table form, we use following command
View(dfCrimes)


## STEP 2: REMOVING MISSING VALUES
# Before removing any data we need to check empty values on each column
colSums(is.na(dfCrimes))

# There is no column with fully empty values or column with more than 50% empty values. Therefore I am going to remove the empty rows only.
# To remove empty rows, we use following command
dfCrimes <- na.omit(dfCrimes)

# After removing the empty rows, we will check again if there any more empty row 
colSums(is.na(dfCrimes))


## STEP 3: REMOVING DUPLICATES
# After removing the empty rows, we will remove any duplicates from the dataset. To do that I will be using ID column, as ID should be unique. 
# Removing duplicates, we use following command
dfCrimes <- dfCrimes[!duplicated(dfCrimes$ID), ]
dim(dfCrimes)
head(dfCrimes)
## STEP 4: REMOVING OUTLIERS
#There is no Outliers to remove. 

boxplot(dfCrimes$Beat)
boxplot(dfCrimes$Beat ~ dfCrimes$District, data=dfCrimes$, main ="Box Plot", xlab= "Beat", ylab="District")

ggplot(dfCrimes, aes(x=Beat, y=Year)) + geom_boxplot(outlier.colour = "red", outlier.shape = 1)

#boxplot
plot(dfCrimes$Beat, dfCrimes$District, type="l", main="Line Plot", xlab="Beat", ylab="District", col="blue")
boxplot(df2$Beat, df2$District, type="l", main="Line Plot", xlab="Beat", ylab="District", col="blue")

#Instead we will use dplyr package to calculate crime types in each year
library(dplyr)
# creating a new dataframe using calculation function
dfCrimes1 <- count(dfCrimes, Primary.Type,Year)
colnames(dfCrimes1)[3]="Primary.Types.No"

# creating a 2nd dataframe using calculation function
dfCrimes2 <- count(dfCrimes, Description, Year)
colnames(dfCrimes2)[3]="Description.No"

library(ggplot2)
ggplot(dfCrimes1, aes(x=Primary.Types.No, y=Year)) + geom_boxplot(outlier.colour = "red", outlier.shape = 1)
ggplot(dfCrimes2, aes(x=Description.No, y=Year)) + geom_boxplot(outlier.colour = "red", outlier.shape = 1)

## STEP 5: FEATURING ENGINEERING
ggplot(dfCrimes1, aes(x=Primary.Types.No, y=Year)) + geom_point()+ scale_y_continuous(labels=scales::comma)
ggplot(dfCrimes2, aes(x=Description.No, y=Year)) + geom_point()+ scale_y_continuous(labels=scales::comma)

ggplot(dfCrimes2, aes(Description.No)) + geom_bar()+coord_cartesian(ylim = c(0, 1500), xlim=c(0,30))+ geom_text(aes(label=..count..),stat="count", hjust=1.5, colour="red")




## STEP 6: SUMMARY STATISTICS
summary(dfCrimes)

summary(dfCrimes1)

## STEP 7: EDA



## STEP 8: EXPORT DATA


