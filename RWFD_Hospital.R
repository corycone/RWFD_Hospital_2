#load libraries
library(tidyverse)
library(lubridate)
library(RColorBrewer)

#load data

hospital_er.df <- read.csv("data/Hospital_ER.csv",  stringsAsFactors = FALSE)

#basics

dim(hospital_er.df)

colnames(hospital_er.df)

str(hospital_er.df)

#separete date and time

hospital_er.df$dateonly <- substring(hospital_er.df$date ,1,10)
hospital_er.df$timeonly <- substring(hospital_er.df$date ,12,19)

hospital_er.df$hospital_arrival <- ymd_hms(hospital_er.df$date)

hour_arrival <- hour(hospital_er.df$hospital_arrival)

#change date only to a date field type
hospital_er.df$dateonly <- date(hospital_er.df$dateonly)

#Explore wait times

ggplot(hospital_er.df, aes(x = patient_waittime)) +
  geom_histogram()

arrival_stats.df <- hospital_er.df %>% group_by(hour(hospital_arrival), department_referral) %>% summarise(n = mean(patient_waittime))

#general wait times

ggplot(arrival_stats.df, aes(x = `hour(hospital_arrival)`, y = n)) +
  geom_line() +
  labs(title = "Patient Wait Times by Hour of Arrival",
       x = "arrival hour",
       y = "wait time") +
  theme_classic() 

#by department of referral

ggplot(arrival_stats.df, aes(x = `hour(hospital_arrival)`, y = n, color = department_referral)) +
  geom_line() +
  scale_colour_brewer(palette = 'Set3') +
  labs(title = "Patient Wait Times by Hour of Arrival",
       subtitle = "by department of referral",
       x = "arrival hour",
       y = "wait time") +
  theme_classic() 
