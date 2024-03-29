# by melda coskun on 28 Mar, 2024
## Customer Clustering
library(dplyr)
library(ggplot2)

# for data: https://www.kaggle.com/datasets/imakash3011/customer-personality-analysis
data = read.csv(file = "data/marketing_campaign.csv")
head(data)
summary(data)

# convert numerical values to categorical values
data$ID = as.factor(as.character(data$ID))
data$Marital_Status = as.factor(as.character(data$Marital_Status))

library(lubridate)                               

# calculate customers' age
data$Customer_Age = as.numeric(format(Sys.time(), "%Y"))- data$Year_Birth

# how long a customer enroled in a campaign in days, divide 365 in years.
data$Day_DT_Customer = (Sys.Date() - as.Date(parse_date_time(data$Dt_Customer, c("ymd", "dmy"))))


unique(length(data$ID)) # each row belong to a unique customer.

#recency, frequency, monetary
# Recency: Number of days since customer's last purchase


# Frequency : related variables
# NumWebPurchases: Number of purchases made through the company’s website
# NumCatalogPurchases: Number of purchases made using a catalogue
# NumStorePurchases: Number of purchases made directly in stores
# NumWebVisitsMonth: Number of visits to company’s website in the last month

# Monetary : related variables
# MntWines: Amount spent on wine in last 2 years
# MntFruits: Amount spent on fruits in last 2 years
# MntMeatProducts: Amount spent on meat in last 2 years
# MntFishProducts: Amount spent on fish in last 2 years
# MntSweetProducts: Amount spent on sweets in last 2 years
# MntGoldProds: Amount spent on gold in last 2 years

# I'll create new variables for Frequency and Monetary aggregating the related variables
data = data %>% mutate(Freq = (NumWebPurchases 
                                  + NumCatalogPurchases 
                                  + NumStorePurchases 
                                  + NumWebVisitsMonth))

head(data)
# Exploratory Data Analysis (EDA) of the predictor variables.
data = data %>% mutate(Mnt = (MntWines
                                 + MntFruits 
                                 + MntMeatProducts 
                                 + MntFishProducts
                                 + MntSweetProducts 
                                 + MntGoldProds))
data %>% select(Recency, Freq, Mnt) %>% head(10)
 