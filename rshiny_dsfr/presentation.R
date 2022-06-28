source("user/ui.R",encoding = "UTF-8",local=T)
output$pageStub <- renderUI(

tags$div(class="fr-container", id="container",
         tags$nav(role="navigation", class="fr-breadcrumb", 
                  tags$button(class="fr-breadcrumb__button",  "Voir le fil d’Ariane"),
                  tags$div(class="fr-collapse", id="breadcrumb-1",
                           tags$ol(class="fr-breadcrumb__list",
                                   tags$li(tags$a(class="fr-breadcrumb__link", href="?home", "Accueil")),
                                   tags$li(tags$a(class="fr-breadcrumb__link", "Présentation"))
                           )
                  )
         ),
         tags$div(class="fr-grid-row fr-grid-row--center fr-grid-row--gutters  fr-mb-3v",
                  tags$div(class="fr-col-12 fr-col-md-12 fr-col-lg-8",
                           tags$div(class="fr-grid-row fr-grid-row--gutters",
                                    ## Titre
                                    tags$h2("Présentation de l'outil de datavisualisation"),
                                    tags$div(class="content hentry", id="content",						
                                             tags$div(class="crayon article-texte-43 texte surlignable clearfix crayon-init crayon-autorise",
                                                      
                                                      #### Texte de la presentation ####
                                                      
                                                      tags$p("Les données présentées dans cet outil de visualisation sont issues de la", tags$b("'Plateforme Environnement'"),".
Ce dispositif de suivi barométrique a été initié en 2008 par le service statistique ministériel en charge des questions environnementales (",tags$a(class="sommaire-back sommaire-back-1", href='https://www.statistiques.developpement-durable.gouv.fr/', "SDES"),").
Adossée à l’enquête mensuelle de conjoncture auprès des ménages de l’Insee ( dispositif ",tags$a(class="sommaire-back sommaire-back-1", href='https://www.insee.fr/fr/metadonnees/source/serie/s1208/', "Camme"),"), cette plateforme comprend une série de ",tags$b("20 questions")," posées chaque année (au mois de novembre) à un échantillon de 1 800 individus environ représentatif de la population résidant en France métropolitaine âgée de 18 ans et plus.
Les questions visent à suivre l’évolution des préoccupations et des pratiques environnementales dans la société française."),
                                                      tags$p("Cette datavisualisation permet de prendre connaissance des résultats en s'intéressant à la série complète (",tags$b("évolutions depuis 2009"),") ou à la dernière année en cours.
La consultation des questions se fait par thématique. Il est ensuite possible d'observer plus spécifiquement l'influence de certaines variables socio-économiques sur les réponses."),
                                                      tags$br(),
                                                      tags$h3(id="Etat-de-conformite", "Mode d'emploi"),
                                                      tags$p("Les données présentées dans cet outil de visualisation peuvent être consultées de manière détaillée, en sélectionnant une catégorie dans le menu déroulant « Variables » :"),
                                                      tags$p(tags$b("Âge"), "du répondant : Moins de", age1, "ans / Entre ",age1," et ",age2," ans / Plus de ",age2," ans"),
                                                      tags$p(tags$b("Type d’agglomération"), "où réside le ménage : Milieu rural / Unité Urbaine de moins de 100 000 habitants / Unité Urbaine de plus de 100 000 habitants / Agglomération de Paris "),
                                                      tags$p(tags$b("Niveau d’étude"),"du répondant : Primaire ou moins / Brevet ou équivalent / Bac ou équivalent / Supérieur"),
                                                      tags$p(tags$b("Niveau de vie"), "mensuel du ménage (par unité de consommation ", tags$a(href='https://www.insee.fr/fr/metadonnees/definition/c1890',"définition"),") : Premier quintile (moins de ",as.character(as.integer(Quintiles[2]))," €) / Deuxième quintile (de ",as.character(as.integer(Quintiles[2]))," à ",as.character(as.integer(Quintiles[3]))," €) / Troisième quintile (de ",as.character(as.integer(Quintiles[3]))," à ",as.character(as.integer(Quintiles[4]))," €) / Quatrième quintile (de ",as.character(as.integer(Quintiles[4]))," à ",as.character(as.integer(Quintiles[5]))," €) / Cinquième quintile (plus de ",as.character(as.integer(Quintiles[5]))," €)"),
                                                      tags$p(tags$b("Catégorie socio-professionnelle"), "de la personne de référence du ménage : Agriculteurs / Artisans, commerçants, chefs d'entreprise / Cadres supérieurs, professions libérales / Professions intermédiaires / Employés / Ouvriers"),
                                                      tags$br(),
                                                      tags$p("Outre la consultation des résultats, cet outil permet aussi de ",tags$b("télécharger")," des contenus :"),
                                                      tags$p("- Versions", tags$b("Image"), " des graphiques : icône en haut à droite (format .png)"),
                                                      tags$p("- ", tags$b("Tableaux"), " de données : onglet « Tableaux » > bouton « Télécharger » en haut à gauche (formats .xslx ou.pdf)"),
                                                      tags$br(),
                                                      tags$h3(id="Etat-de-conformite", "Avertissement"),
                                                      tags$p("Par nature, les pratiques recueillies dans le cadre de cette enquête sont des ",tags$b("pratiques déclarées"),".
Elles sont donc susceptibles d’être surévalués par rapport aux pratiques effectives des ménages, compte-tenu du mécanisme dit de ",tags$i("désirabilité sociale")," fréquemment observé dans les enquêtes d’opinions centrées sur des sujets comme l’environnement pour lesquels il existe souvent une adhésion consensuelle.
L’individu interrogé tend ainsi à répondre en adéquation avec ce qu’il juge être une valeur ou une attitude socialement valorisée. Pour cette raison, plus que les niveaux, ce sont les évolutions des réponses au fil du temps ou les disparités entre catégories qui sont les plus riches d’enseignements."),
                                                      tags$p("Des modifications ayant été apportées au questionnaire en 2012 et en 2020 pour améliorer les connaissances sur ces sujets, la profondeur temporelle des analyses varie selon les items.
Les anciennes questions sont présentées dans la partie 'Archives' du menu déroulant 'Choix du thème'.")
                                             )
                                    )
                           )
                  )
         )
)

)

# 
# tags$div(#Texte de la présentation 
# h3("Bienvenue sur le site de visualisation des données sur l'opinions et pratiques environnementales des Français"),br(),
# column(6, 
#        h4("Titre"),
#        div(HTML("Les données présentées dans cet outil de visualisation sont issues de la <b>'Plateforme Environnement'</b>.
# Ce dispositif de suivi barométrique a été initié en 2008 par le service statistique ministériel en charge des questions environnementales (<a href='https://www.statistiques.developpement-durable.gouv.fr/'>SDES</a>).
# Adossée à l’enquête mensuelle de conjoncture auprès des ménages de l’Insee (dispositif <a href='https://www.insee.fr/fr/metadonnees/source/serie/s1208/'>Camme</a>), cette plateforme comprend une série de <b>20 questions</b> posées chaque année (au mois de novembre) à un échantillon de 1 800 individus environ représentatif de la population résidant en France métropolitaine âgée de 18 ans et plus.
# Les questions visent à suivre l’évolution des préoccupations et des pratiques environnementales dans la société française."),br(),br(),
#            HTML("Cette datavisualisation permet de prendre connaissance des résultats en s'intéressant à la série complète (<b>évolutions depuis 2009</b>) ou à la dernière année en cours.
# La consultation des questions se fait par thématique. Il est ensuite possible d'observer plus spécifiquement l'influence de certaines variables socio-économiques sur les réponses."),br(),br(),
#            HTML("Par nature, les pratiques recueillies dans le cadre de cette enquête sont des <b>pratiques déclarées</b>.
# Elles sont donc susceptibles d’être surévalués par rapport aux pratiques effectives des ménages, compte-tenu du mécanisme dit de <i>désirabilité sociale</i> fréquemment observé dans les enquêtes d’opinions centrées sur des sujets comme l’environnement pour lesquels il existe souvent une adhésion consensuelle.
# L’individu interrogé tend ainsi à répondre en adéquation avec ce qu’il juge être une valeur ou une attitude socialement valorisée. Pour cette raison, plus que les niveaux, ce sont les évolutions des réponses au fil du temps ou les disparités entre catégories qui sont les plus riches d’enseignements."),br(),br(),
#            HTML("
# Des modifications ayant été apportées au questionnaire en 2012 et en 2020 pour améliorer les connaissances sur ces sujets, la profondeur temporelle des analyses varie selon les items.
# Les anciennes questions sont présentées dans la partie 'Archives' du menu déroulant 'Choix du thème'."), style = "text-justify")
#        
#        
#        
# ),
# column(5,
#        h4("Titre"),
#        div(HTML("Les données présentées dans cet outil de visualisation peuvent être consultées de manière détaillée, en sélectionnant une catégorie dans le menu déroulant « Variables » :"),br(),br(),
#            HTML("<b>Genre</b> du répondant : Femme / Homme"),br(),br(),
#            HTML(paste("<b>Âge</b> du répondant : Moins de", age1, "ans / Entre ",age1," et ",age2," ans / Plus de ",age2," ans")),br(),br(),
#            HTML("<b>Type d’agglomération </b> où réside le ménage : Milieu rural / Unité Urbaine de moins de 100 000 habitants / Unité Urbaine de plus de 100 000 habitants / Agglomération de Paris "),br(),br(),
#            HTML("<b>Niveau d’étude</b> du répondant : Primaire ou moins / Brevet ou équivalent / Bac ou équivalent / Supérieur"),br(),br(),
#            HTML(paste("<b>Niveau de vie</b> du ménage (par unité de consommation : <a href='https://www.insee.fr/fr/metadonnees/definition/c1890'>définition</a>) : Premier quintile (moins de ",as.character(as.integer(Quintiles[2]))," €) / Deuxième quintile (de ",as.character(as.integer(Quintiles[2]))," à ",as.character(as.integer(Quintiles[3]))," €) / Troisième quintile (de ",as.character(as.integer(Quintiles[3]))," à ",as.character(as.integer(Quintiles[4]))," €) / Quatrième quintile (de ",as.character(as.integer(Quintiles[4]))," à ",as.character(as.integer(Quintiles[5]))," €) / Cinquième quintile (plus de ",as.character(as.integer(Quintiles[5]))," €)")),br(),br(),
#            HTML("<b>Catégorie socio-professionnelle</b> de la personne de référence du ménage : Agriculteurs / Artisans, commerçants, chefs d'entreprise / Cadres supérieurs, professions libérales / Professions intermédiaires / Employés / Ouvriers"),br(),br(),
#            br(),
#            HTML("Outre la consultation des résultats, cet outil permet aussi de télécharger des contenus :"),br(),br(),
#            HTML("- Versions <b>Image</b> des graphiques : icône en haut à droite (format .png)"),br(),br(),
#            HTML("- <b>Tableaux</b> de données : onglet « Tableaux » > bouton « Télécharger » en haut à gauche (formats .xslx ou.pdf)"),br(),br()
#            , style = "text-align: justify;")),
# column(1, "")
# )
# )
# )
