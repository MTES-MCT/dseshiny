### DSFR
### v1.51 - Mikaël Folio - Juin 2022
#
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
# Mettre vos librairies ci-dessous

# Configuration des variables du DSFR et des composants à afficher
source("rshiny_dsfr/user/variables_dsfr.R",encoding = "UTF-8",local=T)
# Header de la page (NE PAS MODIFIER)
source("rshiny_dsfr/user/header.R",encoding = "UTF-8",local=T)
# Footer de la page (NE PAS MODIFIER)
source("rshiny_dsfr/user/footer.R",encoding = "UTF-8",local=T)
#
if (activerDSFR == "oui"){
#################################################################################
#########                                                               #########
#########          NE PAS MODIFIER LE CODE DE CETTE PAGE                #########
#########                                                               #########
#################################################################################
#########                                                               #########
#########               Les fichiers utilisateurs sont :                #########
#########                                                               #########
#########                        user/server.R                          #########
#########                          user/ui.R                            #########
#########                                                               #########
#########        Merci de n'utiliser que les fichiers ci-nommés         #########
#########                                                               #########
#################################################################################
}
# put a message in console or server log; note this happens only when the app is started!
cat("uiStub application started...\n")

ui <- uiOutput("uiStub")                                # single-output stub ui

server <- function(input, output, session) {
   cat("Session started.\n")                               # this prints when a session starts
   onSessionEnded(function() {cat("Session ended.\n\n")})  # this prints when a session ends

   ###### build menu; same on all pages
   output$uiStub <- renderUI(             # a single-output stub ui basically lets you
      fluidPage(                                  #     move the ui into the server function
        # Suppression du css de boostrap qui entre en conflit avec celui du DSFR
        suppressDependencies("bootstrap"),
        suppressDependencies("jquery"),
        if (activerDSFR == "oui"){header},
        selection1 <- tags$main(uiOutput("pageStub")),

        if (activerDSFR == "oui"){footer},
                                  # loaded server code should render the
        # Scripts
        tags$script(src="dsfr/dsfr/dsfr.module.js", type="module"),
        tags$script(src="dsfr/dsfr/dsfr.nomodule.js", nomodule, type="text/javascript"),
        # Mise en place mode sombre
        includeHTML("rshiny_dsfr/user/displaymode.Rhtml"),
        # Consentement des cookies
        includeHTML("rshiny_dsfr/user/cookies-consent.Rhtml"),
        tags$script(servicesCookies),
        includeHTML("rshiny_dsfr/user/messcripts.Rhtml")

      )                                           #    rest of the page to this output$

   )

   # load server code for page specified in URL
                                                        #    names to prevent Unix case problems)
   fname = isolate(session$clientData$url_search)       # isolate() deals with reactive context
   if(nchar(fname)==0) { fname = "?home" }              # blank means home page
   fname = paste0(substr(fname, 2, nchar(fname)), ".R") # remove leading "?", add ".R"

   if(!fname %in% validFiles){ fname = "?404" }
   cat(paste0("Session filename: ", fname, ".\n"))      # print the URL for this session

   if(!fname %in% validFiles){                          # is that one of our files?
     output$pageStub <- renderUI(                       # erreur 404
       tags$div(class="fr-container ",
         tags$nav(role="navigation", class="fr-breadcrumb",
           tags$button(class="fr-breadcrumb__button", "Voir le fil d’Ariane"),
           tags$div(class="fr-collapse", id="breadcrumb-1",
             tags$ol(class="fr-breadcrumb__list",
               tags$li(tags$a(class="fr-breadcrumb__link", href="/", "Accueil")),
               tags$li(tags$a(class="fr-breadcrumb__link", "Page non trouvée"))
             )
           )
         ),
         tags$div(class="fr-grid-row fr-grid-row--center fr-grid-row--gutters  fr-mb-3v",
           tags$div(class="fr-col-12 fr-col-md-8",
             tags$div(
               tags$h1(class="fr-h1", "Page non trouvée"),
               tags$p(class="fr-text--sm", "ERREUR 404"),
               tags$p("La page que vous cherchez est introuvable. Excusez-nous pour la gêne occasionnée."),
               tags$p(class="fr-text--sm", "Si vous avez tapé l'adresse web dans le navigateur, vérifiez qu'elle est correcte. La page n'est peut être plus disponible.", tags$br(), "Dans ce cas, pour continuer votre visite, vous pouvez consulter notre page d'accueil, ou effectuer une recherche avec notre moteur de recherche en haut de page.", tags$br(), "Sinon, contactez-nous pour que l'on puisse vous rediriger vers la bonne information."),
             )
           ),
           tags$div(class="fr-col-12 fr-col-md-4",
             tags$img(src="img/error_img.png", width="308", alt=""),
           ),
           tags$a(href="/", tags$button(id="home", class="fr-btn", "Page d'accueil")), " ", tags$a(href="mailto:", style="background-image:none;", tags$button(class="fr-btn fr-btn--secondary", "Nous contacter"))
         ),
         tags$br(),
       )
     )
      return()    # to prevent a "file not found" error on the next line after a 404 error
   }
   source(fname, local=TRUE)                            # load and run server code for this page
}
# Run the application
shinyApp(ui = ui, server = server)
