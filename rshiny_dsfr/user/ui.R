#### Initialisation ####

age1=35 #age pour le decoupage : moins de age1 ; entre age1 et age2 ; plus de age2
age2=60
dig = 1 #nombre de digits des arrondis


#Récupération des nom des fichiers de données
donnees <- list.files(path = file.path(getwd(),"donnees_r"),pattern = "Rdata") 

#Nombre de fichier
Taille = length(donnees)

#Creation des quintile pour le niveau de vie
#On recupere tous les niveau de vie sur toute les années
Tot=c()
for (i in 1:Taille){
  load(file = file.path(getwd(),"donnees_r",donnees[i]))  #chargement des donnees
  attach(data)
  #rajout au vecteur des donn?es
  Tot=c(Tot, Niv_vie)
  #supression pour passage a la suite
  detach(data)
  rm(data)
}
Quintiles=quantile(Tot,probs=c(0,0.20,0.40,0.60,0.80,1))
rm(Tot)


## Partie a modifier pour l'annee en cours

Annee_Preocupation = c("Principale préoccupation"="Q1","Les deux principales préoccupations"="Q2", 
                       "Principal problème de quartier"="Q3", "Deux principaux problèmes de quartier"="Q4")
Annee_Logement = c("Extinction des veilles"="Q13","Régulation thermique du logement"="Q14")
Annee_Transport = c("Mode de déplacement Domicile-Travail"="Q5", "Facilité à se déplacer sans la voiture"="Q6",
                    "Motivation à se passer de la voiture"="Q7")
Annee_Consomation = c("Déchets induits par les achats"="Q8", "Achat bio"="Q9", "Achat écolabel"="Q10",
                      "Provenance achats alimentaires"="Q11", "Provenance achats non-alimentaires"="Q12",
                      "Définition de la consommation responsable"="Q16",
                      "Motivation à acheter des produits plus respectueux de l'environnement"="Q17")
Annee_Opinion = c("Acteurs de la protection de l'environnement"="Q15", "Motivation à agir"="Q18",
                  "Niveau d'engagement personnel"="Q19", "Opinion sur l'action environnementale"="Q20")

## fin de la partie a modifier pour l'annee en cours


## Partie a modifier pour la serie

Questions_Preocupation = c("Principale préoccupation"="Q1","Les deux principales préoccupations"="Q2", 
                           "Principal problème de quartier"="Q3", "Deux principaux problèmes de quartier"="Q4")
Questions_Logement = c("Extinction des veilles"="Q13","Régulation thermique du logement"="Q14")
Questions_Transport = c("Mode de déplacement Domicile-Travail"="Q5", "Facilité à se déplacer sans la voiture"="Q6",
                        "Motivation à se passer de la voiture"="Q7")
Questions_Consomation = c("Déchets induits par les achats"="Q8", "Achat bio"="Q9", "Achat écolabel"="Q10",
                          "Provenance achats alimentaires"="Q11", "Provenance achats non-alimentaires"="Q12",
                          "Définition de la consommation responsable"="Q16",
                          "Motivation à acheter des produits plus respectueux de l'environnement"="Q17")
Questions_Opinion = c("Acteurs de la protection de l'environnement"="Q15", "Motivation à agir"="Q18",
                      "Niveau d'engagement personnel"="Q19", "Opinion sur l'action environnementale"="Q20")
Questions_Archives = c("Problème d'isolation du logement (2009-2019)"="A1", "Travaux d'amélioration thermique du logement (2009-2019)"="A2",
                       "Mode de déplacement pour les courses (2009-2019)"="A3")

## fin de la partie a modifier pour la serie

## Modification a apporter si besoin 
Question_OuiNon = c("A1","A2","Q6","Q9","Q10")
Question_Aucun = c("Q1","Q2","Q5","Q7","Q18","A3")
Question_jost = c("Q8","Q11","Q12","Q13","Q14")


## Partie sans modification 
#liste des variable
Variable = c("Synthèse"="1","Genre"="2","Âge"="3","Type d'agglomération"="4","Niveau d'étude"="5","Niveau de vie"="6","Catégorie socio-professionnelle"="7")

#titre par defaut pour eviter les bugs
titre="titre"

#text de la source
Srce_ser = paste("<B>Source :</B> SDES, plateforme Environnement de l'enquête Insee 'Camme' (2009-",as.character(2009+Taille-1),")", sep = "")
Srce_ann = paste("<B>Source :</B> SDES, plateforme Environnement de l'enquête Insee 'Camme' ",as.character(2009+Taille-1), sep = "")

#marge du grapgique 
margin_scatter = list(l = 50, r = 50, b = 70, t = 100, pad = 4) #pour la serie
margin_bar = list(l = 250, r = 50, b = 100, t = 100, pad = 4) #pour l'anne en cours

#Couleur des graphiques
couleurs = c('rgb(120,180,30)','rgb(51,113,153)','rgb(255,202,0)','rgb(255,0,0)','rgb(64,64,255)','rgb(125,78,91)','rgb(161,186,195)')

#Nom des variable pour la legende
Name_Genre = c("Homme","Femme")
Name_Age = c(paste("Moins de", as.character(age1),"ans"), paste("Entre", as.character(age1), "et", as.character(age2), "ans"), paste("Plus de", as.character(age2), "ans"))
Name_TU = c("Agglomération de Paris", "Unité Urbaine de plus de 100 000 habitants", "Unité Urbaine de moins de 100 000 habitants", "Milieu rural")
Name_NivEtud = c("Primaire ou moins", "Brevet ou équivalent", "Bac ou équivalent","Supérieur")
Name_Niv_Vie = c(paste("Moins de",as.character(as.integer(Quintiles[2])),"€"),
                 paste("De", as.character(as.integer(Quintiles[2])), "à", as.character(as.integer(Quintiles[3])), "€"),
                 paste("De", as.character(as.integer(Quintiles[3])), "à", as.character(as.integer(Quintiles[4])), "€"),
                 paste("De", as.character(as.integer(Quintiles[4])), "à", as.character(as.integer(Quintiles[5])), "€"),
                 paste("Plus de", as.character(as.integer(Quintiles[5])), "€"))
Name_CS = c("Agriculteurs", "Artisans, commerçants, chefs d'entreprise", "Cadres supérieurs, professions libérales",
            "Professions intermédiaires", "Employés", "Ouvriers")

## fin de la partie sans modification 


## Partie a modifier lors du rajout des questions 
#/!\ le faire dans l'ordre des code de question

#Liste des intitutle de question
Name_Question = c("Parmi les problèmes suivants liés à la dégradation de l’environnement, quel est celui qui vous paraît le plus préoccupant ?",
                  "Parmi les problèmes suivants liés à la dégradation de l’environnement, quels sont les deux qui vous paraissent les plus préoccupants ?",
                  "Parmi les problèmes suivants, quel est celui qui concerne le plus votre quartier (là où vous habitez) ?",
                  "Parmi les problèmes suivants, quels sont les deux qui concernent votre quartier (là où vous habitez) ?",
                  "Parmi les moyens de transport suivants, lequel utilisez-vous habituellement pour vous rendre sur votre lieu de travail ou d'études ?",
                  "Là où vous habitez, pensez-vous qu’à l’avenir il sera de plus en plus facile pour vous d’effectuer vos déplacements quotidiens (travail, études, loisir, courses) sans voiture ?",
                  "Lors de vos déplacements quotidiens (travail, études, loisirs, courses) quel facteur vous encouragerait à moins utiliser votre voiture (y compris un véhicule utilitaire), votre moto ou votre scooter ?",
                  "Lorsque vous achetez certains produits, faites-vous attention à la quantité de déchets que cela implique ?",
                  "Au cours du dernier mois, vous même ou un membre de votre ménage, avez-vous réalisé des achats dans un magasin bio ou dans le rayon bio d’un supermarché ?",
                  "Au cours du dernier mois, vous même ou un membre de votre ménage, avez-vous acheté un ou plusieurs produits portant un label écologique (comme par exemple le label NF Environnement) ?",
                  "Lorsque vous achetez vos produits alimentaires (fruits, légumes, viandes), faites-vous attention à la distance parcourue pour leur transport (leur provenance géographique) ?",
                  "Lorsque vous achetez vos produits non-alimentaires (vêtements, chaussures, meubles), accordez-vous de l’importance au lieu de fabrication (leur provenance géographique) ?",
                  "A votre domicile, vous arrive-t-il de couper le mode veille des appareils électroniques ?",
                  "A votre domicile, vous arrive-t-il de baisser le chauffage ou la climatisation afin de limiter votre consommation d’énergie ?",
                  "Qui devrait, selon vous, agir en priorité pour la protection de l’environnement ? ",
                  "On parle de plus en plus de « consommation responsable ». Selon vous, la consommation responsable c’est en priorité ?",
                  "Qu’est-ce qui vous inciterait à acheter davantage de produits respectueux de l’environnement ?",
                  "Aujourd’hui, qu’est-ce qui vous motive le plus à agir pour protéger l’environnement ?",
                  "A votre niveau, comment agissez-vous pour protéger l’environnement ?",
                  "Sur le même sujet, laquelle de ces opinions correspond le plus à votre état d’esprit ?")

Name_Archive = c("Selon vous, votre logement est-il mal ou insuffisamment isolé du froid et de la chaleur extérieurs ?",
                 "Selon vous serait il nécessaire d’entreprendre des travaux destinés à diminuer la consommation d’énergie de votre logement (chauffage, isolation, ventilation, ...) ?",
                 "Parmi les moyens de transport suivants, lequel utilisez-vous habituellement pour faire vos courses ? ")

#Liste des reponse possible au questions
Reponses_question = list(c("La gêne occasionnée par le bruit","La pollution de l’air","La pollution de l’eau, des rivières et des lacs","Le réchauffement de la planète (et l’effet de serre)","La disparition de certaines espèces végétales ou animales","Les catastrophes naturelles (inondations, tempêtes, séismes, feux de forêts…)","L’augmentation des déchets des ménages","Aucun"),
                         c("La gêne occasionnée par le bruit","La pollution de l’air","La pollution de l’eau, des rivières et des lacs","Le réchauffement de la planète (et l’effet de serre)","La disparition de certaines espèces végétales ou animales","Les catastrophes naturelles (inondations, tempêtes, séismes, feux de forêts…)","L’augmentation des déchets des ménages","Aucun"),
                         c("Le bruit","La pollution de l’air","Le manque de transports en commun","L’environnement dégradé (mal entretenu, manque de propreté)","Les risques liés à la présence d’installations dangereuses (industrielles, nucléaires)","Les risques naturels (inondations, tempêtes, séismes, feux de forêts)","Aucun"),
                         c("Le bruit","La pollution de l’air","Le manque de transports en commun","L’environnement dégradé (mal entretenu, manque de propreté)","Les risques liés à la présence d’installations dangereuses (industrielles, nucléaires)","Les risques naturels (inondations, tempêtes, séismes, feux de forêts)","Aucun"),
                         c("Une voiture ou un véhicule utilitaire exclusivement","Une moto, un scooter ou un autre deux-roues motorisé exclusivement","Un véhicule personnel (voiture ou deux roues) et un ou plusieurs transports en commun","Un vélo et un ou plusieurs transports en commun","Un ou plusieurs transports en commun exclusivement","Un vélo exclusivement","La marche à pied","C’est trop variable pour répondre"),
                         c("Oui","Non"),
                         c("Une augmentation du coût d’utilisation de votre voiture/deux roues (entretien, carburant, assurance, stationnement, péage)","De meilleurs transports en commun (proximité, fréquence, sécurité, confort)","Des transports en commun moins chers","Des pistes cyclables plus nombreuses et plus sûres","Aucun des facteurs ci-dessus"),
                         c("Jamais","Occasionnellement","Souvent","Toujours"),
                         c("Oui","Non"),
                         c("Oui","Non"),
                         c("Jamais","Occasionnellement","Souvent","Toujours"),
                         c("Jamais","Occasionnellement","Souvent","Toujours"),
                         c("Jamais","Occasionnellement","Souvent","Toujours"),
                         c("Jamais","Occasionnellement","Souvent","Toujours"),
                         c("Les pouvoirs publics","Les ménages","Les entreprises"),
                         c("Investir dans des produits plus robustes et plus économiques sur le long terme","Acheter ce qui est nécessaire et éviter le gaspillage","Consommer des produits issus du commerce équitable","Consommer des produits plus respectueux de l’environnement","Acheter des produits fabriqués localement pour limiter les transports de marchandise et favoriser l’emploi local"),
                         c("Pouvoir les repérer plus facilement","Etre mieux informé sur leurs particularités et conditions d’utilisation","Etre certain qu’ils ne coûtent pas plus chers","Disposer d’un choix plus large de produits de ce type"),
                         c("Limiter les conséquences du changement climatique","Laisser aux générations futures un environnement de qualité","Protéger ma santé et celle de mes proches","Préserver la nature, les espèces animales et végétales","Aucune de ces raisons"),
                         c("Vous en faites déjà beaucoup","Vous pourriez en faire davantage","Vous faites le plus que vous pouvez","Vous ne pensez pas qu’il est vraiment utile d’agir individuellement"),
                         c("Vous considérez que chacun doit s’investir le plus possible","Vous n’avez pas les moyens d’agir à votre niveau","Vous ne disposez pas d’informations qui vous inciteraient à en faire davantage","Vous pensez que les problèmes environnementaux sont exagérés","Aucune de ces opinions")
)

Reponses_archives = list(c("Oui","Non"),
                         c("Oui","Non"),
                         c("Une voiture ou un véhicule utilitaire exclusivement","Une moto, un scooter ou un autre deux-roues motorisé exclusivement","Un véhicule personnel (voiture ou deux roues) et un ou plusieurs transports en commun","Un vélo et un ou plusieurs transports en commun","Un ou plusieurs transports en commun exclusivement","Un vélo exclusivement","La marche à pied","C’est trop variable pour répondre"))

## fin de la modification


# Already inside server
output$pageStub <- renderUI(fluidPage(tags$div(class='fr-container fr-py-16v',
  
  # Application title
  #titlePanel(""),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      #affichage de la selection Serie/Annee en cours
      uiOutput("ui_first"),
      
      #Affichage de la selection du theme pour l'annee
      conditionalPanel(
        condition = "input.choice_1 == '1'",
        uiOutput("chthem_ann")),
      
      #Affichage de la selection des questions pour l'annee en cours
      conditionalPanel(
        condition = "input.choice_1 == '1'",
        uiOutput("annee")),
      
      #Affichage de la selection du theme pour la serie
      conditionalPanel(
        condition = "input.choice_1 == '2'",
        uiOutput("chthem")),
      
      #Affichage de la selection du choix de la question pour la serie
      conditionalPanel(
        condition = "input.choice_1 == '2'",
        uiOutput("serie")),
      
      #Affichage de la selection de la reponse 
      conditionalPanel(
        condition = "(input.choice_1 == 2 & !output.cond )",
        uiOutput("reponse")),
      
      #Affichage de la selectiion de la variable 
      conditionalPanel(
        condition = "input.choice_1 == 1 | input.rep != 'Global' | output.cond ",
        uiOutput("var")),
      
      #Affichage des coches pour les variables
      conditionalPanel(
        condition = "(input.choice_1 ==1 & input.vari != '1') | (input.vari != '1' & ((input.rep != 'Global')^output.cond))",
        uiOutput("BoxVar"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      cat("lancement graphique"),
      navbarPage("",
        id = "navMenu",selected = "Graphiques",
        tabPanel("Graphiques",
                 plotlyOutput(outputId = "graphique",width = "100%",height = "500px"),
      #Affichage des coches pour les reponses
      conditionalPanel(condition = "input.choice_1 == 2 & input.rep == 'Global' & !output.cond & output.cond2",uiOutput("BoxReponse"))
                 ),
      #creation de l'onglet tableau
      tabPanel("Tableaux",dataTableOutput("table_out"))
          )
    )
  )), includeHTML("user/messcripts_home.Rhtml") 
))