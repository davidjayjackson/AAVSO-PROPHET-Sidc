library(tidyverse)
library(data.table)
library(prophet)
library(forecast)
library(lubridate)
library(ggeasy)

sidc <-fread("../db/SN_d_tot_V2.0.csv",sep=";")
colnames(sidc) <- c("Year","Month","Day", "Fdate","Spots", "Sd","Obs" ,"Defin"  )
sidc$Ymd <- as.Date(paste(sidc$Year, sidc$Month, sidc$Day, sep = "-"))
sidc1<- sidc %>% filter(Ymd>="1850-01-01") %>% select(Ymd,Spots)
colnames(sidc1) <- c("ds","y")
summary(sidc1)

df <-sidc1 
m <- prophet(seasonality.mode="multiplicative")
m <- add_seasonality(m, name="cycle_11year", period=365.25 * 11,fourier.order=5,mode="multiplicative")
m <- fit.prophet(m, df)
future <- make_future_dataframe(m,periods=8000,freq="day")
forecast <- predict(m, future)


plot(m, forecast) +ggtitle("SIDC Sunspot Prediction: Jan. 1850 - Oct. 2019") +ylab("Predicted Mean Wolf(Ra)") +xlab("Years" )