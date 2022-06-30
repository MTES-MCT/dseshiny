#################################################################################
#########                                                               #########
#########             Configuration des Variables DSFR                  #########
#########                                                               #########
#################################################################################
#########                                                               #########
#########                      Toutes les variables                     #########
#########                             sont                              #########
#########                          documentées                          #########
#########                                                               #########
#################################################################################

#******************************* Configuration du header ***********************************#

#--------------------------------- Composants obligatoires ---------------------------------#

#répertoire d'application pour le développement
#repertoryApp <- "C:/Users/User/OneDrive/Documents/projet-dsfr-r-shiny/app0"

#Variables globales (NE PAS MODIFIER)
nomodule <- "nomodule"
frthemeModale <- "aria-controls='fr-theme-modal'"
frradiothemeLight <- "for='fr-radios-theme-light'"
frradiothemeDark <- "for='fr-radios-theme-dark'"
frradiothemeSystem <- "for='fr-radios-theme-system'"
datafrinjectsvg <- "data-fr-inject-svg"


# URL valides
validFiles = c("rshiny_dsfr/home.R",                             # valid files must be hardcoded here
               "rshiny_dsfr/accessibilite.R", "rshiny_dsfr/mentionslegales.R",
               "rshiny_dsfr/donneespersonnelles.R")              #    for security (use all lower-case
# Url du site
urlpage <- "https://localhost:xxxx/"

# Nom de votre organisme edans le premier logo (Marianne). Ajouter autant de br() si votre nom est sur plusieurs lignes
# Exemple : organismeSite <- tags$html("Ministère",br(),"de l'agriculture",br(), "et de la souveraineté",br(), "alimentaire")
organismeSite <- tags$html("Ministère ", br(), "de la transition", br(), "écologique",br(),"et de la cohésion",br(),"des territoires")

#Méta Charset
charset <- "utf-8"

#Description de votre page ou de votre site
description <- "Entrez la description de cette page ici"

#--------------------------------- Composants masquables ---------------------------------#

# Mettre en place le DSFR
activerDSFR <- "oui" #Choix "oui" / "non" -> Affiche ou non les élements header et footer de la page web

#Vous pouvez si vous le souhaitez, masquer les composants ci-dessous qui n'apparaîtront pas sur votre page

# Titre du site #
afficherTitre <- "oui" # Choix : "oui" / "non" . Si vous souhaitez afficher le titre, modifiez le texte ci-dessous avec votre titre
titresite <- "Titre du site"

# Titre apparaissant dans sur l'onglet de la page du navigateur
titreonglet <- "Ministère de la transition écologique et de la cohésion des territoires - Titre du site"



#Slogan
afficherSlogan <- "oui" # Choix : "oui" / "non" . Si vous souhaitez afficher le slogan modifiez le texte ci-dessous avec votre slogan
slogan <- "Votre slogan ici, laissez vide pour ne plus afficher"

#Second logo
afficherSL <- "oui" # Choix : "oui" / "non". Si vous avez un second logo, indiquez l'url de votre logo ci-dessous
SL <- "rshiny_dsfr/www/img/sl.png" # Url de votre second logo
altSL <- "Second logo" # Alternative textuelle si votre second logo ne s'affiche pas

#Méta réseax sociaux (Opengraph, Twitter, DublinCore)
afficherRS <- "non" # afficher les balises méta pour les réseaux sociaux (Opengraph, Twitter, DublinCore)
# ///////// Configuration des balises ci-dessous pour les réseaux sociaux  /////////#
# Balises Opengraph
ogtype <- "website" # La liste est disponible à cette adresse ; https://ogp.me/#types (dans la plupart des cas, conserver le choix "website")
ogsitename <- "Titre de la page - Nom du site"
ogtitle <- "Titre de la cette page"
ogurl <- urlpage
ogimage <- "URL de l'image OGImage"
ogdescription <- description
# Balises Twittergraph
twittercard <- "summary_large_image" # les paramètres sont : summary_large_image, summary, player, app
twitternomsite <- "@nomdusite"
twitterurl <- urlpage
twittertitle <- "Titre de cette page"
twitterimage <- "URL de l'image Twitter"
twitterdescription <- description
# Balisage DublinCore
dctitle <- "Titre de cette page"
dcdescription <- description
dccreator <- "Bureau des usages numériques"
dcidentifier <- urlpage
# ///////// fin de Configuration des balises ci-dessous pour les réseaux sociaux  /////////#

# Moteur de recherches
afficherSearchbox <- "non" #Afficher le formulaire de recherche
urlSearchpage <- "https://..." #Url de la page de résultats de recherche

# Afficher le liste de liens du header (Attention seulement 3 liens maximum autoriser si vous utilisez le 3eme lien, le lien paramètres d'affichage disparaîtra du header )
afficherLL <- "oui" # Choix "oui" / "non" -> autoriser l'affichage de la liste de lien
# Lien 1
afficherLL1 <- "non" # Choix : "oui" / "non" -> Afficher le premier lien de la liste de lien dans le header, modifier les 4 paramètres ci-dessous pour définir le lien 1
titre1lien <- "lien 1" #Titre du premier lien
url1lien <- "/" # url du premier lien
icon1lien <- "fr-link fr-icon-links-fill" # les icônes sont définies dans le DSFR et disponibles à cette adresse : https://gouvfr.atlassian.net/wiki/spaces/DB/pages/222331396/Ic+nes+-+Icons

# Lien 2
afficherLL2 <- "non" # Choix : "oui" / "non" -> Afficher le second lien de la liste de lien dans le header, modifier les 4 paramètres ci-dessous pour définir le lien 1
titre2lien <- "lien 2" # Titre du second lien
url2lien <- "/" # url du second lien
icon2lien <- "fr-link fr-icon-links-fill" # les icônes sont définies dans le DSFR et disponibles à cette adresse : https://gouvfr.atlassian.net/wiki/spaces/DB/pages/222331396/Ic+nes+-+Icons

# Lien 3
afficherLL3 <- "non" # Choix : "oui" / "non" -> Afficher le troisième lien de la liste de lien dans le header, modifier les 4 paramètres ci-dessous pour définir le lien 1
titre3lien <- "lien 3" # Titre du troisième lien
url3lien <- "/" # url du troisième lien
icon3lien <- "fr-link fr-icon-links-fill" # les icônes sont définies dans le DSFR et disponibles à cette adresse : https://gouvfr.atlassian.net/wiki/spaces/DB/pages/222331396/Ic+nes+-+Icons

# Autoriser le mode dark
afficherDisplaymode <- "oui" # Autorise l'affichage du mode sombre

# Afficher les menus
afficherMenu <- "oui"


afficherCookies <- "non" # Afficher le consentement pour les cookies
baliseCookies <- "#consentement" # Balise d'appel de la fenêtre de consentement NE PAS MODIFIER si vous n'êtes pas sur.
servicesCookies <- "(tarteaucitron.job = tarteaucitron.job || []).push('gajs');"


#******************************* Configuration du footer ***********************************#

#--------------------------------- Composants obligatoires ---------------------------------#


#--------------------------------- Composants masquables ---------------------------------#
#Vous pouvez si vous le souhaitez, masquer les composants ci-dessous qui n'apparaîtront pas sur votre page

#Description apparaissant dans le footer
afficherFD <- "oui" # Choix "oui" / "non" -> Afficher la description ci-dessous dans le footer
footerDesc <- HTML(paste("Ceci est la descripton qui apparaît dans le footer. Elle n'est pas obligatoire . Vous pouvez choisir de l'afficher ou pas."))

#Partenaires
afficherBP <- "oui" # Afficher le bloc partenaires (max 2 partenaires principaux et 3 partenaires secondaires)
titreBloc <- "Nos partenaires" # Titre du bloc partenaires
# Partenaires principaux
afficherPP1 <- "oui" # Afficher le partenaire principal 1
urlImgP1 <- "rshiny_dsfr/www/img/sl.png" # Url de votre partenaire principal 1
altP1 <- "Partenaire P1" # Alternative textuelle si votre image ne s'affiche pas
afficherPP2 <- "oui" # Afficher le partenaire principal 2
urlImgP2 <- "rshiny_dsfr/www/img/sl.png" # Url de votre partenaire principal 2
altP2 <- "Partenaire P2" # Alternative textuelle si votre image ne s'affiche pas
# Partenaires secondaires
afficherPS1 <- "oui" # Afficher le partenaire secondaire 1
urlImgPS1 <- "rshiny_dsfr/www/img/sl.png" # Url de votre partenaire principal 2
altPS1 <- "Partenaire PS1" # Alternative textuelle si votre image ne s'affiche pas
afficherPS2 <- "oui" # Afficher le partenaire secondaire 2
urlImgPS2 <- "rshiny_dsfr/www/img/sl.png" # Url de votre partenaire principal 2
altPS2 <- "Partenaire PS2" # Alternative textuelle si votre image ne s'affiche pas
afficherPS3 <- "oui" # Afficher le partenaire secondaire 3
urlImgPS3 <- "rshiny_dsfr/www/img/sl.png" # Url de votre partenaire principal 2
altPS3 <- "Partenaire PS3" # Alternative textuelle si votre image ne s'affiche pas

# Autoriser l'affichage du bouton "revenir en haut de page"
afficherHP <- "oui"

##### Page Accessibilité #####
titreLienAccessibilite <- "Accessibilité: partiellement conforme"
conformiteAffichee <- "est en conformité partielle" #3 arguments possibles :
                                                    #- est en conformité
                                                    #- n'est pas en corformité
                                                    #- est en conformité partielle
texteAccessibilite <- "Le Commissariat général au développement durable (CGDD), direction du ministère de la Transition écologique, s’engage à rendre son site internet accessible conformément à l’article 47 de la loi n°2005-102 du 11 février 2005. A cette fin, un schéma d’accessibilité numérique et son plan d’action est en cours d’élaboration."

##### Page Mentions légales #####
editeur <- "Commissariat général au développement durable, CGDD, direction générale du Ministère de la transition écologique et de la cohésion des territoires"
directeurPublication <- "Nom du directeur de publication et service d'appartenance"
hebergement <- HTML(paste("AVENIR TELEMATIQUE - ATE SAS",
                          "21, avenue de la créativité - 59650 Villeneuve d’Ascq",
                          "Téléphone : 03 28 80 03 00",
                          "Site web : ", a(href="https://www.ate.info/", class="spip_url spip_out auto", rel="nofollow external", "https://www.ate.info/"), sep="<br>"))

autoriserPRS <- "non" # Autorisation de partage sur les réseaux sociaux

################### Fin de Configuration des Variables DSFR ###################

