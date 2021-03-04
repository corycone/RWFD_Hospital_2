#load libraries
library(tidyverse)
library(lubridate)

#load data

hospital_er.df <- read.csv("data/Hospital_ER.csv",  stringsAsFactors = FALSE)

#basics

dim(hospital_er.df)

colnames(hospital_er.df)

str(hospital_er.df)

#separete date and time

hospital_er.df$dateonly <- substring(hospital_er.df$date ,1,10)
hospital_er.df$timeeonly <- substring(hospital_er.df$date ,12,19)
