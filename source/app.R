library("dplyr")
library("knitr")
library("ggplot2")
library("leaflet")
library("shiny")
source("ui.R")
source("server.R")
library("ggplot2")
library(plotly)
library("raster")
install.packages("raster")

# Run the application 
shinyApp(ui = ui, server = server)



