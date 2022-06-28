output$pageStub <- renderUI(
  tags$div(class="fr-container", id="container",
    tags$nav(role="navigation", class="fr-breadcrumb",
      tags$button(class="fr-breadcrumb__button", "Voir le fil d’Ariane"),
      tags$div(class="fr-collapse", id="breadcrumb-1",
        tags$ol(class="fr-breadcrumb__list",
          tags$li(tags$a(class="fr-breadcrumb__link", href="/", "Accueil")),
          tags$li(tags$a(class="fr-breadcrumb__link", "Données personnelles"))
        )                
      )
    ),            
    tags$div(class="fr-grid-row fr-grid-row--center fr-grid-row--gutters  fr-mb-3v",                                   
      tags$div(class="fr-col-12 fr-col-md-12 fr-col-lg-8",
        tags$div(class="fr-grid-row fr-grid-row--gutters",
          tags$h1(class="nonaccueil", "Données personnelles"),
          tags$div(class="content hentry", id="content",
            tags$p("Les informations personnelles collectées sur le site internet ", tags$a(href=urlpage, class="spip_url spip_out auto", rel="nofollow external", urlpage), " résultent d’une communication volontaire de l’utilisateur lors de l’utilisation du formulaire présent sur le site."),
            tags$p("Ces informations sont nécessaires pour la gestion des services proposés, elles sont destinées exclusivement au service du Commissariat général du développement durable. Ces informations ne seront pas communiquées à un tiers."),
            tags$p("Conformément à la loi « informatique et libertés » du 6 janvier 1978 modifiée en 2004, vous bénéficiez d’un droit d’accès et de rectification aux informations qui vous concernent, que vous pouvez exercer en vous adressant à :"),
            tags$p(tags$strong("Ministère de la Transition écologique"), tags$br(class="autobr"), 
                                "CGDD/DDD",tags$br(class="autobr"),
                                "Tour Séquoia",tags$br(class="autobr"),
                                "92055 La Défense Cedex"),
            tags$p("Vous pouvez également, pour des motifs légitimes, vous opposer au traitement des données vous concernant.")
          ),
          if (autoriserPRS == "oui"){
            tags$div(class="fr-col-12 partager",
              tags$div(class="fr-share fr-my-6v",
                tags$p(class="fr-share__title", "Partager la page"),
                tags$ul(class="fr-share__group",
                  tags$li(tags$a(class="fr-share__link fr-share__link--facebook", title="Partager sur Facebook - ouvre une nouvelle fenêtre", href="https://www.facebook.com/sharer.php?u=https%3A%2F%2Fpublications.recette.cloud%2Farticle%2Faccessibilite", target="_blank", rel="noopener", onclick="window.open(this.href,'Partager sur Facebook','toolbar=no,location=yes,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=450'); event.preventDefault();", "Partager sur Facebook")),
                  tags$li(tags$a(class="fr-share__link fr-share__link--twitter", title="Partager sur Twitter - ouvre une nouvelle fenêtre", href="https://twitter.com/intent/tweet?url=https%3A%2F%2Fpublications.recette.cloud%2Farticle%2Faccessibilite&amp;text=Accessibilité - Publicité responsable", target="_blank", rel="noopener", onclick="window.open(this.href,'Partager sur Twitter','toolbar=no,location=yes,status=no,menubar=no,scrollbars=yes,resizable=yes,width=600,height=420'); event.preventDefault();", "Partager sur Twitter")),
                  tags$li(tags$a(class="fr-share__link fr-share__link--linkedin", title="Partager sur LinkedIn - ouvre une nouvelle fenêtre", href="https://www.linkedin.com/shareArticle?url=https%3A%2F%2Fpublications.recette.cloud%2Farticle%2Faccessibilite&amp;title=Accessibilité - Publicité responsable", target="_blank", rel="noopener", onclick="window.open(this.href,'Partager sur LinkedIn','toolbar=no,location=yes,status=no,menubar=no,scrollbars=yes,resizable=yes,width=550,height=550'); event.preventDefault();", "Partager sur LinkedIn")),
                  tags$li(tags$a(class="fr-share__link fr-share__link--mail", href="mailto:?subject=Accessibilité - Publicité responsable&amp;body= https%3A%2F%2Fpublications.recette.cloud%2Farticle%2Faccessibilite", title="Partager par email", target="_blank", "Partager par email")),
                  tags$li(tags$button(class="fr-share__link fr-share__link--copy", title="Copier dans le presse-papier", onclick="navigator.clipboard.writeText(window.location);alert('Adresse copiée dans le presse papier.');", "Copier dans le presse-papier"))
                )
              )                                                                                                 
            )
          }
        )
      )
    )
    
  )
)