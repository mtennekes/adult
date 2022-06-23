rm(list = ls())
gc()

library(tidyverse)

adult <- read_csv2("./data/raw/adult.csv")

sum(adult$fnlwgt)

adult2 <- adult %>% 
  rename(weight = fnlwgt,
         educ_num = 'education-num',
         marital = 'marital-status')

educ_table <- adult2 %>% 
  group_by(education, educ_num) %>% 
  summarise(n = n()) %>% 
  arrange(educ_num)

adult3 <- adult2 %>% 
  mutate(education = factor(education, levels = educ_table$education),
         educ_num = NULL)


ggplot(adult3, aes(x = education)) +
  geom_bar(stat = "count")


dir.create("./data/input", recursive = TRUE)
saveRDS(object = adult3, file = "./data/input/adult_input.rds")
write_csv2(adult3, file = "./data/input/adult_input.csv")  
zip("./data/input/adult_input.zip", files = "./data/input/adult_input.csv")

