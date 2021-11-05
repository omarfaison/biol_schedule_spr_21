library(googlesheets4)
library(tidyverse)

gs4_deauth()
spring_courses<-read_sheet("https://docs.google.com/spreadsheets/d/1s0wp6QKvlOrVyuSoWivpgXcnHMTusn3YhwKLxI4Hx_4/edit?usp=sharing")

spring_bio<-spring_courses %>%
  filter(str_detect(COURSE_ID,"^BIOL")) %>%
  mutate(COURSE_TYPE=case_when(COURSE_ID == "BIOL116" ~ "mixed",
                               SEC <10 ~"lecture",
                               TRUE ~ "lab"))

bio_course_counts<-spring_bio %>%
  group_by(COURSE_ID, COURSE_TYPE, TERM_CODE) %>%
  summarize(sections=n(),
            seats=sum(as.numeric(MAX_ENROLL)),
            enrolled=sum(as.numeric(TOTAL_ENROLL)))