output$pageStub <- renderUI(
  tags$div(class="fr-container ",
    tags$div(class="fr-grid-row",
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
      tags$a(href="/", tags$button(class="fr-btn", "Page d'accueil")), " ", tags$a(href="", style="background-image:none;", tags$button(class="fr-btn fr-btn--secondary", "Nous contacter")) 
    )
  )
)