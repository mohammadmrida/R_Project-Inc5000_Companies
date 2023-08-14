# Data Analysis

#Load data:

# To view the loaded data frame
View(df)
str(df)
dim(df)

#Load library: the library I need is tidyverse, it is not installed.

# To install a package
install.packages("tidyverse")

# To work with library use the following 
library(tidyverse)


# Identify missing values in the dataframe.
colSums(is.na(df))

# There is no missing values to be removed.

# Remove duplicated rows based on "id" column.
df <- df %>% distinct(id, .keep_all=TRUE)
dim(df)

# Round of value to 2 places. dataframe $ column name to spacify the exact column
df$growth<- round(df$growth, digit=2)

# View to five row to verify the rounding
head(df)

# Loading "ggplot2" library
library(ggplot2)

# create a boxplot that labels outliers
ggplot(df, aes(x=revenue, y=growth)) + geom_boxplot(outlier.colour = "red", outlier.shape = 1)+ scale_x_continuous(labels = scales::comma)+coord_cartesian(ylim = c(0, 1000))

#Remove outliers in growth
Q1 <- quantile(df$growth, .25)
Q3 <- quantile(df$growth, .75)


#Calculate Interquartile range and creating new df named no_outlier
Q1 <- quantile(df$revenue, .25)
Q3 <- quantile(df$revenue, .75)
IQR <- IQR(df$revenue)
no_outliers <- subset(df, df$revenue> (Q1 - 1.5*IQR) & df$revenue< (Q3 + 1.5*IQR))
dim(no_outliers)

# Summary Statistics
summary(no_outliers)

# call back library
library(ggplot2)

# Vibariate Analysis Scatter Graph
ggplot(no_outliers, aes(x=rank, y=workers)) + geom_point()+ scale_y_continuous(labels=scales::comma)+coord_cartesian(ylim = c(0, 300))
# Vibariate Analysis with Bar Chart
ggplot(no_outliers, aes(x=yrs_on_list)) + geom_bar()+coord_cartesian(ylim = c(0, 1500), xlim=c(0,15))
# Line graph
ggplot(no_outliers, aes(x = revenue, y = growth)) + geom_line(color = "red")

# histogram
ggplot(no_outliers, aes(revenue)) + geom_histogram(bins = 20, color = "red")

# Density
ggplot(no_outliers, aes(x = revenue)) +geom_density()

ggplot(no_outliers, aes(x=rank, y=city)) + geom_point()

# Correlation

cor(no_outliers$growth,no_outliers$revenue)
cor(no_outliers$growth,no_outliers$workers)
cor(no_outliers$workers,no_outliers$revenue)
cor(no_outliers$workers,no_outliers$growth)

# Export a clean file
write.csv(no_outliers, "clean_dfinc5000.csv")
