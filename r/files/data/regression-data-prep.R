### ---- Load packages ----

# load packages
library(magrittr)
library(tidyverse)
library(tidymodels)

### ---- Create training data and testing data ---- 

# set seed with mark
set.seed(1)

# make test / train split
split_ames <- initial_split(data = ames %>% mutate(row_number = row_number()),
                            prop = .8)

# save train data
data_train <- split_ames %>% training() %>% janitor::clean_names()

# remove row number
data_train %<>% select(-row_number)

# save test data
data_test <- split_ames %>% testing() %>% janitor::clean_names()

### ---- Initial EDA to eliminate pointless variables ----

# get all numeric variables
data_numeric <- data_train %>% select(where(is.numeric))

# correlation matrix and plot
data_cor <- data_numeric %>% as.matrix %>% cor
data_cor %>% corrplot::corrplot()

# get column names for non-pointless variables (continuous, not insignificant correlations with the response)
nms_num <- data_cor %>% 
  as.data.frame %>% 
  select(sale_price) %>% 
  filter(abs(sale_price) > 0.10) %>% 
  rownames

# get all categorical variables and the response
data_cat <- data_train %>% select(-where(is.numeric), sale_price)

# get names of columns without too few or too many categories
nms_cat <- data_cat %>% 
  select(-sale_price) %>% 
  map(\(col) length(unique(col))) %>%
  as.data.frame %>% 
  t() %>% 
  as.data.frame %>% 
  filter(between(V1, 2, 9)) %>% 
  rownames

# select only above variables
data_train %<>% select(all_of(c(nms_num, nms_cat)))
data_test %<>% select(all_of(c(nms_num, nms_cat)))

# remove everything from environment and save needed datasets
rm(data_cat, data_cor, data_numeric, split_ames, nms_cat, nms_num)
save.image(file = 'regression-data.RData')
