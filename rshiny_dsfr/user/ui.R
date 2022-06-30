output$pageStub <- renderUI(fluidPage(tags$div(class='fr-container fr-py-16v', 
                                               # Mettre vos graphiques ci-dessous
                                                        numericInput('n', 'Number of obs', 100),
                                                        plotOutput('plot')
)))
