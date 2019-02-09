# Analysis script: compute values and create graphics of interest
install.packages("dplyr")
library("dplyr")
install.packages("ggplot2")
library("ggplot2")
install.packages("lubridate")
library("lubridate")
install.packages("tidyr")
library("tidyr")
install.packages("ggmap")
library("ggmap")

# Load in your data
evictions <- read.csv("data/Eviction_Notices.csv", stringsAsFactors = FALSE)
# Compute some values of interest and store them in variables for the report
features <- ncol(evictions)
# How many evictions were there?
evictions_amount <- nrow(evictions)
# Create a table (data frame) of evictions by zip code (sort descending)
zip_group <- evictions %>% group_by(Eviction.Notice.Source.Zipcode) %>% count() %>% 
  arrange(-n)
# Create a plot of the number of evictions each month in the dataset
by_month <- evictions %>% group_by(month = floor_date(as.Date(File.Date, 
                          format = "%m/%d/%y"), unit = "month")) %> count()
# Store plot in a variable
by_month_plot <- ggplot(by_month) + geom_line(mapping = aes(x = month, y = n), size = .1, color = "blue") +
  labs(
    title = "Number of evictions each month in San Francisco", 
    y = "Number of evictions", 
    x = "Month"
  )
# Map evictions in 2017 

# Format the lat/long variables, filter to 2017
evictions_2017 <- evictions %>% mutate(date = as.Date(File.Date, format="%m/%d/%y"))
%>%  filter(format(date, "%Y") == "2017") %>% separate(Location, c("lat", "long"), ", ")
evictions_2017 <- evictions_2017 %>% mutate(
  lat = as.numeric(gsub("\\(", "", lat)), 
  long = as.numeric(gsub("\\)", "", long)) 
) 

# Create a maptile background

)

# Add a layer of points on top of the map tiles

