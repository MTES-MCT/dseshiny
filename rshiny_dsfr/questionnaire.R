source("user/ui.R",encoding = "UTF-8",local=T)

output$pageStub <- renderUI(
  tags$div(class="fr-container", id="container",
           tags$nav(role="navigation", class="fr-breadcrumb", 
                    tags$button(class="fr-breadcrumb__button",  "Voir le fil d’Ariane"),
                    tags$div(class="fr-collapse", id="breadcrumb-1",
                             tags$ol(class="fr-breadcrumb__list",
                                     tags$li(tags$a(class="fr-breadcrumb__link", href="?home", "Accueil")),
                                     tags$li(tags$a(class="fr-breadcrumb__link", "Questionnaire"))
                             )
                    )
           ),
           tags$div(class="fr-grid-row fr-grid-row--center fr-grid-row--gutters  fr-mb-3v",
                    tags$div(class="fr-col-12 fr-col-md-12 fr-col-lg-8",
                             tags$div(class="fr-grid-row fr-grid-row--gutters",
                                      ## Titre
                                      tags$h2(class="nonaccueil", "Questionnaire"),
                                      tags$div(class="content hentry", id="content",						
                                               tags$div(class="crayon article-texte-43 texte surlignable clearfix crayon-init crayon-autorise",
                                                        tags$h3("Préoccupations environnementales"),
                                                        tags$h4("Parmi les problèmes suivants liés à la dégradation de l’environnement, quels sont les deux qui vous paraissent les plus préoccupants ?"),
                                                        tags$p("1 - La gêne occasionnée par le bruit", tags$br(),
                                                                "2 - La pollution de l’air ", tags$br(),
                                                                "3 - La pollution de l’eau, des rivières et des lacs ", tags$br(),
                                                                "4 - Le réchauffement de la planète (et l’effet de serre) ", tags$br(),
                                                                "5 - La disparition de certaines espèces végétales ou animales ", tags$br(),
                                                                "6 - Les catastrophes naturelles (inondations, tempêtes, séismes, feux de forêts…)", tags$br(),
                                                                "7 - L’augmentation des déchets des ménages", tags$br(),
                                                                "8 - Aucun"),
                                                        tags$br(),
                                                        tags$h4("Parmi les problèmes suivants, quels sont les deux qui concernent votre quartier (là où vous habitez) ?"),
                                                        tags$p("1 - Le bruit", tags$br(),
                                                                "2 - La pollution de l’air", tags$br(),
                                                                "3 - Le manque de transports en commun", tags$br(),
                                                                "4 - L’environnement dégradé (mal entretenu, manque de propreté)", tags$br(),
                                                                "5 - Les risques liés à la présence d’installations dangereuses (industrielles, nucléaires)", tags$br(),
                                                                "6 - Les risques naturels (inondations, tempêtes, séismes, feux de forêts)", tags$br(),
                                                                "7 - Aucun "),
                                                        tags$br(),
                                                        tags$h3("Logement et énergie"),
                                                        tags$h4("A votre domicile, vous arrive-t-il de couper le mode veille des appareils électroniques ?"),
                                                        tags$p("1 - Jamais", tags$br(),
                                                               "2 - Occasionnellement", tags$br(),
                                                               "3 - Souvent ", tags$br(),
                                                               "4 - Toujours" ),
                                                        tags$br(),
                                                        tags$h4("A votre domicile, vous arrive t’il de baisser le chauffage ou la climatisation afin de limiter votre consommation d’énergie ?"),
                                                        tags$p("1 - Jamais", tags$br(),
                                                               "2 - Occasionnellement", tags$br(),
                                                               "3 - Souvent ", tags$br(),
                                                               "4 - Toujours" ),
                                                        tags$br(),
                                                        tags$h3("Transport"),
                                                        tags$h4("Parmi les moyens de transport suivants, lequel utilisez-vous habituellement pour vous rendre sur votre lieu de travail ou d'études ?"),
                                                        tags$p("1 - Une voiture ou un véhicule utilitaire exclusivement", tags$br(),
                                                               "2 - Une moto, un scooter ou un autre deux-roues motorisé exclusivement", tags$br(),
                                                               "3 - Un véhicule personnel (voiture ou deux roues) et un ou plusieurs transports en commun", tags$br(),
                                                               "4 - Un vélo et un ou plusieurs transports en commun", tags$br(),
                                                               "5 - Un ou plusieurs transports en commun exclusivement ", tags$br(),
                                                               "6 - Un vélo exclusivement", tags$br(),
                                                               "7 - La marche à pied", tags$br(),
                                                               "8 - C’est trop variable pour répondre" ),
                                                        tags$br(),
                                                        tags$h4("Là où vous habitez, pensez-vous qu’à l’avenir il sera de plus en plus facile pour vous d’effectuer vos déplacements quotidiens (travail, études, loisir, courses) sans voiture ?"),
                                                        tags$p("1 - Oui", tags$br(),
                                                               "2 - Non" ),
                                                        tags$br(),
                                                        tags$h4("Lors de vos déplacements quotidiens (travail, études, loisirs, courses) quel facteur vous encouragerait à moins utiliser votre voiture (y compris un véhicule utilitaire), votre moto ou votre scooter ?"),
                                                        tags$p("1 - Une augmentation du coût d’utilisation de votre voiture/deux roues (entretien, carburant, assurance, stationnement, péage)", tags$br(),
                                                               "2 - De meilleurs transports en commun (proximité, fréquence, sécurité, confort)", tags$br(),
                                                               "3 - Des transports en commun moins chers", tags$br(),
                                                               "4 - Des pistes cyclables plus nombreuses et plus sûres", tags$br(),
                                                               "5 - Aucun des facteurs ci-dessus" ),
                                                        tags$br(),
                                                        tags$h3("Consommation"),
                                                        tags$h4("Lorsque vous achetez certains produits, faites-vous attention à la quantité de déchets que cela implique ?"),
                                                        tags$p("1 - Jamais", tags$br(),
                                                               "2 - Occasionnellement", tags$br(),
                                                               "3 - Souvent ", tags$br(),
                                                               "4 - Toujours" ),
                                                        tags$br(),
                                                        tags$h4("Au cours du dernier mois, vous même ou un membre de votre ménage, avez-vous réalisé des achats dans un magasin bio ou dans le rayon bio d’un supermarché ?"),
                                                        tags$p("1 - Oui", tags$br(),
                                                               "2 - Non" ),
                                                        tags$br(),
                                                        tags$h4("Au cours du dernier mois, vous même ou un membre de votre ménage, avez-vous acheté un ou plusieurs produits portant un label écologique (comme par exemple le label NF Environnement) ?"),
                                                        tags$p("1 - Oui", tags$br(),
                                                               "2 - Non" ),
                                                        tags$br(),
                                                        tags$h4("Lorsque vous achetez vos produits alimentaires (fruits, légumes, viandes), faites-vous attention à la distance parcourue pour leur transport (leur provenance géographique) ?"),
                                                        tags$p("1 - Jamais", tags$br(),
                                                               "2 - Occasionnellement", tags$br(),
                                                               "3 - Souvent ", tags$br(),
                                                               "4 - Toujours" ),
                                                        tags$br(),
                                                        tags$h4("Lorsque vous achetez vos produits non-alimentaires (vêtements, chaussures, meubles), accordez-vous de l’importance au lieu de fabrication (leur provenance géographique) ?"),
                                                        tags$p("1 - Jamais", tags$br(),
                                                               "2 - Occasionnellement", tags$br(),
                                                               "3 - Souvent ", tags$br(),
                                                               "4 - Toujours" ),
                                                        tags$br(),
                                                        tags$h4("On parle de plus en plus de « consommation responsable ». Selon vous, la consommation responsable c’est en priorité ?"),
                                                        tags$p("1 - Investir dans des produits plus robustes et plus économiques sur le long terme", tags$br(),
                                                               "2 - Acheter ce qui est nécessaire et éviter le gaspillage", tags$br(),
                                                               "3 - Consommer des produits issus du commerce équitable", tags$br(),
                                                               "4 - Consommer des produits plus respectueux de l’environnement", tags$br(),
                                                               "5 - Acheter des produits fabriqués localement pour limiter les transports de marchandise et favoriser l’emploi local"),
                                                        tags$br(),
                                                        tags$h4("Qu’est-ce qui vous inciterait à acheter davantage de produits respectueux de l’environnement"),
                                                        tags$p("1 - Pouvoir les repérer plus facilement", tags$br(),
                                                               "2 - Etre mieux informé sur leurs particularités et conditions d’utilisation", tags$br(),
                                                               "3 - Etre certain qu’ils ne coûtent pas plus chers", tags$br(),
                                                               "4 - Disposer d’un choix plus large de produits de ce type"),
                                                        tags$br(),
                                                        tags$h3("Opinions"),
                                                        tags$h4("Qui devrait, selon vous, agir en priorité pour la protection de l’environnement ?"),
                                                        tags$p("1 - Les pouvoirs publics", tags$br(),
                                                               "2 - Les ménages", tags$br(),
                                                               "3 - Les entreprises"),
                                                        tags$br(),
                                                        tags$h4("Aujourd’hui, qu’est-ce qui vous motive le plus à agir pour protéger l’environnement ?"),
                                                        tags$p("1 - Limiter les conséquences du changement climatique", tags$br(),
                                                               "2 - Laisser aux générations futures un environnement de qualité", tags$br(),
                                                               "3 - Protéger ma santé et celle de mes proches", tags$br(),
                                                               "4 - Préserver la nature, les espèces animales et végétales", tags$br(),
                                                               "5 - Aucune de ces raisons"),
                                                        tags$br(),
                                                        tags$h4("A votre niveau, comment agissez-vous pour protéger l’environnement ?"),
                                                        tags$p("1 - Vous en faites déjà beaucoup", tags$br(),
                                                               "2 - Vous pourriez en faire davantage", tags$br(),
                                                               "3 - Vous faites le plus que vous pouvez", tags$br(),
                                                               "4 - Vous ne pensez pas qu’il est vraiment utile d’agir individuellement"),
                                                        tags$br(),
                                                        tags$h4("Sur le même sujet, laquelle de ces opinions correspond le plus à votre état d’esprit ?"),
                                                        tags$p("1 - Vous considérez que chacun doit s’investir le plus possible", tags$br(),
                                                               "2 - Vous n’avez pas les moyens d’agir à votre niveau", tags$br(),
                                                               "3 - Vous ne disposez pas d’informations qui vous inciteraient à en faire davantage", tags$br(),
                                                               "4 - Vous pensez que les problèmes environnementaux sont exagérés", tags$br(),
                                                               "5 - Aucune de ces opinions"),
                                                        tags$br(),
                                                        tags$h3("Archives"),
                                                        tags$h4("Selon vous, votre logement est-il mal ou insuffisamment isolé du froid et de la chaleur extérieurs ? (2009-2019)"),
                                                        tags$p("1 - Oui", tags$br(),
                                                               "2 - Non" ),
                                                        tags$br(),
                                                        tags$h4("Selon vous serait il nécessaire d’entreprendre des travaux destinés à diminuer la consommation d’énergie de votre logement (chauffage, isolation, ventilation, ...) ? (2009-2019)"),
                                                        tags$p("1 - Oui", tags$br(),
                                                               "2 - Non" ),
                                                        tags$br(),
                                                        tags$h4("Parmi les moyens de transport suivants, lequel utilisez-vous habituellement pour vous rendre sur votre lieu de travail ou d'études ? (2009-2019)"),
                                                        tags$p("1 - Une voiture ou un véhicule utilitaire exclusivement", tags$br(),
                                                                 "2 - Une moto, un scooter ou un autre deux-roues motorisé exclusivement", tags$br(),
                                                                 "3 - Un véhicule personnel (voiture ou deux roues) et un ou plusieurs transports en commun", tags$br(),
                                                                 "4 - Un vélo et un ou plusieurs transports en commun", tags$br(),
                                                                 "5 - Un ou plusieurs transports en commun exclusivement", tags$br(),
                                                                 "6 - Un vélo exclusivement", tags$br(),
                                                                 "7 - La marche à pied", tags$br(),
                                                                 "8 - C’est trop variable pour répondre"),
                                                        tags$br()
                                               )
                                      )
                             )
                    )
           )
  )
)



# tags$div(
# 
# h2("Questionnaire CGDD – Baromètre sur l'environnement",style="text-align:center;"),br(),br(),
# 
# div(HTML("
# 
# <p>
# <h4><b> &nbsp Préoccupations</b><br>
# <h5><b>   Parmi les problèmes suivants liés à la dégradation de l’environnement, quels sont les deux qui vous paraissent les plus préoccupants ?</b><br>
# <br>
# 1 - La gêne occasionnée par le bruit <br>
# 2 - La pollution de l’air <br>
# 3 - La pollution de l’eau, des rivières et des lacs <br>
# 4 - Le réchauffement de la planète (et l’effet de serre) <br>
# 5 - La disparition de certaines espèces végétales ou animales <br>
# 6 - Les catastrophes naturelles (inondations, tempêtes, séismes, feux de forêts…) <br>
# 7 - L’augmentation des déchets des ménages <br>
# 8 - Aucun <br>
# <br>
# <br> 
# <b>   Parmi les problèmes suivants, quels sont les deux qui concernent votre quartier (là où vous habitez) ? </b><br>
# <br>
# 1 - Le bruit <br>
# 2 - La pollution de l’air <br>
# 3 - Le manque de transports en commun <br>
# 4 - L’environnement dégradé (mal entretenu, manque de propreté) <br>
# 5 - Les risques liés à la présence d’installations dangereuses (industrielles, nucléaires) <br>
# 6 - Les risques naturels (inondations, tempêtes, séismes, feux de forêts) <br>
# 7 - Aucun <br>
# <br>
# <br>
# <h4><b> &nbsp Logement et énergie</b><br>
# <h5><b>   A votre domicile, vous arrive-t-il de couper le mode veille des appareils électroniques ? </b><br>
# <br>
# 1 - Jamais <br>
# 2 - Occasionnellement <br>
# 3 - Souvent <br>
# 4 - Toujours <br>
# <br>
# <br>
# <b>   A votre domicile, vous arrive t’il de baisser le chauffage ou la climatisation afin de limiter votre consommation d’énergie ? </b><br>
# <br>
# 1 - Jamais <br>
# 2 - Occasionnellement <br>
# 3 - Souvent <br>
# 4 - Toujours <br>
# <br>
# <br>
# <h4><b> &nbsp Transport</b><br>
# <h5><b>   Parmi les moyens de transport suivants, lequel utilisez-vous habituellement pour vous rendre sur votre lieu de travail ou d'études? </b><br>
# <br>
# 1 - Une voiture ou un véhicule utilitaire exclusivement <br>
# 2 - Une moto, un scooter ou un autre deux-roues motorisé exclusivement <br>
# 3 - Un véhicule personnel (voiture ou deux roues) et un ou plusieurs transports en commun <br>
# 4 - Un vélo et un ou plusieurs transports en commun <br>
# 5 - Un ou plusieurs transports en commun exclusivement <br>
# 6 - Un vélo exclusivement <br>
# 7 - La marche à pied <br>
# 8 - C’est trop variable pour répondre <br>
# <br>
# <br>
# <b>   Là où vous habitez, pensez-vous qu’à l’avenir il sera de plus en plus facile pour vous d’effectuer vos déplacements quotidiens (travail, études, loisir, courses) sans voiture ?</b><br>
# <br>
# 1 - Oui <br>
# 2 - Non <br>
# <br>
# <br>
# <b>   Lors de vos déplacements quotidiens (travail, études, loisirs, courses) quel facteur vous encouragerait à moins utiliser votre voiture (y compris un véhicule utilitaire), votre moto ou votre scooter ? </b><br>
# <br>
# 1 - Une augmentation du coût d’utilisation de votre voiture/deux roues (entretien, carburant, assurance, stationnement, péage) <br>
# 2 - De meilleurs transports en commun (proximité, fréquence, sécurité, confort) <br>
# 3 - Des transports en commun moins chers  <br>
# 4 - Des pistes cyclables plus nombreuses et plus sûres <br>
# 5 - Aucun des facteurs ci-dessus <br>
# <br>
# <br>
# <h4><b> &nbsp Consommation</b><br>
# <h5><b> Lorsque vous achetez certains produits, faites-vous attention à la quantité de déchets que cela implique ? </b><br>
# <br>
# 1 - Jamais <br>
# 2 - Occasionnellement <br>
# 3 - Souvent <br>
# 4 - Toujours <br>
# <br>
# <br>
# <b> Au cours du dernier mois, vous même ou un membre de votre ménage, avez-vous réalisé des achats dans un magasin bio ou dans le rayon bio d’un supermarché ? </b><br>
# <br>
# 1 - Oui <br>
# 2 - Non <br>
# <br>
# <br>
# <b> Au cours du dernier mois, vous même ou un membre de votre ménage, avez-vous acheté un ou plusieurs produits portant un label écologique (comme par exemple le label NF Environnement) ? </b><br>
# <br>
# 1 - Oui <br>
# 2 - Non <br>
# <br>
# <br>
# <b> Lorsque vous achetez vos produits alimentaires (fruits, légumes, viandes), faites-vous attention à la distance parcourue pour leur transport (leur provenance géographique) ? </b><br>
# <br>
# 1 - Jamais <br>
# 2 - Occasionnellement <br>
# 3 - Souvent <br>
# 4 - Toujours <br>
# <br>
# <br>
# <b> Lorsque vous achetez vos produits non-alimentaires (vêtements, chaussures, meubles), accordez-vous de l’importance au lieu de fabrication (leur provenance géographique) ? </b><br>
# <br>
# 1 - Jamais <br>
# 2 - Occasionnellement <br>
# 3 - Souvent <br>
# 4 - Toujours <br>
# <br>
# <br>
# <b> On parle de plus en plus de « consommation responsable ». Selon vous, la consommation responsable c’est en priorité ? </b><br>
# <br>
# 1 - Investir dans des produits plus robustes et plus économiques sur le long terme <br>
# 2 - Acheter ce qui est nécessaire et éviter le gaspillage <br>
# 3 - Consommer des produits issus du commerce équitable <br>
# 4 - Consommer des produits plus respectueux de l’environnement <br>
# 5 - Acheter des produits fabriqués localement pour limiter les transports de marchandise et favoriser l’emploi local <br>
# <br>
# <br>
# <b> Qu’est-ce qui vous inciterait à acheter davantage de produits respectueux de l’environnement </b><br>
# <br>
# 1 - Pouvoir les repérer plus facilement <br>
# 2 - Etre mieux informé sur leurs particularités et conditions d’utilisation <br>
# 3 - Etre certain qu’ils ne coûtent pas plus chers <br>
# 4 - Disposer d’un choix plus large de produits de ce type <br>
# <br>
# <br>
# <h4><b> &nbsp Opinions </b><br>
# <h5><b>Qui devrait, selon vous, agir en priorité pour la protection de l’environnement ? </b><br>
# <br>
# 1 - Les pouvoirs publics <br>
# 2 - Les ménages <br>
# 3 - Les entreprises <br>
# <br>
# <br>
# <b> Aujourd’hui, qu’est-ce qui vous motive le plus à agir pour protéger l’environnement ? </b><br>
# <br>
# 1 - Limiter les conséquences du changement climatique <br>
# 2 - Laisser aux générations futures un environnement de qualité  <br>
# 3 - Protéger ma santé et celle de mes proches <br>
# 4 - Préserver la nature, les espèces animales et végétales <br>
# 5 - Aucune de ces raisons <br>
# <br>
# <br>
# <b> A votre niveau, comment agissez-vous pour protéger l’environnement ? </b><br>
# <br>
# 1 - Vous en faites déjà beaucoup <br>
# 2 - Vous pourriez en faire davantage <br>
# 3 - Vous faites le plus que vous pouvez <br>
# 4 - Vous ne pensez pas qu’il est vraiment utile d’agir individuellement <br>
# <br>
# <br>
# <b> Sur le même sujet, laquelle de ces opinions correspond le plus à votre état d’esprit ? </b><br>
# <br>
# 1 - Vous considérez que chacun doit s’investir le plus possible <br>
# 2 - Vous n’avez pas les moyens d’agir à votre niveau <br>
# 3 - Vous ne disposez pas d’informations qui vous inciteraient à en faire davantage <br>
# 4 - Vous pensez que les problèmes environnementaux sont exagérés <br>
# 5 - Aucune de ces opinions <br>
# <br>
# <br>
# <h4><b> &nbsp Archives </b><br>
# <h5><b>Selon vous, votre logement est-il mal ou insuffisamment isolé du froid et de la chaleur extérieurs ? (2009-2019) </b><br>
# <br>
# 1 - Oui <br>
# 2 - Non <br>
# <br>
# <br>
# <b>Selon vous serait il nécessaire d’entreprendre des travaux destinés à diminuer la consommation d’énergie de votre logement (chauffage, isolation, ventilation, ...) ? (2009-2019) </b><br>
# <br>
# 1 - Oui <br>
# 2 - Non <br>
# <br>
# <br>
# <b> Parmi les moyens de transport suivants, lequel utilisez-vous habituellement pour vous rendre sur votre lieu de travail ou d'études ? (2009-2019) </b><br>
# <br> 
# 1 - Une voiture ou un véhicule utilitaire exclusivement <br>
# 2 - Une moto, un scooter ou un autre deux-roues motorisé exclusivement <br>
# 3 - Un véhicule personnel (voiture ou deux roues) et un ou plusieurs transports en commun <br>
# 4 - Un vélo et un ou plusieurs transports en commun <br>
# 5 - Un ou plusieurs transports en commun exclusivement <br>
# 6 - Un vélo exclusivement <br>
# 7 - La marche à pied <br>
# 8 - C’est trop variable pour répondre <br>
# <br>
# <br>
# "))
# )
# ))