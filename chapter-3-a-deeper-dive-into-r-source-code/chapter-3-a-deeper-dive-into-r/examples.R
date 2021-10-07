
matt <- list(userid = "mattjcamp",
             password = "password123",
             playlist = c(12,332,45))
class(matt) <- "user"

attributes(matt)

createPlaylist.user <- function(user, playlist=NULL){
  user$playlist <- playlist
  return(user)
}

matt <- createPlaylist.user(matt, c(11,12))

createPlaylist <- function(object, value){
  
  UseMethod("createPlaylist", object)
}

matt <- createPlaylist(matt, c(21,31))

setClass("user",
         representation(userid="character",
                        password="character",
                        playlist="vector"
         )
)

lynn <- new("user", 
            userid="lynn", 
            password="test", 
            playlist=c(1,2))

setMethod("createPlaylist", "user", function(object, value){
  object@playlist <- value
  return(object)
})

lynn <- createPlaylist(lynn, c(1001, 400))
lynn

library(tidyverse)

load("life_expectancy.rdata") 

round(mean(subset(life_expectancy, race == "All Races")$death_rate, na.rm = TRUE), 1)

life_expectancy %>%
  subset(race == "All Races") %>% 
  .$death_rate %>%
  mean() %>%
  round(1)

iris %>% 
  as_tibble()

life_expectancy %>%
  filter(race == "All Races") %>% 
  summarize(avg = mean(death_rate)) %>% 
  mutate(avg = round(avg, 1))

life_expectancy %>%
  filter(race == "All Races") %>% 
  group_by(sex) %>%
  summarize(avg = mean(death_rate)) %>% 
  mutate(avg = round(avg, 1))

labels <- tribble(
  ~key, ~new_label,
  "Both Sexes", "All Genders", 
  "Female", "Identifies Female", 
  "Male", "Identifies Male"
)

life_expectancy %>%
  filter(race == "All Races") %>%
  group_by(sex) %>%
  summarize(avg = mean(death_rate)) %>% 
  inner_join(labels, by = c("sex" = "key")) %>%
  mutate(avg = round(avg, 1)) %>% 
  select(gender = new_label, avg_death_rate = avg)

avg_death_rates_by_gender <- 
  life_expectancy %>%
  filter(race == "All Races") %>% 
  group_by(sex) %>%
  summarize(avg = mean(death_rate)) %>% 
  inner_join(labels, by = c("sex" = "key")) %>%
  mutate(avg = round(avg, 1)) %>% 
  select(gender = new_label, avg_death_rate = avg)

avg_death_rates_by_gender

life_expectancy %>% 
  filter(str_detect(race, "All"))

life_expectancy <-
  life_expectancy %>%
  mutate(race = str_replace(race, "All", "Most"))

