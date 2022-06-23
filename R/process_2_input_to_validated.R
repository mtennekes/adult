rm(list = ls())
gc()

library(tidyverse)

adult <- readRDS("./data/input/adult_input.rds")

table(adult$marital, adult$relationship)

# test the next error by changing the data: 
# adult$relationship[adult$marital == "Never-married"][1] = "Wife"

# base R way
if (any(adult$relationship[adult$marital == "Never-married"] %in% c("Husband", "Wife"))) {
  stop("Inconsistency detected")
}

# tidy way
adult_inconsistent <- adult %>% 
  filter(marital == "Never-married", 
         relationship %in% c("Husband", "Wife"))

if (nrow(adult_inconsistent) > 0) {
  stop("Inconsistency detected")
}

dir.create("./data/validated", recursive = TRUE)
saveRDS(object = adult, file = "./data/validated/adult_validated.rds")
write_csv2(adult, file = "./data/validated/adult_validated.csv")  
zip("./data/validated/adult_validated.zip", files = "./data/validated/adult_validated.csv")

