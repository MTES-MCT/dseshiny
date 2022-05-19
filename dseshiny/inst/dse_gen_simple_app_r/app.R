#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dseshiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$head(
    suppressDependencies("bootstrap"),
    suppressDependencies("scaffolding"),
    # tags$link(
    #   rel = "stylesheet",
    #   type = "text/css",
    #   href = "css/bootstrap-corrige.css"),
    tags$style(HTML('
      . {font-family: "Marianne"}
      .fr-container--fluid { margin: 2rem;}
      .fr-container { max-width: 95% !important;}
      ')),
    tags$link(
      rel = "stylesheet",
      type = "text/css",
      href = "css/dsfr.css"),
    tags$script(src="js/dsfr.module.js"),
    tags$header(includeHTML("www/header.html")),
    tags$title("dsegen1")
  ),
    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    ),
  tags$footer(includeHTML("www/footer.html")),
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application
shinyApp(ui = dse_ui_regexp(ui), server = server)
