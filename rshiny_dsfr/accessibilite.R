# Configuration des variables du DSFR et des composants à afficher
source("user/variables_dsfr.R",encoding = "UTF-8",local=T)

output$pageStub <- renderUI(
  tags$div(class="fr-container", id="container",
    tags$nav(role="navigation", class="fr-breadcrumb", 
      tags$button(class="fr-breadcrumb__button",  "Voir le fil d’Ariane"),
      tags$div(class="fr-collapse", id="breadcrumb-1",
        tags$ol(class="fr-breadcrumb__list",
          tags$li(tags$a(class="fr-breadcrumb__link", href="/", "Accueil")),
          tags$li(tags$a(class="fr-breadcrumb__link", "Accessibilité"))
        )
      )
    ),
		tags$div(class="fr-grid-row fr-grid-row--center fr-grid-row--gutters  fr-mb-3v",
		  tags$div(class="fr-col-12 fr-col-md-12 fr-col-lg-8",
        tags$div(class="fr-grid-row fr-grid-row--gutters",
			  tags$h1(class="nonaccueil", "Accessibilité"),
          tags$div(class="content hentry", id="content",						
    				tags$div(class="crayon article-texte-43 texte surlignable clearfix crayon-init crayon-autorise",
              tags$p(texteAccessibilite),
              tags$p("Cette déclaration d’accessibilité s’applique au site web ", tags$a(href=urlpage, class="spip_url spip_out auto", rel="nofollow external", urlpage)),
              tags$h2(id="Etat-de-conformite", "État de conformité", tags$a(class="sommaire-back sommaire-back-1", href="#", title="Retour au sommaire")),
              tags$p("Le site ", tags$a(href=urlpage, class="spip_url spip_out auto", rel="nofollow external", urlpage), conformiteAffichee," avec le référentiel général d’amélioration de l’accessibilité.", tags$br(class="autobr"), "Un audit est en cours de réalisation.")
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
)
