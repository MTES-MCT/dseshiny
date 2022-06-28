#################################################################################
#########                                                               #########
#########          NE PAS MODIFIER LE CODE DE CETTE PAGE                #########
#########                                                               #########
#################################################################################
#########                                                               #########
#########               Les fichiers utilisateurs sont :                #########
#########                                                               #########
#########                    server-utilisateur.R                       #########
#########                      ui-utilisateur.R                         #########
#########                                                               #########
#########        Merci de n'utiliser que les fichiers ci-nommés         #########
#########                                                               #########
#################################################################################

# Configuration des variables du DSFR et des composants à afficher
source("user/variables_dsfr.R",encoding = "UTF-8",local=T)
footer <- tags$html(
  if (afficherHP == "oui"){
    tags$div(class="scroll-top", 
      tags$a(class="fr-btn fr-fi-arrow-up-line scroll-top__link", href="#SELF#top", id="topbtn", "Haut de page"),
    )
  },
  tags$footer(class="fr-footer",role="contentinfo",id="footer",
    tags$div(class="fr-container",
      tags$div(class="fr-footer__body",
        tags$div(class="fr-footer__brand fr-enlarge-link",
          tags$p(class='fr-logo', organismeSite),
          
            tags$a(class="fr-footer__brand-link", href="/", title=titreonglet,
              if (afficherSL == "oui"){tags$img(class="fr-footer__logo fr-responsive-img", style="max-width:12.5rem", src=SL, alt=altSL, width="120", height="120")
            }
          )
          
        ),

        tags$div(class="fr-footer__content",
          if (afficherFD == "oui"){
            tags$p(class="fr-footer__content-desc", footerDesc)
          },
          tags$ul(class="fr-footer__content-list",
            tags$li(class="fr-footer__content-item",
              tags$a(class="fr-footer__content-link", href="https://data.gouv.fr","data.gouv.fr")
            ),
            tags$li(class="fr-footer__content-item",
              tags$a(class="fr-footer__content-link", href="https://service-public.fr", "service-public.fr")
            ),
            tags$li(class="fr-footer__content-item",
              tags$a(class="fr-footer__content-link", href="https://gouvernement.fr", "gouvernement.fr")
            ),
            tags$li(class="fr-footer__content-item",
              tags$a(class="fr-footer__content-link", href="https://legifrance.gouv.fr", "legifrance.gouv.fr")
            )
          )
        )
      ),
      if (afficherBP == "oui"){
        tags$div(class="fr-footer__partners",
          tags$h4(class="fr-footer__partners-title", titreBloc),
          tags$div(class="fr-footer__partners-logos",
            tags$div(class="fr-footer__partners-main",
              if (afficherPP1 == "oui"){
                tags$a(class="footer__partners-link", href="https://localhost/",
                  tags$img(class="fr-footer__logo", src=urlImgP1, alt=altP1, width="120", height="120")
                )
              }
            ),
            tags$div(class="fr-footer__partners-main",
              if (afficherPP2 == "oui"){
                tags$a(class="footer__partners-link", href="https://localhost/",
                   tags$img(class="fr-footer__logo", src=urlImgP2, alt=altP2, width="120", height="120")
                )
              }
            ),
            tags$div(class="fr-footer__partners-sub",
              tags$ul(
                if (afficherPS1 == "oui"){
                  tags$li(
                    tags$a(class="fr-footer__partners-link", href="#",
                      tags$img(class="fr-footer__logo", src=urlImgPS1, alt=altPS1, width="120", height="120")
                    )
                  )
                },
                if (afficherPS2 == "oui"){
                  tags$li(
                    tags$a(class="fr-footer__partners-link", href="#",
                      tags$img(class="fr-footer__logo", src=urlImgPS2, alt=altPS2, width="120", height="120")
                    )
                  )
                },
                if (afficherPS3 == "oui"){
                  tags$li(
                    tags$a(class="fr-footer__partners-link", href="#",
                      tags$img(class="fr-footer__logo", src=urlImgPS3, alt=altPS3, width="120", height="120")
                    )
                  )
                }

              )
            )
          )
        )
      },
      tags$div(class="fr-footer__bottom",
        tags$ul(class="fr-footer__bottom-list",
          tags$li(class="fr-footer__bottom-item",
            tags$a(class="fr-footer__bottom-link", href="?accessibilite", titreLienAccessibilite)
          ),
          tags$li(class="fr-footer__bottom-item",
            tags$a(class="fr-footer__bottom-link", href="?mentionslegales", "Mentions légales")
          ),
          tags$li(class="fr-footer__bottom-item",
            tags$a(class="fr-footer__bottom-link", href="?donneespersonnelles", "Données personnelles")
          ),
          if (afficherCookies == "oui"){
            tags$li(class="fr-footer__bottom-item",
              tags$a(class="fr-footer__bottom-link", href=baliseCookies, "Gestion des cookies")
            )
          },
          tags$li(class="fr-footer__bottom-item",
            tags$button(class="fr-btn--display fr-footer__bottom-link", title="Paramètres d'affichage", "Paramètres d'affichage")
          )
        ),
        tags$div(class="fr-footer__bottom-copy",
          tags$p("Sauf mention contraire, tous les contenus de ce site sont sous ", tags$a(href="https://github.com/etalab/licence-ouverte/blob/master/LO.md", target="_blank", "licence etalab-2.0"))
        )
      )
    )
  )
)

