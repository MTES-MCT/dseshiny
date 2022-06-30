output$pageStub <- renderUI(
  tags$div(class="fr-container", id="container",
           tags$nav(role="navigation", class="fr-breadcrumb",
                    tags$button(class="fr-breadcrumb__button", "Voir le fil d’Ariane"),
                    tags$div(class="fr-collapse", id="breadcrumb-1",
                             tags$ol(class="fr-breadcrumb__list",
                                     tags$li(tags$a(class="fr-breadcrumb__link", href="/", "Accueil")),
                                     tags$li(tags$a(class="fr-breadcrumb__link", "Mentions légales"))
                             )                
                    )
           ),
           tags$div(class="fr-grid-row fr-grid-row--center fr-grid-row--gutters  fr-mb-3v",
                    tags$div(class="fr-col-12 fr-col-md-12 fr-col-lg-8",
                             
                             tags$div(class="fr-grid-row fr-grid-row--gutters",
                                      tags$h1(class="nonaccueil", "Mentions légales"),
                                      tags$div(class="content hentry", id="content",
                                               tags$h2(id="Editeur", "Editeur"),
                                               tags$p("Le site internet ", tags$a(href=urlpage, urlpage), " et ses contenus sont sous la responsabilité éditoriale du :", tags$br(class="manualbr"), tags$strong(editeur)),
                                               tags$p("N°SIRET : 13000572100019"),
                                               tags$h2(id="Directeur-de-publication", "Directeur de publication"),
                                               tags$p("Au sens de l’article 93-2 de la loi n°82-652 du 29 juillet 1982.", tags$br(class="autobr"),
                                                      tags$strong(directeurPublication)
                                               ),
                                               tags$h2(id="Hebergement", "Hébergement"),
                                               tags$p(hebergement),
                                               tags$h2(id="Conception-et-developpement", "Conception et développement"),
                                               tags$p("Coordination du baromètre : Eric Pautard (CGDD/SDES/SDIE)",tags$br(class="autobr"),
                                                      "Réalisation de l'outil de datavisualisation : Rodolphe Leveau (Université d'Orléans)", tags$br(class="autobr"),
                                                      tags$br(class="autobr"),
                                                      "Ministère de la Transition écologique et de la cohésion des territoires", tags$br(class="autobr"),
                                                      "Commissariat général au développement durable", tags$br(class="autobr"),
                                                      "Service des données et études statistiques", tags$br(class="autobr"),
                                                      "Bureau des synthèses économiques et sociales sur l'environnement"),
                                               tags$h2(id="Liens-hypertextes-responsabilite", "Liens hypertextes (responsabilité)"),
                                               tags$p("ssm-ecologie.shinyapps.io/barometre_environnement propose de nombreux liens vers d’autres sites publics (gouvernement, institutions, organismes publics, opérateurs….) et systématiquement identifiés. Cependant, ces pages web dont les adresses sont régulièrement vérifiées ne font pas partie du site ssm-ecologie.shinyapps.io/barometre_environnement : elles n’engagent pas la responsabilité du CGDD."),
                                               tags$h2(id="Propriete-intellectuelle", "Propriété intellectuelle"),
                                               tags$p("Tout site public ou privé est autorisé à établir, sans autorisation préalable, un lien vers les informations diffusées sur service-public.fr. En revanche, les pages du portail ne doivent pas être imbriquées à l’intérieur des pages d’un autre site."),
                                               tags$p("Le logo et les objets iconographiques du site ssm-ecologie.shinyapps.io/barometre_environnement et la marque ssm-ecologie.shinyapps.io/barometre_environnement sont la propriété exclusive du Commissariat général au développement durable (CGDD) à l’exception des ", tags$a(href="https://storyset.com/people", class="spip_out", rel="external", "Illustrations fournies par Storyset", ".")),
                                               tags$p("Les logos peuvent être utilisés par nos partenaires dans leur support de communication pour référencer les contenus ou liens vers le site ssm-ecologie.shinyapps.io/barometre_environnement, à condition que “ssm-ecologie.shinyapps.io/barometre_environnement” soit cité."),
                                               tags$p("L’ensemble des contenus sont réutilisables sous conditions de licence libre sans autorisation ni mention spécifique particulière outre celles définies dans le cadre de la licence ouverte. Les contenus du site peuvent être librement réutilisés, sous réserve de mentionner : la source (ssm-ecologie.shinyapps.io/barometre_environnement), la date de création ou mise à jour du contenu. Les contenus relèvent de ", tags$a(href="https://www.etalab.gouv.fr/licence-ouverte-open-licence/", class="spip_out", rel="external", "la Licence ouverte"), "."),
                                               tags$dl(class="spip_document_17 spip_documents insert",
                                                       tags$dt(tags$a(href="https://www.etalab.gouv.fr/wp-content/uploads/2017/04/ETALAB-Licence-Ouverte-v2.0.pdf", title="PDF - 232.1 ko", type="application/pdf",
                                                                      tags$img(src="local/cache-vignettes/L52xH52/pdf-39070.png?1655146967", width="52",height="52", alt="")
                                                       )),
                                                       tags$dt(tags$strong("Licence Ouverte au format PDF"))
                                               )
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

