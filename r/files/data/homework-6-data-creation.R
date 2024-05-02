library(tidyverse)
x = read.csv("homework-6-data.csv")

data_soybean = x$Soybean_yield
data_soybean = data_soybean[complete.cases(data_soybean)]

data_earnings = x %>% select(starts_with("earn")) %>% rename(X1 = 1, X2 = 2)
data_earnings = data_earnings[1:sum(!is.na(data_earnings$X2)),]

data_bacteria = x$Bacteria
data_bacteria = data_bacteria[complete.cases(data_bacteria)]

data_40_yard_dash = x %>% select(5:7) %>% rename(Before = 2, After = 3)

rm(x)

save.image("homework-6-data.RData")

load("homework-6-data.RData")
