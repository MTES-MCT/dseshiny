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

header <- tags$html(
  #### TAGS HEADER ##
  tags$head(
    #### NE PAS MODIFIER DE CE TAGS ####
    tags$title(titreonglet),
    tags$meta(charset=charset),
    tags$link(rel="canonical", href=urlpage),
    tags$meta(name="description", content=description),
    tags$meta(name="viewport",content="width=device-width, initial-scale=1, shrink-to-fit=no"),
    tags$meta(name="geo.region", content="fr-FR"),

    # Balises Opengraph
    if (afficherRS == "oui"){ tags$meta(property="og:type", content=ogtype)},
    if (afficherRS == "oui"){ tags$meta(property="og:locale", content="fr_FR")},
    if (afficherRS == "oui"){ tags$meta(property="og:site_name", content=ogsitename)},
    if (afficherRS == "oui"){ tags$meta(property="og:title", content=ogtitle)},
    if (afficherRS == "oui"){ tags$meta(property="og:url", content=ogurl)},
    if (afficherRS == "oui"){ tags$meta(property="og:image",content=ogimage)},
    if (afficherRS == "oui"){ tags$meta(property="og:description",content=ogdescription)},
    # Balises Twittergraph
    if (afficherRS == "oui"){ tags$meta(name="twitter:card", content=twittercard)},
    if (afficherRS == "oui"){ tags$meta(name="twitter:site", content=twitternomsite)},
    if (afficherRS == "oui"){ tags$meta(name="twitter:url", content=twitterurl)},
    if (afficherRS == "oui"){ tags$meta(name="twitter:title", content=twittertitle)},
    if (afficherRS == "oui"){ tags$meta(property="twitter:image", content=twitterimage)},
    if (afficherRS == "oui"){ tags$meta(name="twitter:description", content=twitterdescription)},
    # Balisage DublinCore
    if (afficherRS == "oui"){ tags$meta(name="DC.title", lang="fr", content=dctitle)},
    if (afficherRS == "oui"){ tags$meta(name="DC.description", lang="fr", content=dcdescription)},
    if (afficherRS == "oui"){ tags$meta(name="DC.Creator", content=dccreator, lang="fr-FR")},
    if (afficherRS == "oui"){ tags$meta(name="DC.identifier", scheme="URI", content=dcidentifier)},
    if (afficherRS == "oui"){ tags$meta(name="DC.Language", scheme="RFC3066", content="fr-FR")},
    #REM Style DSFR
    tags$link(rel="stylesheet", href="dsfr/dsfr.min.css", type = "text/css"),
    
    tags$link(rel="preload", href="dsfr/dsfr-theme-tac.css", as="style", onload="this.onload=null;this.rel=\'stylesheet\'"),
    tags$noscript(tags$link(rel="stylesheet", href="dsfr/dsfr-theme-tac.css", type="text/css")),
    
      
    tags$link(rel="stylesheet", href="dsfr/plugin-dse.css", type="text/css"),
    tags$link(rel="stylesheet", href="dsfr/custom.css", type="text/css"),
    tags$link(rel="stylesheet", href="dsfr/utility/icons/icons.css", type="text/css"),
    # Favicon
    tags$link(rel="apple-touch-icon", href="dsfr/favicon/apple-touch-icon.png"),
    tags$link(rel="icon", href="dsfr/favicon/favicon.svg"),
    tags$link(rel="shortcut icon", href="dsfr/favicon/favicon.ico"),
    tags$link(rel="manifest", href="dsfr/favicon/manifest.webmanifest", crossorigin="use-credentials"),
    # Scripts
  ),
  tags$body(class="front path-frontpage page-node-type-page",
    tags$div(class='fr-skiplinks', id='top',
      tags$nav(class='fr-container', role='navigation',
        tags$ul(class='fr-skiplinks__list',
          tags$li(class='fr-link',
            tags$a(href='#contenu', 'Contenu')
          ),
          tags$li( class='fr-link',
            tags$a(href='#footer', 'Pied de page')
          )
        )
      )
    ),
    tags$header(role='banner', class='fr-header',
      tags$div(class='fr-header__body',
        tags$div(class='fr-container',
          tags$div(class='fr-header__body-row',
            tags$div(class='fr-header__brand fr-enlarge-link',
              #  Logo Marianne du site, ne pas modifier
              tags$div(class='fr-header__brand-top',
                tags$div(class='fr-header__logo',
                  tags$div(class='fr-header__brand-top',
                    tags$div(class='fr-header__logo',
                            # Texte de votre organisme (République Française, Ministère de la Transition écologique ...)
                            tags$p(class='fr-logo', tags$html(organismeSite))
                    ),
                    if (afficherSL=="oui"){
                      tags$a(class="fr-header__operator", href="/", title=titreonglet,
                        tags$img(class="fr-responsive-img", src=SL, alt="Second logo", width="120", height="120")
                      )
                    },
                    tags$div(class='fr-header__navbar',
                      HTML('<button class="fr-btn--search fr-btn" data-fr-opened="false" aria-controls="modal-400" id="button-401" title="Rechercher" data-fr-js-modal-button="true">Rechercher</button><button class="fr-btn--menu fr-btn" data-fr-opened="false" aria-controls="modal-402" aria-haspopup="menu" id="button-403" title="Menu" data-fr-js-modal-button="true">Menu</button>')
                    )
                  )
                )
              ),

              if (afficherTitre == "oui"){
                tags$div(class='fr-header__service',
                  #Titre du site
                  tags$a(href='/', title=titreonglet,
                        tags$h1(class='fr-header__service-title', titresite)
                  ),
                  # Votre slogan ci-dessous, mettre u # devant la ligne pour ne plus afficher le slogan
                  if (afficherSlogan=="oui"){
                    tags$p(class="fr-header__service-tagline", slogan)
                  }
                )
              }
            ),
            tags$div(class="fr-header__tools",
              tags$div(class="fr-header__tools-links",
                tags$ul(class="fr-links-group",
                  # Liste de liens d'accès header
                  if (afficherLL1 == "oui"){
                    tags$li(
                      tags$a(class=icon1lien, href=url1lien, titre1lien)
                    )
                  },
                  if (afficherLL2 == "oui"){
                    tags$li(
                      tags$a(class=icon2lien, href=url2lien, titre2lien)
                    )
                  },
                  if (afficherLL3 == "oui"){
                    tags$li(
                      tags$a(class=icon3lien, href=url3lien, titre3lien)
                    )
                  },
                  if (afficherLL3 == "non"){
                    tags$li(
                      # <button class="fr-btn--display fr-btn" aria-controls="fr-theme-modal" data-fr-opened="false" title="Paramètres d'affichage">Paramètres d'affichage</button>
                      tags$button(class="fr-btn--display fr-btn", title="Paramètres d'affichage", `aria-describedby`="fr-theme-modal", `data-fr-opened`="false", "Paramètres d'affichage")
                    )
                  }
                )
              ),
              if (afficherSearchbox == "oui"){
                tags$div(class="fr-header__search fr-modal", id="modal-400",
                  tags$div(class="fr-container fr-container-lg--fluid",
                    tags$button(id="fermer", class="fr-link--close fr-link", "Fermer"),
                    tags$form(action=urlSearchpage, method="get",
                      tags$div(class="fr-search-bar", id="search-399", role="search",
                        tags$label(id="btn_rechercher", class="fr-label", "Rechercher"),
                        tags$input(type="hidden", name="page", value="recherche"),
                        tags$input(class="fr-input", placeholder="Rechercher", type="search", id="search-399-input", name="recherche", value=""),
                        tags$button(class="fr-btn", title="Rechercher","Rechercher")
                      )
                    )
                  )
                )
              }
            )
          ),
          if (afficherMenu == "oui"){
            includeHTML("user/menu.Rhtml")
            #source("user/menu.R",encoding = "UTF-8",local=T)
          }
        )
      )
    )
  )
)
