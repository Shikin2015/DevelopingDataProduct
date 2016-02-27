library(shiny)

d_years <- c("2012", "2013","2014", "2015")
d_graf <- c("By Year", "Top 10 States", "Comparison By 4 States")

fluidPage(
  pageWithSidebar(
    headerPanel("Malaysia - Dengue Cases from Year 2012 To 2015"),
    
    sidebarPanel(
      helpText("Please choose the year to see list of dengue data",  
               "in LIST OF DENGUE DATA tab."),
      selectInput("datayear", label = "Select year", choices = d_years),
      helpText("Please click PLOT DENGUE CASES tab to see ", 
               "the general trend of dengue outbreak", 
               "in Malaysia throughout the years"),
      selectInput("grafA", label = "Select plot type", choices = d_graf)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("List Of Dengue Data", tableOutput("data_table")),
        tabPanel("Plot Dengue Cases", plotOutput("data_plot")))
      )
  )
)