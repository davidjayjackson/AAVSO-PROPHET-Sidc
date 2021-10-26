library(tidyverse)
library(ggvis)
library(scales)

rm(list=ls())
df <- read_csv("./SN_d_tot_V2.0.csv") %>%
  rename(dec_yr = ISN) %>% rename(ISN = X)

df %>% filter(Year >= 1920 & Year <=2020) %>%group_by(Year) %>%
  summarise(Max = max(ISN,na.rm= T)) %>%
  ggplot(aes(x=Year,y=Max)) + geom_col() +
  labs(title = "Max ISN by Year: 1945 - 2021")

df %>% filter(Year >= 1920 & Year <=2020) %>%group_by(Year) %>%
  summarise(Max = mean(ISN,na.rm = T)) %>%
  ggplot(aes(x=Year,y=Max)) + geom_col() +
  labs(title = "Mean ISN by Year: 1945 - 2021")

df %>% filter(Year >= 1920 & Year <=2020) %>%group_by(Year) %>%
  summarise(Max = median(ISN,na.rm = T)) %>%
  ggplot(aes(x=Year,y=Max)) + geom_col() +
  labs(title = "Median ISN by Year: 1945 - 2021")

