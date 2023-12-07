library(shiny)
library(ggplot2)
library(DT)

# Define UI
ui <- navbarPage(
  title = "",
  tags$head(
    tags$style(HTML("
            .navbar {
                background-color: green;
                color: white;
            }
            .navbar-brand {
                color: white;
            }
        "))
  ),
  tabPanel("Dashboard de Iris",
           sidebarLayout(
             sidebarPanel(
               tags$h1("Dashboard de Iris", class = "main-title"),
               textOutput("customMessage"),
               hr(),
               sidebarMenu(
                 menuItem("Gráficos", tabName = "graficos"),
                 menuItem("Tabla", tabName = "tabla")
               )
             ),
             mainPanel(
               tabItems(
                 tabItem(tabName = "graficos",
                         plotOutput("plot1"),
                         plotOutput("plot2"),
                         plotOutput("plot3")
                 ),
                 tabItem(tabName = "tabla",
                         DTOutput("table")
                 )
               )
             )
           )
  )
)

# Define Server
server <- function(input, output) {
  data(iris)
  
  output$customMessage <- renderText({
    return("Bienvenido al dashboard del conjunto de datos Iris.")
  })
  
  output$plot1 <- renderPlot({
    ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
      geom_point()
  })
  
  output$plot2 <- renderPlot({
    ggplot(iris, aes(x = Petal.Length, fill = Species)) + 
      geom_histogram(position = 'dodge', bins = 30)
  })
  
  output$plot3 <- renderPlot({
    ggplot(iris, aes(x = Petal.Width, fill = Species)) + 
      geom_density(alpha = 0.7)
  })
  
  output$table <- renderDT({
    datatable(iris[1:10, ], options = list(pageLength = 10))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
