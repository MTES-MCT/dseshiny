

#Suppresion de quelques fontionnélité plotly
plotlyRemove <- c('sendDataToCloud','hoverCompareCartesian',
                  'hoverClosestCartesian',
                  'select2d', 'lasso2d',
                  'resetScale2d', 
                  'autoScale2d',
                  'zoomIn2d', 'zoomOut2d',
                  'zoom2d', 'pan2d')

### Creation des menus deroulants 
#Choix de annee en cours ou synthese des annees precedentes
output$ui_first <- renderUI({
  selectInput(inputId = "choice_1", label = "Série / Année en cours", 
              choices = c("Année en cours (2021)"="1","Série"="2"), selected = 2)
})

#Choix thématique pour la serie
output$chthem <- renderUI({
  selectInput(inputId = "select_them",
              label = "Choix du thème",
              choices = c("Préoccupations"="1", "Logement et énergie"="2", "Transport"="3", "Consommation"="4", "Opinions"="5", "*Archives*"="6"),
              selected = "1") 
})

#choix thematique pour l'annee
output$chthem_ann <- renderUI({
  selectInput(inputId = "select_them_ann",
              label = "Choix du thème",
              choices = c("Préoccupations"="1", "Logement et énergie"="2", "Transport"="3", "Consommation"="4", "Opinions"="5"),
              selected = "1")
})

#recuperation des question concerné pour la serie
Question <- reactive(
  model <- tryCatch(
    {
      model<-switch(req(input$select_them),
                    "1" = Questions_Preocupation,
                    "2" = Questions_Logement,
                    "3" = Questions_Transport,
                    "4" = Questions_Consomation,
                    "5" = Questions_Opinion,
                    "6" = Questions_Archives,
      )
    }
  )
)

#recuperation des question pour l'annee
Question_ann <- reactive(
  model <- tryCatch(
    {
      model<-switch(req(input$select_them_ann),
                    "1" = Annee_Preocupation,
                    "2" = Annee_Logement,
                    "3" = Annee_Transport,
                    "4" = Annee_Consomation,
                    "5" = Annee_Opinion,
      )
    }
  )
)


#Choix des questions Serie
output$serie <- renderUI({
  selectInput(inputId = "quest_ser",
              label = "Questions",
              choices = Question(),
              selected = Question()[1])
})

#Choix des questions Annee
output$annee <- renderUI({
  selectInput(inputId = "quest_ann",
              label = "Questions",
              choices = Question_ann(),
              selected = Question_ann()[1])
})


#recup des reponses possible pour la serie
posib_reponse <- reactive(
  list <- tryCatch({
    Y=strsplit(as.character(req(input$quest_ser)),split = "")
    if (Y[[1]][1]=="Q"){
      if (length(Y[[1]])==3){rep=Reponses_question[[as.integer(Y[[1]][2])*10 +as.integer(Y[[1]][3])]]}
      else {rep=Reponses_question[[as.integer(Y[[1]][2])]]}} 
    else{rep=Reponses_archives[[as.integer(Y[[1]][2])]]}
    list <- c("Global",rep)
  }
  )
)

#recup des reponses possible pour l'annee en cours 
posib_reponse_ann <- reactive(
  list <- tryCatch({
    Y=strsplit(as.character(req(input$quest_ann)),split = "")
    if (Y[[1]][1]=="Q"){
      if (length(Y[[1]])==3){rep=Reponses_question[[as.integer(Y[[1]][2])*10 +as.integer(Y[[1]][3])]]}
      else {rep=Reponses_question[[as.integer(Y[[1]][2])]]}} 
    else{rep=Reponses_archives[[as.integer(Y[[1]][2])]]}
    list <- c("Synthèse",rep)
  }
  )
)

#creation des annotations pour les graphiques
leg <- reactive({
  name <- tryCatch({
    #Pour la serie 
    if (input$quest_ser=="Q2" & input$choice_1==2){name=paste("<B>Note de lecture :</B>","En 2021, 29.1% des enquêtés déclarent que le réchauffement de la planète est une de leur deux principales préoccupations. \n")}
    else if ((input$quest_ser=="Q4") & (input$choice_1==2)){name=paste("<B>Note de lecture :</B>","En 2021, 13.9% des enquêtés déclarent que le bruit est un des deux problèmes qui les concernent le plus dans leur quartier.\n")}
    else if ((input$quest_ser=="Q5") & (input$choice_1==2)){name=paste("<B>Note de lecture :</B>","Le graphique ne represente pas les personnes qui ne sont pas concerné (entre 32% et 39% selon les années). \n")}
    else if ((input$quest_ser=="Q7") & (input$choice_1==2)){name=paste("<B>Note de lecture :</B>","Le graphique ne represente pas les personnes qui ne sont pas concerné (entre 11% et 14% selon les années). \n")}
    else if ((sum(input$quest_ser==Question_OuiNon)==1) & (input$choice_1==2)){name=paste("<B>Note :</B>","Le graphique présente exclusivement la part des réponses 'Oui'\n")}
    #Pour l'annee en cours
    else if ((input$quest_ann=="Q2") & (input$choice_1==1)){name=paste("<B>Note de lecture :</B>","En 2021, 29.1% des enquêtés déclarent que le réchauffement de la planète est une de leur deux principales préoccupations. \n")}
    else if ((input$quest_ann=="Q4") & (input$choice_1==1)){name=paste("<B>Note de lecture :</B>","En 2021, 13.9% des enquêtés déclarent que le bruit est un des deux problèmes qui les concernent le plus dans leur quartier.\n")}
    else if ((input$quest_ann=="Q5") & (input$choice_1==1)){name=paste("<B>Note de lecture :</B>","Le graphique ne represente pas les personnes qui ne sont pas concerné (entre 32% et 39% selon les années). \n")}
    else if ((input$quest_ann=="Q7") & (input$choice_1==1)){name=paste("<B>Note de lecture :</B>","Le graphique ne represente pas les personnes qui ne sont pas concerné (entre 11% et 14% selon les années). \n")}
    else{name=""}
  },
  error = function(e){
    name <-  ""
  })
  if (req(input$choice_1)==2){Srce=Srce_ser;name<-paste(name, Srce,sep="")}
  else{Srce=Srce_ann;name<-paste(paste("<B>Note :</B>","Valeurs en %\n"),name, Srce,sep="")}
  
})

#Changement des couleur des graphiques
couleur <- reactive(
  list <- tryCatch({
    if (length(posib_reponse())==5 & req(input$choice_1)==2 & input$rep==posib_reponse()[1]){list <- couleurs[c(4,3,2,1)]}
    else {list <- couleurs}
  },
  error = function(e){
    list <- couleurs
  })
  
)


#Choix de la réponse (pour question a choix multiples)
output$reponse <- renderUI({
  selectInput(inputId = "rep",
              label = "Réponses",
              choices = posib_reponse(),
              selected = posib_reponse()[1])
})

#option d'affichage des réponses
output$BoxReponse <- renderUI({
  checkboxGroupInput(inputId = "disprep",
                     label = "",
                     choices = posib_reponse()[2:length(posib_reponse())],
                     selected = posib_reponse()[if(sum(input$quest_ser==Question_Aucun)==0){2:length(posib_reponse())}else{2:(length(posib_reponse())-1)}],
                     inline = FALSE)
})



#Choix des variables
output$var <- renderUI({
  selectInput(inputId = "vari",
              label = "Variables",
              choices = Variable,
              selected = "1")
})

#Récupération du nom des variables
Name_Variable <- reactive(
  model <- tryCatch(
    {
      model<-switch(req(input$vari),
                    "2" = Name_Genre,
                    "3" = Name_Age,
                    "4" = Name_TU,
                    "5" = Name_NivEtud,
                    "6" = Name_Niv_Vie,
                    "7" = Name_CS,
      )
    },
    error = function(e){
      model <- Name_Genre
    }
  )
)

#affichage des coches pour afficher les différentes courbes
output$BoxVar <- renderUI({
  checkboxGroupInput(inputId = "dispvari",
                     label = "",
                     choices = Name_Variable(),
                     selected = Name_Variable())
})

#condition pour les conditionalPanel
output$cond <- reactive({sum(req(input$quest_ser)==Question_OuiNon)==1})
outputOptions(output, "cond", suspendWhenHidden = FALSE)

output$cond2 <- reactive({length(row.names(Table()))>0})
outputOptions(output, "cond2", suspendWhenHidden = FALSE)

#observeEvent(input$quest_ann, {print(as.character(match(input$quest_ann,Question_ann())))})



variable_choix <- reactive(req(input$choice_1))
choix_vari_affichage <- reactive(req(input$dispvari))
choix_rep_affichage <- reactive(req(input$disprep))

### mise à jour de certains select afin d'avoir un retour à la valeur par défaut
#mise à jour lorsqu'on change de question pour revenir à la synthèse des variables
observeEvent(input$quest_ser, {updateSelectInput(session,inputId = "vari",
                                                 choices = Variable,
                                                 selected = "1")})

#mise à jour pour quand on change de question, les réponse revienne à 'global'
observeEvent(input$quest_ser, {updateSelectInput(session,inputId = "rep",
                                                 choices = posib_reponse(),
                                                 selected = posib_reponse()[1])})

#mise a jour pour les variable, retour à synthese quand on change de réponse
observeEvent(input$rep, {if (input$rep==1){updateSelectInput(session,inputId = "vari",
                                                             choices = Variable,
                                                             selected = "1")}})

#mise a jour pour retour a synthèse des variables pour le changement de quenstion pour l'annee en cours
observeEvent(input$quest_ann, {updateSelectInput(session,inputId = "vari",
                                                 choices = Variable,
                                                 selected = "1")})

#mise a jour des variables lorsqu'on change entre annee en cours et serie
observeEvent(input$choice_1, {updateSelectInput(session,inputId = "vari",
                                                choices = Variable,
                                                selected = "1")})

#Mise a jour des reponses lorsque on change entre annee en cours et serie
observeEvent(input$choice_1, {updateSelectInput(session,inputId = "rep",
                                                choices = posib_reponse(),
                                                selected = posib_reponse()[1])})

#tentative de conserver le thème et la question lors de la bascule entre serie et annee en cours
# observeEvent(ignoreInit = TRUE,input$choice_1, {updateSelectInput(session,inputId = "select_them",
#                                                 choices = c("Préoccupations"="1", "Logement et énergie"="2", "Transport"="3", "Consommation"="4", "Opinions"="5", "*Archives*"="6"),
#                                                 selected = input$select_them_ann)})
# 
# event_trigger <- reactive({list(input$choice_1, input$select_them)})
# 
# observeEvent(ignoreInit = TRUE, {input$choice_1 
#   input$select_them}, {updateSelectInput(session,inputId = "quest_ser",
#                                                 choices = Question(),
#                                                 selected =  Question()[match(input$quest_ann,Question())])})
# 
# 
# observeEvent(input$quest_ser, {print(event_trigger())})


#Recup du titre pour la serie
titre <- reactive({
  Y=strsplit(as.character(req(input$quest_ser)),split = "")
  if (Y[[1]][1]=="Q"){
    if (length(Y[[1]])==3){titre=Name_Question[as.integer(Y[[1]][2])*10 +as.integer(Y[[1]][3])]}
    else {titre=Name_Question[as.integer(Y[[1]][2])]}
  } else{titre=Name_Archive[as.integer(Y[[1]][2])]}
  return(titre)
})

#Recup titre annee en cours
titre_ann <- reactive({
  Y=strsplit(as.character(req(input$quest_ann)),split = "")
  if (Y[[1]][1]=="Q"){
    if (length(Y[[1]])==3){titre=Name_Question[as.integer(Y[[1]][2])*10 +as.integer(Y[[1]][3])]}
    else {titre=Name_Question[as.integer(Y[[1]][2])]}
  } else{titre=Name_Archive[as.integer(Y[[1]][2])]}
  return(titre)
})


##### Création de la table pour affichage #####
Table <- reactive({
  if (exists("CS")){detach(data);rm(data)}
  
  if (req(input$choice_1)==2){#partie pour la serie
    if (xor(sum(Question_OuiNon==req(input$quest_ser))==1,req(input$rep)!=posib_reponse()[1])){ #Partie pour les question Oui/Non ou quand on choisie une réponse 
      if (sum(Question_OuiNon==req(input$quest_ser))==1){QuestionTag = 1}
      else{QuestionTag = match(req(input$rep),posib_reponse())-1}
      if (req(input$vari)==1 & !is.na(QuestionTag)){ #synthese
        Tot=c()
        for (i in 1:Taille){
          load(file = file.path(getwd(),"donnees_r",donnees[i]))  #chargement des donnees
          attach(data)
          s=req(input$quest_ser)
          #rajout au vecteur des donn?es
          if (exists(input$quest_ser)){
            #traitement particulier pour les questions 2 et 4
            if (input$quest_ser=="Q2"){Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q1"]==QuestionTag])*sum(iweight[Q1<8])+sum(iweight[data[colnames(data)=="Q2"]==QuestionTag])*length(iweight))*100)/(length(iweight)*sum(iweight[Q1<8])))}
            else if (input$quest_ser=="Q4"){Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q3"]==QuestionTag])+sum(iweight[data[colnames(data)=="Q4"]==QuestionTag]))*100)/(length(iweight)+sum(iweight[Q3<8])))}
            #traitement pour les autres réponses
            else{Tot=c(Tot, (sum(iweight[data[colnames(data)==input$quest_ser]==QuestionTag])*100)/length(iweight))}}
          else{Tot=c(Tot,NA)}
          #supression de data pour eviter les erreurs
          detach(data)
          rm(data)
        }#fin for
        #fin du traitement et creation du data frame
        A=as.character(2009:(2009+Taille-1))
        A=A[is.na(Tot)==FALSE]
        Tot=Tot[is.na(Tot)==FALSE]
        return(data.frame(A,Tot=round(Tot, digits = dig)))
      }#fin synthese
      
      if (input$vari==2){ #Genre
        #initialisation
        TotHom=c()
        TotFem=c()
        for (i in 1:Taille){
          load(file = file.path(getwd(),"donnees_r",donnees[i]))  #chargement des donnees
          attach(data)
          #rajout au vecteur des donnees
          if (exists(input$quest_ser)){
            #traitement des donnees pour les questions 2 et 4
            if (input$quest_ser=="Q2"){
              TotHom=c(TotHom, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(Sexe==1)])*sum(iweight[(Sexe==1)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(Sexe==1)])*sum(iweight[Sexe==1]))*100)/(sum(iweight[Sexe==1])*sum(iweight[(Sexe==1)&(Q1<8)])))
              TotFem=c(TotFem, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(Sexe==2)])*sum(iweight[(Sexe==2)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(Sexe==2)])*sum(iweight[Sexe==2]))*100)/(sum(iweight[Sexe==2])*sum(iweight[(Sexe==2)&(Q1<8)])))
            }
            else if (input$quest_ser=="Q4"){
              TotHom=c(TotHom, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(Sexe==1)])+sum(iweight[(data[colnames(data)=="Q5"]==QuestionTag)&(Sexe==1)]))*100)/(sum(iweight[Sexe==1])+sum(iweight[(Sexe==1)&(Q3<8)])))
              TotFem=c(TotFem, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(Sexe==2)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(Sexe==2)]))*100)/(sum(iweight[Sexe==2])+sum(iweight[(Sexe==2)&(Q3<8)])))
            }
            else{ #traitement pour les autres questions
              TotHom=c(TotHom, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(Sexe==1)])*100)/sum(iweight[Sexe==1]))
              TotFem=c(TotFem, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(Sexe==2)])*100)/sum(iweight[Sexe==2]))}}
          else{TotHom=c(TotHom,NA);TotFem=c(TotFem,NA)}
          #supression pour passage a la suite
          detach(data)
          rm(data)
        }#fin for
        #fin du traitment et creation du data frame
        A=as.character(2009:(2009+Taille-1))
        A=A[is.na(TotHom)==FALSE]
        TotFem=TotFem[is.na(TotHom)==FALSE]
        TotHom=TotHom[is.na(TotHom)==FALSE]
        return(data.frame(A,TotHom=round(TotHom,digits = dig),TotFem=round(TotFem, digits = dig)))
      }#fin genre
      
      if (input$vari==3){ #Age
        #initialisation
        Totjeune=c()
        Totmoyen=c()
        Totvieux=c()
        for (i in 1:Taille){
          load(file = file.path(getwd(),"donnees_r",donnees[i]))  #chargement des donnees
          attach(data)
          #rajout au vecteur des donnees
          if (exists(input$quest_ser)){
            #Traitement pour les questions 2 à 4
            if (input$quest_ser=="Q2"){
              Totjeune=c(Totjeune, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(Dage<age1)])*sum(iweight[(Dage<age1)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(Dage<age1)])*sum(iweight[Dage<age1]))*100)/(sum(iweight[Dage<age1])*sum(iweight[(Dage<age1)&(Q1<8)])))
              Totmoyen=c(Totmoyen, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&((Dage>=age1)&(Dage<age2))])*sum(iweight[((Dage>=age1)&(Dage<age2))&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(Dage<age1)])*sum(iweight[(Dage>=age1)&(Dage<age2)]))*100)/(sum(iweight[(Dage>=age1)&(Dage<age2)])*sum(iweight[((Dage>=age1)&(Dage<age2))&(Q1<8)])))
              Totvieux=c(Totvieux, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(Dage>=age2)])*sum(iweight[(Dage>age2)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(Dage<age1)])*sum(iweight[Dage>age2]))*100)/(sum(iweight[Dage>age2])*sum(iweight[(Dage>age2)&(Q1<8)])))
            }
            else if (input$quest_ser=="Q4"){
              Totjeune=c(Totjeune, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(Dage<age1)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(Dage<age1)]))*100)/(sum(iweight[Dage<age1])+sum(iweight[(Dage<age1)&(Q3<8)])))
              Totmoyen=c(Totmoyen, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&((Dage>=age1)&(Dage<age2))])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(Dage<age1)]))*100)/(sum(iweight[(Dage>=age1)&(Dage<age2)])+sum(iweight[((Dage>=age1)&(Dage<age2))&(Q3<8)])))
              Totvieux=c(Totvieux, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(Dage>=age2)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(Dage<age1)]))*100)/(sum(iweight[Dage>age2])+sum(iweight[(Dage>age2)&(Q3<8)])))
            }
            else{ #traitement pour les autres questions
              Totjeune=c(Totjeune, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(Dage<age1)])*100)/sum(iweight[Dage<age1]))
              Totmoyen=c(Totmoyen, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&((Dage>=age1)&(Dage<age2))])*100)/sum(iweight[(Dage>=age1)&(Dage<age2)]))
              Totvieux=c(Totvieux, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(Dage>=age2)])*100)/sum(iweight[Dage>age2]))}}
          else{Totjeune=c(Totjeune,NA);Totmoyen=c(Totmoyen,NA);Totvieux=c(Totvieux,NA)}
          #supression pour passage a la suite
          detach(data)
          rm(data)
        }#fin for
        #fin du traitment et creation du data frame
        A=as.character(2009:(2009+Taille-1))
        A=A[is.na(Totvieux)==FALSE]
        Totjeune=Totjeune[is.na(Totvieux)==FALSE]
        Totmoyen=Totmoyen[is.na(Totvieux)==FALSE]
        Totvieux=Totvieux[is.na(Totvieux)==FALSE]
        return(data.frame(A,Totjeune=round(Totjeune,digits = dig),Totmoyen=round(Totmoyen, digits = dig),Totvieux=round(Totvieux,digits = dig)))
      }#fin age
      
      if (input$vari==4){ #TU
        #initialisation 
        Totparis=c()
        Totplus=c()
        Totmoins=c()
        Totrural=c()
        for (i in 1:Taille){
          load(file = file.path(getwd(),"donnees_r",donnees[i]))  #chargement des donnees
          attach(data)
          #rajout au vecteur des donnees
          if (exists(input$quest_ser)){
            #Traitement pour les questions 2 et 4
            if (input$quest_ser=="Q2"){
              Totparis=c(Totparis, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(TU==1)])*sum(iweight[(TU==1)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(TU==1)])*sum(iweight[TU==1]))*100)/(sum(iweight[TU==1])*sum(iweight[(TU==1)&(Q1<8)])))
              Totplus=c(Totplus, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(TU==2)])*sum(iweight[(TU==2)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(TU==2)])*sum(iweight[TU==2]))*100)/(sum(iweight[TU==2])*sum(iweight[(TU==2)&(Q1<8)])))
              Totmoins=c(Totmoins, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(TU==3)])*sum(iweight[(TU==3)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(TU==3)])*sum(iweight[TU==3]))*100)/(sum(iweight[TU==3])*sum(iweight[(TU==3)&(Q1<8)])))
              Totrural=c(Totrural, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(TU==4)])*sum(iweight[(TU==4)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(TU==4)])*sum(iweight[TU==4]))*100)/(sum(iweight[TU==4])*sum(iweight[(TU==4)&(Q1<8)])))
            }
            else if (input$quest_ser=="Q4"){
              Totparis=c(Totparis, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(TU==1)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(TU==1)]))*100)/(sum(iweight[TU==1])+sum(iweight[(TU==1)&(Q3<8)])))
              Totplus=c(Totplus, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(TU==2)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(TU==2)]))*100)/(sum(iweight[TU==2])+sum(iweight[(TU==2)&(Q3<8)])))
              Totmoins=c(Totmoins, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(TU==3)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(TU==3)]))*100)/(sum(iweight[TU==3])+sum(iweight[(TU==3)&(Q3<8)])))
              Totrural=c(Totrural, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(TU==4)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(TU==4)]))*100)/(sum(iweight[TU==4])+sum(iweight[(TU==4)&(Q3<8)])))
            }
            else{ #traitement pour les autres questions
              Totparis=c(Totparis, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(TU==1)])*100)/sum(iweight[TU==1]))
              Totplus=c(Totplus, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(TU==2)])*100)/sum(iweight[TU==2]))
              Totmoins=c(Totmoins, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(TU==3)])*100)/sum(iweight[TU==3]))
              Totrural=c(Totrural, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(TU==4)])*100)/sum(iweight[TU==4]))}}
          else{Totparis=c(Totparis,NA);Totplus=c(Totplus,NA);Totmoins=c(Totmoins,NA);Totrural=c(Totrural,NA)}
          #supression pour passage a la suite
          detach(data)
          rm(data)
        }#fin for
        #fin de traitement et creation du data frame
        A=as.character(2009:(2009+Taille-1))
        A=A[is.na(Totparis)==FALSE]
        Totrural=Totrural[is.na(Totparis)==FALSE]
        Totmoins=Totmoins[is.na(Totparis)==FALSE]
        Totplus=Totplus[is.na(Totparis)==FALSE]
        Totparis=Totparis[is.na(Totparis)==FALSE]
        return(data.frame(A,Totparis=round(Totparis,digits = dig),Totplus=round(Totplus,digits = dig),Totmoins=round(Totmoins, digits = dig),Totrural=round(Totrural, digits = dig)))
      }#fin TU
      
      if (input$vari==5){#Niv d'etude
        #initialisation
        Totprimaire=c()
        Totcollege=c()
        Totbac=c()
        Totsuperieur=c()
        for (i in 1:Taille){
          load(file = file.path(getwd(),"donnees_r",donnees[i]))  #chargement des donnees
          attach(data)
          #rajout au vecteur des donnees
          if (exists(input$quest_ser)){
            #traitment pour les questions 2 et 4
            if (input$quest_ser=="Q2"){
              Totprimaire=c(Totprimaire, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(NivEtud==1)])*sum(iweight[(NivEtud==1)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(NivEtud==1)])*sum(iweight[NivEtud==1]))*100)/(sum(iweight[NivEtud==1])*sum(iweight[(NivEtud==1)&(Q1<8)])))
              Totcollege=c(Totcollege, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(NivEtud==2)])*sum(iweight[(NivEtud==2)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(NivEtud==2)])*sum(iweight[NivEtud==2]))*100)/(sum(iweight[NivEtud==2])*sum(iweight[(NivEtud==2)&(Q1<8)])))
              Totbac=c(Totbac, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(NivEtud==3)])*sum(iweight[(NivEtud==3)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(NivEtud==3)])*sum(iweight[NivEtud==3]))*100)/(sum(iweight[NivEtud==3])*sum(iweight[(NivEtud==3)&(Q1<8)])))
              Totsuperieur=c(Totsuperieur, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(NivEtud==4)])*sum(iweight[(NivEtud==4)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(NivEtud==4)])*sum(iweight[NivEtud==4]))*100)/(sum(iweight[NivEtud==4])*sum(iweight[(NivEtud==4)&(Q1<8)])))
            }
            else if (input$quest_ser=="Q4"){
              Totprimaire=c(Totprimaire, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(NivEtud==1)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(NivEtud==1)]))*100)/(sum(iweight[NivEtud==1])+sum(iweight[(NivEtud==1)&(Q3<8)])))
              Totcollege=c(Totcollege, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(NivEtud==2)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(NivEtud==2)]))*100)/(sum(iweight[NivEtud==2])+sum(iweight[(NivEtud==2)&(Q3<8)])))
              Totbac=c(Totbac, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(NivEtud==3)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(NivEtud==3)]))*100)/(sum(iweight[NivEtud==3])+sum(iweight[(NivEtud==3)&(Q3<8)])))
              Totsuperieur=c(Totsuperieur, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(NivEtud==4)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(NivEtud==4)]))*100)/(sum(iweight[NivEtud==4])+sum(iweight[(NivEtud==4)&(Q3<8)])))
            }
            else{#traitement pour les autres questions
              Totprimaire=c(Totprimaire, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(NivEtud==1)])*100)/sum(iweight[NivEtud==1]))
              Totcollege=c(Totcollege, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(NivEtud==2)])*100)/sum(iweight[NivEtud==2]))
              Totbac=c(Totbac, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(NivEtud==3)])*100)/sum(iweight[NivEtud==3]))
              Totsuperieur=c(Totsuperieur, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(NivEtud==4)])*100)/sum(iweight[NivEtud==4]))}}
          else{Totprimaire=c(Totprimaire,NA);Totcollege=c(Totcollege,NA);Totbac=c(Totbac,NA);Totsuperieur=c(Totsuperieur,NA)}
          #supression pour passage a la suite
          detach(data)
          rm(data)
        }#fin for
        #fin traitement et creation du data frame
        A=as.character(2009:(2009+Taille-1))
        A=A[is.na(Totsuperieur)==FALSE]
        Totprimaire=Totprimaire[is.na(Totsuperieur)==FALSE]
        Totcollege=Totcollege[is.na(Totsuperieur)==FALSE]
        Totbac=Totbac[is.na(Totsuperieur)==FALSE]
        Totsuperieur=Totsuperieur[is.na(Totsuperieur)==FALSE]
        return(data.frame(A,Totprimaire=round(Totprimaire, digits = dig),Totcollege=round(Totcollege, digits = dig),Totbac=round(Totbac, digits = dig),Totsuperieur=round(Totsuperieur, digits = dig)))
      }#fin niv etude
      
      if (input$vari==6){#Niv de vie
        #inititalisation 
        TotQ1=c()
        TotQ2=c()
        TotQ3=c()
        TotQ4=c()
        TotQ5=c()
        for (i in 1:Taille){
          load(file = file.path(getwd(),"donnees_r",donnees[i]))  #chargement des donnees
          attach(data)
          #rajout au vecteur des donnees
          if (exists(input$quest_ser)){
            #Traitement des donnees pour les question 2 et 4
            if (input$quest_ser=="Q2"){
              TotQ1=c(TotQ1, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(Niv_vie<Quintiles[2])])*sum(iweight[(Niv_vie<Quintiles[2])&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(Niv_vie<Quintiles[2])])*sum(iweight[Niv_vie<Quintiles[2]]))*100)/(sum(iweight[Niv_vie<Quintiles[2]])*sum(iweight[(Niv_vie<Quintiles[2])&(Q1<8)])))
              TotQ2=c(TotQ2, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))])*sum(iweight[((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))])*sum(iweight[(Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3])]))*100)/(sum(iweight[(Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3])])*sum(iweight[((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))&(Q1<8)])))
              TotQ3=c(TotQ3, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))])*sum(iweight[((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))])*sum(iweight[(Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4])]))*100)/(sum(iweight[(Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4])])*sum(iweight[((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))&(Q1<8)])))
              TotQ4=c(TotQ4, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))])*sum(iweight[((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))])*sum(iweight[(Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5])]))*100)/(sum(iweight[(Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5])])*sum(iweight[((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))&(Q1<8)])))
              TotQ5=c(TotQ5, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(Niv_vie>=Quintiles[5])])*sum(iweight[(Niv_vie>=Quintiles[5])&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(Niv_vie>=Quintiles[5])])*sum(iweight[Niv_vie>=Quintiles[5]]))*100)/(sum(iweight[Niv_vie>=Quintiles[5]])*sum(iweight[(Niv_vie>=Quintiles[5])&(Q1<8)])))
            }
            else if (input$quest_ser=="Q4"){
              TotQ1=c(TotQ1, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(Niv_vie<Quintiles[2])])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(Niv_vie<Quintiles[2])]))*100)/(sum(iweight[Niv_vie<Quintiles[2]])+sum(iweight[(Niv_vie<Quintiles[2])&(Q3<8)])))
              TotQ2=c(TotQ2, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))]))*100)/(sum(iweight[(Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3])])+sum(iweight[((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))&(Q3<8)])))
              TotQ3=c(TotQ3, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))]))*100)/(sum(iweight[(Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4])])+sum(iweight[((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))&(Q3<8)])))
              TotQ4=c(TotQ4, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))]))*100)/(sum(iweight[(Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5])])+sum(iweight[((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))&(Q3<8)])))
              TotQ5=c(TotQ5, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(Niv_vie>=Quintiles[5])])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(Niv_vie>=Quintiles[5])]))*100)/(sum(iweight[Niv_vie>=Quintiles[5]]))+sum(iweight[(Niv_vie>=Quintiles[5])&(Q3<8)]))
            }
            else{ #Traitement pour les autres questions 
              TotQ1=c(TotQ1, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(Niv_vie<Quintiles[2])])*100)/sum(iweight[Niv_vie<Quintiles[2]]))
              TotQ2=c(TotQ2, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))])*100)/sum(iweight[(Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3])]))
              TotQ3=c(TotQ3, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))])*100)/sum(iweight[(Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4])]))
              TotQ4=c(TotQ4, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))])*100)/sum(iweight[(Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5])]))
              TotQ5=c(TotQ5, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(Niv_vie>=Quintiles[5])])*100)/sum(iweight[Niv_vie>=Quintiles[5]]))}}
          else{TotQ1=c(TotQ1,NA);TotQ2=c(TotQ2,NA);TotQ3=c(TotQ3,NA);TotQ4=c(TotQ4,NA);TotQ5=c(TotQ5,NA)}
          #supression pour passage a la suite
          detach(data)
          rm(data)
        }#fin for
        #fin du traitement et creation du data frame
        A=as.character(2009:(2009+Taille-1))
        A=A[is.na(TotQ5)==FALSE]
        TotQ1=TotQ1[is.na(TotQ5)==FALSE]
        TotQ2=TotQ2[is.na(TotQ5)==FALSE]
        TotQ3=TotQ3[is.na(TotQ5)==FALSE]
        TotQ4=TotQ4[is.na(TotQ5)==FALSE]
        TotQ5=TotQ5[is.na(TotQ5)==FALSE]
        return(data.frame(A,TotQ1=round(TotQ1, digits = dig),TotQ2=round(TotQ2,digits = dig),TotQ3=round(TotQ3,digits = dig),TotQ4=round(TotQ4, digits = dig),TotQ5=round(TotQ5, digits = dig)))
      }#Niv de vie
      
      if (input$vari==7){#Cat socio
        #inititalisation
        Totcs1=c()
        Totcs2=c()
        Totcs3=c()
        Totcs4=c()
        Totcs5=c()
        Totcs6=c()
        for (i in 1:Taille){
          load(file = file.path(getwd(),"donnees_r",donnees[i]))  #chargement des donn?es
          attach(data)
          #rajout au vecteur des donn?es
          if (exists(input$quest_ser)){
            #Traitement pour les questions 2 et 4
            if (input$quest_ser=="Q2"){
              Totcs1=c(Totcs1, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(CS==1)])*sum(iweight[(CS==1)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(CS==1)])*sum(iweight[CS==1]))*100)/(sum(iweight[CS==1])*sum(iweight[(CS==1)&(Q1<8)])))
              Totcs2=c(Totcs2, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(CS==2)])*sum(iweight[(CS==2)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(CS==2)])*sum(iweight[CS==2]))*100)/(sum(iweight[CS==2])*sum(iweight[(CS==2)&(Q1<8)])))
              Totcs3=c(Totcs3, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(CS==3)])*sum(iweight[(CS==3)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(CS==3)])*sum(iweight[CS==3]))*100)/(sum(iweight[CS==3])*sum(iweight[(CS==3)&(Q1<8)])))
              Totcs4=c(Totcs4, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(CS==4)])*sum(iweight[(CS==4)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(CS==4)])*sum(iweight[CS==4]))*100)/(sum(iweight[CS==4])*sum(iweight[(CS==4)&(Q1<8)])))
              Totcs5=c(Totcs5, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(CS==5)])*sum(iweight[(CS==5)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(CS==5)])*sum(iweight[CS==5]))*100)/(sum(iweight[CS==5])*sum(iweight[(CS==5)&(Q1<8)])))
              Totcs6=c(Totcs6, ((sum(iweight[(data[colnames(data)=="Q1"]==QuestionTag)&(CS==6)])*sum(iweight[(CS==6)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==QuestionTag)&(CS==6)])*sum(iweight[CS==6]))*100)/(sum(iweight[CS==6])*sum(iweight[(CS==6)&(Q1<8)])))
            }
            else if (input$quest_ser=="Q4"){
              Totcs1=c(Totcs1, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(CS==1)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(CS==1)]))*100)/(sum(iweight[CS==1])+sum(iweight[(CS==1)&(Q3<8)])))
              Totcs2=c(Totcs2, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(CS==2)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(CS==2)]))*100)/(sum(iweight[CS==2])+sum(iweight[(CS==2)&(Q3<8)])))
              Totcs3=c(Totcs3, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(CS==3)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(CS==3)]))*100)/(sum(iweight[CS==3])+sum(iweight[(CS==3)&(Q3<8)])))
              Totcs4=c(Totcs4, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(CS==4)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(CS==4)]))*100)/(sum(iweight[CS==4])+sum(iweight[(CS==4)&(Q3<8)])))
              Totcs5=c(Totcs5, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(CS==5)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(CS==5)]))*100)/(sum(iweight[CS==5])+sum(iweight[(CS==5)&(Q3<8)])))
              Totcs6=c(Totcs6, ((sum(iweight[(data[colnames(data)=="Q3"]==QuestionTag)&(CS==6)])+sum(iweight[(data[colnames(data)=="Q4"]==QuestionTag)&(CS==6)]))*100)/(sum(iweight[CS==6])+sum(iweight[(CS==6)&(Q3<8)])))
            }
            else{#Traitement pour les autres questions
              Totcs1=c(Totcs1, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(CS==1)])*100)/sum(iweight[CS==1]))
              Totcs2=c(Totcs2, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(CS==2)])*100)/sum(iweight[CS==2]))
              Totcs3=c(Totcs3, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(CS==3)])*100)/sum(iweight[CS==3]))
              Totcs4=c(Totcs4, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(CS==4)])*100)/sum(iweight[CS==4]))
              Totcs5=c(Totcs5, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(CS==5)])*100)/sum(iweight[CS==5]))
              Totcs6=c(Totcs6, (sum(iweight[(data[colnames(data)==input$quest_ser]==QuestionTag)&(CS==6)])*100)/sum(iweight[CS==6]))}}
          else{Totcs1=c(Totcs1,NA);Totcs2=c(Totcs2,NA);Totcs3=c(Totcs3,NA);Totcs4=c(Totcs4,NA);Totcs5=c(Totcs5,NA);Totcs6=c(Totcs6,NA)}
          #supression pour passage a la suite
          detach(data)
          rm(data)
        }#fin for
        #fin du traitment et creation du data frame 
        A=as.character(2009:(2009+Taille-1))
        A=A[is.na(Totcs6)==FALSE]
        Totcs1=Totcs1[is.na(Totcs6)==FALSE]
        Totcs2=Totcs2[is.na(Totcs6)==FALSE]
        Totcs3=Totcs3[is.na(Totcs6)==FALSE]
        Totcs4=Totcs4[is.na(Totcs6)==FALSE]
        Totcs5=Totcs5[is.na(Totcs6)==FALSE]
        Totcs6=Totcs6[is.na(Totcs6)==FALSE]
        return(data.frame(A,Totcs1=round(Totcs1,digits = dig),Totcs2=round(Totcs2, digits = dig),Totcs3=round(Totcs3, digits = dig),Totcs4=round(Totcs4,digits = dig),Totcs5=round(Totcs5, digits = dig),Totcs6=round(Totcs6,digits = dig)))
      }#fin cat socio
      
    }#fin Oui Non
    
    else{#partie pour les questions a choix multiples
      if (input$rep==posib_reponse()[1]){
        QuestionTag=input$quest_ser
        for (t in 1:length(posib_reponse())){ #on parcours toute les reponse possible 
          Tot=c()
          for (i in 1:Taille){
            load(file = file.path(getwd(),"donnees_r",donnees[i]))  #chargement des donnees
            attach(data)
            #rajout au vecteur des donnees
            if (exists(QuestionTag)){
              if (input$quest_ser=="Q2"){Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q1"]==t])*sum(iweight[Q1<8])+sum(iweight[data[colnames(data)=="Q2"]==t])*length(iweight))*100)/(length(iweight)*sum(iweight[Q1<8])))}
              else if (input$quest_ser=="Q4"){Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q3"]==t])+sum(iweight[data[colnames(data)=="Q4"]==t]))*100)/(length(iweight)+sum(iweight[Q3<8])))}
              else{Tot=c(Tot, (sum(iweight[data[colnames(data)==QuestionTag]==t])*100)/length(iweight))}}
            else{Tot=c(Tot,0)}
            #supression pour passage a la suite
            detach(data)
            rm(data)
          }#fin for
          
          if (sum(Tot) != 0){
            Tot[Tot==0]=NA
            if (t==1){A=as.character(2009:(2009+Taille-1));secu=(is.na(Tot)==FALSE);A=A[secu];Tot=Tot[secu];frame=data.frame(A,round(Tot, digits = dig))}
            else{Tot=Tot[secu];frame=data.frame(frame,round(Tot, digits = dig))}
          }
        }#fin for
        return(frame)
      }#fin pour synthèse des questions à choix multiples
    }#fin pour les autres questions
    
  }#fin pour la série
  
  else{#Debut annee en cours 
    
    if (input$vari==1){ #Synthèse
      #import des donnees
      load(file = file.path(getwd(),"donnees_r",donnees[Taille]))
      attach(data)
      Tot=c()
      for (t in 1:(length(posib_reponse_ann())-1)){
        if (exists(input$quest_ann)){
          #Traitemennt pour les questions 2 et 4
          if (input$quest_ann=="Q2"){Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q1"]==t])*sum(iweight[Q1<8])+sum(iweight[data[colnames(data)=="Q2"]==t])*length(iweight))*100)/(length(iweight)*sum(iweight[Q1<8])))}
          else if (input$quest_ann=="Q4"){Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q3"]==t])+sum(iweight[data[colnames(data)=="Q4"]==t]))*100)/(length(iweight)+sum(iweight[Q3<8])))}
          #traitement pour les autres questions
          else{Tot=c(Tot, (sum(iweight[data[colnames(data)==input$quest_ann]==t])*100)/length(iweight))}}
        else{Tot=c(Tot,0)}
      }#fin for 
      #fin de traitement
      Tot[Tot==0]=NA
      Tot=Tot[is.na(Tot)==FALSE] 
      X=posib_reponse_ann()[2:length(posib_reponse_ann())]
      #chagement de l'ordre des reponses sauf pour les question jamais/.../toujours
      if (sum(input$quest_ann==Question_jost)==1){O=c(1,2,3,4)}
      else{O=order(Tot,decreasing = FALSE)}
      X=X[O]
      Tot=Tot[O]
      for (i in 1:length(X)){X[i]=paste(strwrap(X[i], width = 50), collapse = " \n ")}
      #creation du data frame
      frame=data.frame(X,Tot=round(Tot, digits = dig))
      frame$X=factor(frame$X, levels = frame[["X"]])
      detach(data)
      rm(data)
      return(frame)
    }#fin synthèse
    
    if (input$vari==2){ #Genre
      #import des donnees
      load(file = file.path(getwd(),"donnees_r",donnees[Taille]))
      attach(data)
      #initialisation
      TotHom=c()
      TotFem=c()
      Tot=c()
      for (t in 1:(length(posib_reponse_ann())-1)){
        if (exists(input$quest_ann)){
          #traitement pour les questions 2 et 4
          if (input$quest_ann=="Q2"){
            TotHom=c(TotHom, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(Sexe==1)])*sum(iweight[(Sexe==1)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(Sexe==1)])*sum(iweight[Sexe==1]))*100)/(sum(iweight[Sexe==1])*sum(iweight[(Sexe==1)&(Q1<8)])))
            TotFem=c(TotFem, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(Sexe==2)])*sum(iweight[(Sexe==2)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(Sexe==2)])*sum(iweight[Sexe==2]))*100)/(sum(iweight[Sexe==2])*sum(iweight[(Sexe==2)&(Q1<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q1"]==t])*sum(iweight[Q1<8])+sum(iweight[data[colnames(data)=="Q2"]==t])*length(iweight))*100)/(length(iweight)*sum(iweight[Q1<8])))
          }
          else if (input$quest_ann=="Q4"){
            TotHom=c(TotHom, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(Sexe==1)])+sum(iweight[(data[colnames(data)=="Q5"]==t)&(Sexe==1)]))*100)/(sum(iweight[Sexe==1])+sum(iweight[(Sexe==1)&(Q3<8)])))
            TotFem=c(TotFem, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(Sexe==2)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(Sexe==2)]))*100)/(sum(iweight[Sexe==2])+sum(iweight[(Sexe==2)&(Q3<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q3"]==t])+sum(iweight[data[colnames(data)=="Q4"]==t]))*100)/(length(iweight)+sum(iweight[Q3<8])))
          }
          else{ #traitement pour les autre questions
            TotHom=c(TotHom, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(Sexe==1)])*100)/sum(iweight[Sexe==1]))
            TotFem=c(TotFem, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(Sexe==2)])*100)/sum(iweight[Sexe==2]))
            Tot=c(Tot, (sum(iweight[data[colnames(data)==input$quest_ann]==t])*100)/length(iweight))}}
        else{TotHom=c(TotHom,NA);TotFem=c(TotFem,NA)}
      }#fin du for
      #fin du traitment 
      X=posib_reponse_ann()[2:length(posib_reponse_ann())]
      TotHom[TotHom==0]=NA
      TotFem[TotFem==0]=NA
      #changement de l'ordre
      if (sum(input$quest_ann==Question_jost)==1){O=c(1,2,3,4)}
      else{O=order(Tot,decreasing = FALSE)}
      X=X[O]
      TotHom=TotHom[O]
      TotFem=TotFem[O]
      for (i in 1:length(X)){X[i]=paste(strwrap(X[i], width = 50), collapse = " \n ")}
      detach(data)
      rm(data)
      #creation du data frame
      frame=data.frame(X,TotHom=round(TotHom, digits = dig),TotFem=round(TotFem,digits = dig))
      frame$X=factor(frame$X, levels = frame[["X"]])
      return(frame)
    }#fin pour genre
    
    if (input$vari==3){ #Age
      #import des donnees
      load(file = file.path(getwd(),"donnees_r",donnees[Taille]))
      attach(data)
      #initialisation
      Totjeune=c()
      Totmoyen=c()
      Totvieux=c()
      Tot=c()
      for (t in 1:(length(posib_reponse_ann())-1)){
        if (exists(input$quest_ann)){
          #Traitement des questions 2 et 4
          if (input$quest_ann=="Q2"){
            Totjeune=c(Totjeune, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(Dage<age1)])*sum(iweight[(Dage<age1)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(Dage<age1)])*sum(iweight[Dage<age1]))*100)/(sum(iweight[Dage<age1])*sum(iweight[(Dage<age1)&(Q1<8)])))
            Totmoyen=c(Totmoyen, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&((Dage>=age1)&(Dage<age2))])*sum(iweight[((Dage>=age1)&(Dage<age2))&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(Dage<age1)])*sum(iweight[(Dage>=age1)&(Dage<age2)]))*100)/(sum(iweight[(Dage>=age1)&(Dage<age2)])*sum(iweight[((Dage>=age1)&(Dage<age2))&(Q1<8)])))
            Totvieux=c(Totvieux, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(Dage>=age2)])*sum(iweight[(Dage>age2)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(Dage<age1)])*sum(iweight[Dage>age2]))*100)/(sum(iweight[Dage>age2])*sum(iweight[(Dage>age2)&(Q1<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q1"]==t])*sum(iweight[Q1<8])+sum(iweight[data[colnames(data)=="Q2"]==t])*length(iweight))*100)/(length(iweight)*sum(iweight[Q1<8])))
          }
          else if (input$quest_ann=="Q4"){
            Totjeune=c(Totjeune, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(Dage<age1)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(Dage<age1)]))*100)/(sum(iweight[Dage<age1])+sum(iweight[(Dage<age1)&(Q3<8)])))
            Totmoyen=c(Totmoyen, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&((Dage>=age1)&(Dage<age2))])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(Dage<age1)]))*100)/(sum(iweight[(Dage>=age1)&(Dage<age2)])+sum(iweight[((Dage>=age1)&(Dage<age2))&(Q3<8)])))
            Totvieux=c(Totvieux, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(Dage>=age2)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(Dage<age1)]))*100)/(sum(iweight[Dage>age2])+sum(iweight[(Dage>age2)&(Q3<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q3"]==t])+sum(iweight[data[colnames(data)=="Q4"]==t]))*100)/(length(iweight)+sum(iweight[Q3<8])))
          }
          else{#traitement pour les autres questions
            Totjeune=c(Totjeune, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(Dage<age1)])*100)/sum(iweight[Dage<age1]))
            Totmoyen=c(Totmoyen, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&((Dage>=age1)&(Dage<age2))])*100)/sum(iweight[(Dage>=age1)&(Dage<age2)]))
            Totvieux=c(Totvieux, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(Dage>=age2)])*100)/sum(iweight[Dage>age2]))
            Tot=c(Tot, (sum(iweight[data[colnames(data)==input$quest_ann]==t])*100)/length(iweight))}}
        else{Totjeune=c(Totjeune,NA);Totmoyen=c(Totmoyen,NA);Totvieux=c(Totvieux,NA)}
      }#fin for
      #fin du traitement
      Totjeune[Totjeune==0]=NA
      Totmoyen[Totmoyen==0]=NA
      Totvieux[Totvieux==0]=NA
      #changement de l'ordre
      if (sum(input$quest_ann==Question_jost)==1){O=c(1,2,3,4)}
      else{O=order(Tot,decreasing = FALSE)}
      X=posib_reponse_ann()[2:length(posib_reponse_ann())]
      X=X[O]
      Totjeune=Totjeune[O] 
      Totmoyen=Totmoyen[O] 
      Totvieux=Totvieux[O] 
      for (i in 1:length(X)){X[i]=paste(strwrap(X[i], width = 50), collapse = " \n ")}
      detach(data)
      rm(data)
      #creation du data frame
      frame=data.frame(X,Totjeune=round(Totjeune, digits = dig),Totmoyen=round(Totmoyen, digits = dig),Totvieux=round(Totvieux, digits = dig))
      frame$X=factor(frame$X, levels = frame[["X"]])
      return(frame)
    }#fin age
    
    if (input$vari==4){ #TU
      #import des donnees
      load(file = file.path(getwd(),"donnees_r",donnees[Taille]))
      attach(data)
      #initialisation
      Totparis=c()
      Totplus=c()
      Totmoins=c()
      Totrural=c()
      Tot=c()
      for (t in 1:(length(posib_reponse_ann())-1)){
        if (exists(input$quest_ann)){
          #Traitment des donnees pour les questions 2 et 4
          if (input$quest_ann=="Q2"){
            Totparis=c(Totparis, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(TU==1)])*sum(iweight[(TU==1)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(TU==1)])*sum(iweight[TU==1]))*100)/(sum(iweight[TU==1])*sum(iweight[(TU==1)&(Q1<8)])))
            Totplus=c(Totplus, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(TU==2)])*sum(iweight[(TU==2)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(TU==2)])*sum(iweight[TU==2]))*100)/(sum(iweight[TU==2])*sum(iweight[(TU==2)&(Q1<8)])))
            Totmoins=c(Totmoins, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(TU==3)])*sum(iweight[(TU==3)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(TU==3)])*sum(iweight[TU==3]))*100)/(sum(iweight[TU==3])*sum(iweight[(TU==3)&(Q1<8)])))
            Totrural=c(Totrural, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(TU==4)])*sum(iweight[(TU==4)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(TU==4)])*sum(iweight[TU==4]))*100)/(sum(iweight[TU==4])*sum(iweight[(TU==4)&(Q1<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q1"]==t])*sum(iweight[Q1<8])+sum(iweight[data[colnames(data)=="Q2"]==t])*length(iweight))*100)/(length(iweight)*sum(iweight[Q1<8])))
          }
          else if (input$quest_ann=="Q4"){
            Totparis=c(Totparis, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(TU==1)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(TU==1)]))*100)/(sum(iweight[TU==1])+sum(iweight[(TU==1)&(Q3<8)])))
            Totplus=c(Totplus, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(TU==2)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(TU==2)]))*100)/(sum(iweight[TU==2])+sum(iweight[(TU==2)&(Q3<8)])))
            Totmoins=c(Totmoins, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(TU==3)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(TU==3)]))*100)/(sum(iweight[TU==3])+sum(iweight[(TU==3)&(Q3<8)])))
            Totrural=c(Totrural, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(TU==4)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(TU==4)]))*100)/(sum(iweight[TU==4])+sum(iweight[(TU==4)&(Q3<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q3"]==t])+sum(iweight[data[colnames(data)=="Q4"]==t]))*100)/(length(iweight)*sum(iweight[Q3<8])))
          }
          else{#Traitement pour les autres questions
            Totparis=c(Totparis, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(TU==1)])*100)/sum(iweight[TU==1]))
            Totplus=c(Totplus, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(TU==2)])*100)/sum(iweight[TU==2]))
            Totmoins=c(Totmoins, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(TU==3)])*100)/sum(iweight[TU==3]))
            Totrural=c(Totrural, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(TU==4)])*100)/sum(iweight[TU==4]))
            Tot=c(Tot, (sum(iweight[data[colnames(data)==input$quest_ann]==t])*100)/length(iweight))}}
        else{Totparis=c(Totparis,NA);Totplus=c(Totplus,NA);Totmoins=c(Totmoins,NA);Totrural=c(Totrural,NA)}
      }#fin for
      #fin du traitement
      Totparis[Totparis==0]=NA
      Totplus[Totplus==0]=NA
      Totmoins[Totmoins==0]=NA
      Totrural[Totrural==0]=NA
      #Changement de l'ordre
      if (sum(input$quest_ann==Question_jost)==1){O=c(1,2,3,4)}
      else{O=order(Tot,decreasing = FALSE)}
      X=posib_reponse_ann()[2:length(posib_reponse_ann())]
      X=X[O]
      Totparis=Totparis[O]
      Totplus=Totplus[O]
      Totmoins=Totmoins[O]
      Totrural=Totrural[O]
      for (i in 1:length(X)){X[i]=paste(strwrap(X[i], width = 50), collapse = " \n ")}
      detach(data)
      rm(data)
      #creation du data frame
      frame=data.frame(X,Totparis=round(Totparis, digits = dig),Totplus=round(Totplus, digits = dig),Totmoins=round(Totmoins, digits = dig),Totrural=round(Totrural,digits = dig))
      frame$X=factor(frame$X, levels = frame[["X"]])
      return(frame)
    }#fin TU
    
    if (input$vari==5){#Niv d'etude
      #import des donnees
      load(file = file.path(getwd(),"donnees_r",donnees[Taille]))
      attach(data)
      #initialisation
      Totprimaire=c()
      Totcollege=c()
      Totbac=c()
      Totsuperieur=c()
      Tot=c()
      for (t in 1:(length(posib_reponse_ann())-1)){
        if (exists(input$quest_ann)){
          #Traitement pour les questions 2 et 4
          if (input$quest_ann=="Q2"){
            Totprimaire=c(Totprimaire, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(NivEtud==1)])*sum(iweight[(NivEtud==1)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(NivEtud==1)])*sum(iweight[NivEtud==1]))*100)/(sum(iweight[NivEtud==1])*sum(iweight[(NivEtud==1)&(Q1<8)])))
            Totcollege=c(Totcollege, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(NivEtud==2)])*sum(iweight[(NivEtud==2)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(NivEtud==2)])*sum(iweight[NivEtud==2]))*100)/(sum(iweight[NivEtud==2])*sum(iweight[(NivEtud==2)&(Q1<8)])))
            Totbac=c(Totbac, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(NivEtud==3)])*sum(iweight[(NivEtud==3)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(NivEtud==3)])*sum(iweight[NivEtud==3]))*100)/(sum(iweight[NivEtud==3])*sum(iweight[(NivEtud==3)&(Q1<8)])))
            Totsuperieur=c(Totsuperieur, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(NivEtud==4)])*sum(iweight[(NivEtud==4)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(NivEtud==4)])*sum(iweight[NivEtud==4]))*100)/(sum(iweight[NivEtud==4])*sum(iweight[(NivEtud==4)&(Q1<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q1"]==t])*sum(iweight[Q1<8])+sum(iweight[data[colnames(data)=="Q2"]==t])*length(iweight))*100)/(length(iweight)*sum(iweight[Q1<8])))
          }
          else if (input$quest_ann=="Q4"){
            Totprimaire=c(Totprimaire, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(NivEtud==1)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(NivEtud==1)]))*100)/(sum(iweight[NivEtud==1])+sum(iweight[(NivEtud==1)&(Q3<8)])))
            Totcollege=c(Totcollege, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(NivEtud==2)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(NivEtud==2)]))*100)/(sum(iweight[NivEtud==2])+sum(iweight[(NivEtud==2)&(Q3<8)])))
            Totbac=c(Totbac, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(NivEtud==3)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(NivEtud==3)]))*100)/(sum(iweight[NivEtud==3])+sum(iweight[(NivEtud==3)&(Q3<8)])))
            Totsuperieur=c(Totsuperieur, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(NivEtud==4)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(NivEtud==4)]))*100)/(sum(iweight[NivEtud==4])+sum(iweight[(NivEtud==4)&(Q3<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q3"]==t])+sum(iweight[data[colnames(data)=="Q4"]==t]))*100)/(length(iweight)+sum(iweight[Q3<8])))
          }
          else{#Traitement pour les autres questions
            Totprimaire=c(Totprimaire, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(NivEtud==1)])*100)/sum(iweight[NivEtud==1]))
            Totcollege=c(Totcollege, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(NivEtud==2)])*100)/sum(iweight[NivEtud==2]))
            Totbac=c(Totbac, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(NivEtud==3)])*100)/sum(iweight[NivEtud==3]))
            Totsuperieur=c(Totsuperieur, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(NivEtud==4)])*100)/sum(iweight[NivEtud==4]))
            Tot=c(Tot, (sum(iweight[data[colnames(data)==input$quest_ann]==t])*100)/length(iweight))}}
        else{Totprimaire=c(Totprimaire,NA);Totcollege=c(Totcollege,NA);Totbac=c(Totbac,NA);Totsuperieur=c(Totsuperieur,NA)}
      }#fin for
      #fin du traitement
      Totprimaire[Totprimaire==0]=NA
      Totcollege[Totcollege==0]=NA
      Totbac[Totbac==0]=NA
      Totsuperieur[Totsuperieur==0]=NA
      #changement de l'ordre 
      if (sum(input$quest_ann==Question_jost)==1){O=c(1,2,3,4)}
      else{O=order(Tot,decreasing = FALSE)}
      X=posib_reponse_ann()[2:length(posib_reponse_ann())]
      X=X[O]
      Totprimaire=Totprimaire[O] 
      Totcollege=Totcollege[O]
      Totbac=Totbac[O]
      Totsuperieur=Totsuperieur[O]
      for (i in 1:length(X)){X[i]=paste(strwrap(X[i], width = 50), collapse = " \n ")}
      detach(data)
      rm(data)
      #creation du data frame 
      frame=data.frame(X,Totprimaire=round(Totprimaire, digits = dig),Totcollege=round(Totcollege, digits = dig),Totbac=round(Totbac, digits = dig),Totsuperieur=round(Totsuperieur, digits = dig))
      frame$X=factor(frame$X, levels = frame[["X"]])
      return(frame)
    }#fin niv etude
    
    if (input$vari==6){#Niv de vie
      #import des donnees
      load(file = file.path(getwd(),"donnees_r",donnees[Taille]))
      attach(data)
      #initialisation
      TotQ1=c()
      TotQ2=c()
      TotQ3=c()
      TotQ4=c()
      TotQ5=c()
      Tot=c()
      for (t in 1:(length(posib_reponse_ann())-1)){
        if (exists(input$quest_ann)){
          #Traitement des donnees pour les questions 2 et 4
          if (input$quest_ann=="Q2"){
            TotQ1=c(TotQ1, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(Niv_vie<Quintiles[2])])*sum(iweight[(Niv_vie<Quintiles[2])&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(Niv_vie<Quintiles[2])])*sum(iweight[Niv_vie<Quintiles[2]]))*100)/(sum(iweight[Niv_vie<Quintiles[2]])*sum(iweight[(Niv_vie<Quintiles[2])&(Q1<8)])))
            TotQ2=c(TotQ2, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))])*sum(iweight[((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))])*sum(iweight[(Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3])]))*100)/(sum(iweight[(Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3])])*sum(iweight[((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))&(Q1<8)])))
            TotQ3=c(TotQ3, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))])*sum(iweight[((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))])*sum(iweight[(Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4])]))*100)/(sum(iweight[(Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4])])*sum(iweight[((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))&(Q1<8)])))
            TotQ4=c(TotQ4, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))])*sum(iweight[((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))])*sum(iweight[(Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5])]))*100)/(sum(iweight[(Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5])])*sum(iweight[((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))&(Q1<8)])))
            TotQ5=c(TotQ5, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(Niv_vie>=Quintiles[5])])*sum(iweight[(Niv_vie>=Quintiles[5])&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(Niv_vie>=Quintiles[5])])*sum(iweight[Niv_vie>=Quintiles[5]]))*100)/(sum(iweight[Niv_vie>=Quintiles[5]])*sum(iweight[(Niv_vie>=Quintiles[5])&(Q1<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q1"]==t])*sum(iweight[Q1<8])+sum(iweight[data[colnames(data)=="Q2"]==t])*length(iweight))*100)/(length(iweight)*sum(iweight[Q1<8])))
          }
          else if (input$quest_ann=="Q4"){
            TotQ1=c(TotQ1, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(Niv_vie<Quintiles[2])])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(Niv_vie<Quintiles[2])]))*100)/(sum(iweight[Niv_vie<Quintiles[2]])+sum(iweight[(Niv_vie<Quintiles[2])&(Q3<8)])))
            TotQ2=c(TotQ2, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))])+sum(iweight[(data[colnames(data)=="Q4"]==t)&((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))]))*100)/(sum(iweight[(Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3])])+sum(iweight[((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))&(Q3<8)])))
            TotQ3=c(TotQ3, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))])+sum(iweight[(data[colnames(data)=="Q4"]==t)&((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))]))*100)/(sum(iweight[(Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4])])+sum(iweight[((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))&(Q3<8)])))
            TotQ4=c(TotQ4, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))])+sum(iweight[(data[colnames(data)=="Q4"]==t)&((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))]))*100)/(sum(iweight[(Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5])])+sum(iweight[((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))&(Q3<8)])))
            TotQ5=c(TotQ5, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(Niv_vie>=Quintiles[5])])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(Niv_vie>=Quintiles[5])]))*100)/(sum(iweight[Niv_vie>=Quintiles[5]]))+sum(iweight[(Niv_vie>=Quintiles[5])&(Q3<8)]))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q3"]==t])+sum(iweight[data[colnames(data)=="Q4"]==t]))*100)/(length(iweight)+sum(iweight[Q3<8])))
          }
          else{#traitement pour les autres questions 
            TotQ1=c(TotQ1, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(Niv_vie<Quintiles[2])])*100)/sum(iweight[Niv_vie<Quintiles[2]]))
            TotQ2=c(TotQ2, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&((Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3]))])*100)/sum(iweight[(Niv_vie>=Quintiles[2])&(Niv_vie<Quintiles[3])]))
            TotQ3=c(TotQ3, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&((Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4]))])*100)/sum(iweight[(Niv_vie>=Quintiles[3])&(Niv_vie<Quintiles[4])]))
            TotQ4=c(TotQ4, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&((Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5]))])*100)/sum(iweight[(Niv_vie>=Quintiles[4])&(Niv_vie<Quintiles[5])]))
            TotQ5=c(TotQ5, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(Niv_vie>=Quintiles[5])])*100)/sum(iweight[Niv_vie>=Quintiles[5]]))
            Tot=c(Tot, (sum(iweight[data[colnames(data)==input$quest_ann]==t])*100)/length(iweight))}}
        else{TotQ1=c(TotQ1,NA);TotQ2=c(TotQ2,NA);TotQ3=c(TotQ3,NA);TotQ4=c(TotQ4,NA);TotQ5=c(TotQ5,NA)}
      }#fin for
      #fin du traitement
      TotQ1[TotQ1==0]=NA
      TotQ2[TotQ2==0]=NA
      TotQ3[TotQ3==0]=NA
      TotQ4[TotQ4==0]=NA
      TotQ5[TotQ5==0]=NA
      #changement de l'ordre
      if (sum(input$quest_ann==Question_jost)==1){O=c(1,2,3,4)}
      else{O=order(Tot,decreasing = FALSE)}
      X=posib_reponse_ann()[2:length(posib_reponse_ann())]
      X=X[O]
      TotQ1=TotQ1[O] 
      TotQ2=TotQ2[O] 
      TotQ3=TotQ3[O] 
      TotQ4=TotQ4[O] 
      TotQ5=TotQ5[O] 
      for (i in 1:length(X)){X[i]=paste(strwrap(X[i], width = 50), collapse = " \n ")}
      detach(data)
      rm(data)
      #creation du data frame
      frame=data.frame(X,TotQ1=round(TotQ1, digits = dig),TotQ2=round(TotQ2, digits = dig),TotQ3=round(TotQ3, digits = dig),TotQ4=round(TotQ4, digits = dig),TotQ5=round(TotQ5, digits = dig))
      frame$X=factor(frame$X, levels = frame[["X"]])
      return(frame)
    }#Niv de vie
    
    if (input$vari==7){#Cat socio
      #import des donnees
      load(file = file.path(getwd(),"donnees_r",donnees[Taille]))
      attach(data)
      #initialisation
      Totcs1=c()
      Totcs2=c()
      Totcs3=c()
      Totcs4=c()
      Totcs5=c()
      Totcs6=c()
      Tot=c()
      for (t in 1:(length(posib_reponse_ann())-1)){
        if (exists(input$quest_ann)){
          #traitement pour les questions 2 et 4
          if (input$quest_ser=="Q2"){
            Totcs1=c(Totcs1, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(CS==1)])*sum(iweight[(CS==1)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(CS==1)])*sum(iweight[CS==1]))*100)/(sum(iweight[CS==1])*sum(iweight[(CS==1)&(Q1<8)])))
            Totcs2=c(Totcs2, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(CS==2)])*sum(iweight[(CS==2)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(CS==2)])*sum(iweight[CS==2]))*100)/(sum(iweight[CS==2])*sum(iweight[(CS==2)&(Q1<8)])))
            Totcs3=c(Totcs3, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(CS==3)])*sum(iweight[(CS==3)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(CS==3)])*sum(iweight[CS==3]))*100)/(sum(iweight[CS==3])*sum(iweight[(CS==3)&(Q1<8)])))
            Totcs4=c(Totcs4, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(CS==4)])*sum(iweight[(CS==4)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(CS==4)])*sum(iweight[CS==4]))*100)/(sum(iweight[CS==4])*sum(iweight[(CS==4)&(Q1<8)])))
            Totcs5=c(Totcs5, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(CS==5)])*sum(iweight[(CS==5)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(CS==5)])*sum(iweight[CS==5]))*100)/(sum(iweight[CS==5])*sum(iweight[(CS==5)&(Q1<8)])))
            Totcs6=c(Totcs6, ((sum(iweight[(data[colnames(data)=="Q1"]==t)&(CS==6)])*sum(iweight[(CS==6)&(Q1<8)])+sum(iweight[(data[colnames(data)=="Q2"]==t)&(CS==6)])*sum(iweight[CS==6]))*100)/(sum(iweight[CS==6])*sum(iweight[(CS==6)&(Q1<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q1"]==t])*sum(iweight[Q1<8])+sum(iweight[data[colnames(data)=="Q2"]==t])*length(iweight))*100)/(length(iweight)*sum(iweight[Q1<8])))
          }
          else if (input$quest_ser=="Q4"){
            Totcs1=c(Totcs1, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(CS==1)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(CS==1)]))*100)/(sum(iweight[CS==1])+sum(iweight[(CS==1)&(Q3<8)])))
            Totcs2=c(Totcs2, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(CS==2)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(CS==2)]))*100)/(sum(iweight[CS==2])+sum(iweight[(CS==2)&(Q3<8)])))
            Totcs3=c(Totcs3, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(CS==3)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(CS==3)]))*100)/(sum(iweight[CS==3])+sum(iweight[(CS==3)&(Q3<8)])))
            Totcs4=c(Totcs4, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(CS==4)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(CS==4)]))*100)/(sum(iweight[CS==4])+sum(iweight[(CS==4)&(Q3<8)])))
            Totcs5=c(Totcs5, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(CS==5)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(CS==5)]))*100)/(sum(iweight[CS==5])+sum(iweight[(CS==5)&(Q3<8)])))
            Totcs6=c(Totcs6, ((sum(iweight[(data[colnames(data)=="Q3"]==t)&(CS==6)])+sum(iweight[(data[colnames(data)=="Q4"]==t)&(CS==6)]))*100)/(sum(iweight[CS==6])+sum(iweight[(CS==6)&(Q3<8)])))
            Tot=c(Tot, ((sum(iweight[data[colnames(data)=="Q3"]==t])+sum(iweight[data[colnames(data)=="Q4"]==t]))*100)/(length(iweight)+sum(iweight[Q3<8])))
          }
          else{#traitement pour les autre questions
            Totcs1=c(Totcs1, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(CS==1)])*100)/sum(iweight[CS==1]))
            Totcs2=c(Totcs2, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(CS==2)])*100)/sum(iweight[CS==2]))
            Totcs3=c(Totcs3, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(CS==3)])*100)/sum(iweight[CS==3]))
            Totcs4=c(Totcs4, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(CS==4)])*100)/sum(iweight[CS==4]))
            Totcs5=c(Totcs5, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(CS==5)])*100)/sum(iweight[CS==5]))
            Totcs6=c(Totcs6, (sum(iweight[(data[colnames(data)==input$quest_ann]==t)&(CS==6)])*100)/sum(iweight[CS==6]))
            Tot=c(Tot, (sum(iweight[data[colnames(data)==input$quest_ann]==t])*100)/length(iweight))}}
        else{Totcs1=c(Totcs1,NA);Totcs2=c(Totcs2,NA);Totcs3=c(Totcs3,NA);Totcs4=c(Totcs4,NA);Totcs5=c(Totcs5,NA);Totcs6=c(Totcs6,NA)}
      }#fin for
      #fin du traitement
      Totcs1[Totcs1==0]=NA
      Totcs2[Totcs2==0]=NA
      Totcs3[Totcs3==0]=NA
      Totcs4[Totcs4==0]=NA
      Totcs5[Totcs5==0]=NA
      Totcs6[Totcs6==0]=NA
      #changement de l'ordre
      if (sum(input$quest_ann==Question_jost)==1){O=c(1,2,3,4)}
      else{O=order(Tot,decreasing = FALSE)}
      X=posib_reponse_ann()[2:length(posib_reponse_ann())]
      X=X[O]
      Totcs1=Totcs1[O] 
      Totcs2=Totcs2[O] 
      Totcs3=Totcs3[O] 
      Totcs4=Totcs4[O] 
      Totcs5=Totcs5[O]
      Totcs6=Totcs6[O]
      for (i in 1:length(X)){X[i]=paste(strwrap(X[i], width = 50), collapse = " \n ")}
      detach(data)
      rm(data)
      #creation du data frame
      frame=data.frame(X,Totcs1=round(Totcs1, digits = dig),Totcs2=round(Totcs2, digits = dig),Totcs3=round(Totcs3, digits = dig),Totcs4=round(Totcs4, digits = dig),Totcs5=round(Totcs5, digits = dig),Totcs6=round(Totcs6, digits = dig))
      frame$X=factor(frame$X, levels = frame[["X"]])
      return(frame)
    }#fin cat socio
    
  }#fin pour l'année en cours
  
})#fin creation table




##### Graphique #####
output$graphique <- renderPlotly({
  
  if (req(input$choice_1)==2 & length(row.names(Table()))>0){#graphique pour la serie 
    if (req(input$vari)==1) { #synthese
      if (length(Table())==2){#graphique pour les questions oui/non ou shynthèse d'une reponse
        fig <- plot_ly(data = Table(), x = ~A, y = Table()[,2], type = 'scatter', mode = 'lines+markers', name = "Oui", marker = list(color = couleur()[1]), line = list(color = couleur()[1], shape = "spline"))
        #deux layout possible pour afficher ou non la reponse dans le titre
        if (sum(input$quest_ser==Question_OuiNon)==1){fig <- fig %>% layout(title = paste(strwrap(titre(), width = 100), collapse = " \n "), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal"),margin = margin_scatter)}
        else{fig <- fig %>% layout(title = paste(paste(strwrap(titre(), width = 100), collapse = " \n "),"\n",input$rep), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_scatter)}
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10), showarrow=F, align="left", yref="paper", xref="paper")
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig
      }
      else{#graphique pour les questions a choix multiple 
        for (i in 2:length(Table())){
          if (sum(choix_rep_affichage()==posib_reponse()[i])==1){
            if (exists("fig")){fig <- fig %>% add_trace(y = Table()[,i], type = 'scatter', mode = 'lines+markers', name = posib_reponse()[i], marker = list(color = couleur()[i-1]), line = list(color = couleur()[i-1], shape = "spline"))}
            else{fig <- plot_ly(data = Table(), x = Table()$A, y = Table()[,i], type = 'scatter', mode = 'lines+markers', name = posib_reponse()[i], marker = list(color = couleur()[i-1]), line = list(color = couleur()[i-1], shape = "spline"))}
          }
        }
        if (exists("fig")){
          fig <- fig %>% layout(title = paste(strwrap(titre(), width = 100), collapse = " \n "), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_scatter)
          fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10), showarrow=F, align="left", yref="paper", xref="paper")
          fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
          fig
        }
      }
    }#fin synthese
    
    else if (input$vari==2){ #Genre
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), x = ~A, y = ~TotHom, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[1], marker = list(color = couleur()[1]), line = list(color = couleur()[1], shape = "spline"))} 
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = Table()$TotFem, name = Name_Variable()[2], marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = Table()$A, y = Table()$TotFem, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[2], marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
      }
      if (exists("fig")){
        if (sum(input$quest_ser==Question_OuiNon)==1){fig <- fig %>% layout(title = paste(strwrap(titre(), width = 100), collapse = " \n "), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal"),margin = margin_scatter)}
        else{fig <- fig %>% layout(title = paste(paste(strwrap(titre(), width = 100), collapse = " \n "),"\n",input$rep), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_scatter)}
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#fin Genre
    
    else if (input$vari==3){#Age
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), x = ~A, y = ~Totjeune, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[1], marker = list(color = couleur()[1]), line = list(color = couleur()[1], shape = "spline"))}
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totmoyen, name = Name_Variable()[2], marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totmoyen, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[2], marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[3])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totvieux, name = Name_Variable()[3], marker = list(color = couleur()[3]), line = list(color = couleur()[3], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totvieux, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[3], marker = list(color = couleur()[3]), line = list(color = couleur()[3], shape = "spline"))}
      }
      if (exists("fig")){
        if (sum(input$quest_ser==Question_OuiNon)==1){fig <- fig %>% layout(title = paste(strwrap(titre(), width = 100), collapse = " \n "), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal"),margin = margin_scatter)}
        else{fig <- fig %>% layout(title = paste(paste(strwrap(titre(), width = 100), collapse = " \n "),"\n",input$rep), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_scatter)}
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#fin age
    
    else if (input$vari==4){#TU
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), x = ~A, y = ~Totparis, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[1], marker = list(color = couleur()[1]), line = list(color = couleur()[1], shape = "spline"))}
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totplus, name = Name_Variable()[2], marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totplus, name = Name_Variable()[2], type = 'scatter', mode = 'lines+markers', marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[3])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totmoins, name = Name_Variable()[3], marker = list(color = couleur()[3]), line = list(color = couleur()[3], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totmoins, name = Name_Variable()[3], type = 'scatter', mode = 'lines+markers', marker = list(color = couleur()[3]), line = list(color = couleur()[3], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[4])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totrural, name = Name_Variable()[4], marker = list(color = couleur()[4]), line = list(color = couleur()[4], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totrural, name = Name_Variable()[4], type = 'scatter', mode = 'lines+markers', marker = list(color = couleur()[4]), line = list(color = couleur()[4], shape = "spline"))}
      }
      if (exists("fig")){
        if (sum(input$quest_ser==Question_OuiNon)==1){fig <- fig %>% layout(title = paste(strwrap(titre(), width = 100), collapse = " \n "), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal"),margin = margin_scatter)}
        else{fig <- fig %>% layout(title = paste(paste(strwrap(titre(), width = 100), collapse = " \n "),"\n",input$rep), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_scatter)}
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#fin TU
    
    else if (input$vari==5){#Niv Etude
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), x = ~A, y = ~Totprimaire, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[1], marker = list(color = couleur()[1]), line = list(color = couleur()[1], shape = "spline"))}
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totcollege, name = Name_Variable()[2], marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totcollege, name = Name_Variable()[2], type = 'scatter', mode = 'lines+markers', marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[3])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totbac, name = Name_Variable()[3], marker = list(color = couleur()[3]), line = list(color = couleur()[3], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totbac, name = Name_Variable()[3], type = 'scatter', mode = 'lines+markers', marker = list(color = couleur()[3]), line = list(color = couleur()[3], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[4])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totsuperieur, name = Name_Variable()[4], marker = list(color = couleur()[4]), line = list(color = couleur()[4], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totsuperieur, name = Name_Variable()[4], type = 'scatter', mode = 'lines+markers', marker = list(color = couleur()[4]), line = list(color = couleur()[4], shape = "spline"))}
      }
      if (exists("fig")){
        if (sum(input$quest_ser==Question_OuiNon)==1){fig <- fig %>% layout(title = paste(strwrap(titre(), width = 100), collapse = " \n "), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal"),margin = margin_scatter)}
        else{fig <- fig %>% layout(title = paste(paste(strwrap(titre(), width = 100), collapse = " \n "),"\n",input$rep), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_scatter)}
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#Fin niv Etude
    
    else if (input$vari==6){#Niv Vie
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), x = ~A, y = ~TotQ1, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[1], marker = list(color = couleur()[1]), line = list(color = couleur()[1], shape = "spline"))}
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~TotQ2, name = Name_Variable()[2], marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~TotQ2, name = Name_Variable()[2], type = 'scatter', mode = 'lines+markers', marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[3])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~TotQ3, name = Name_Variable()[3], marker = list(color = couleur()[3]), line = list(color = couleur()[3], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~TotQ3, name = Name_Variable()[3], type = 'scatter', mode = 'lines+markers', marker = list(color = couleur()[3]), line = list(color = couleur()[3], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[4])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~TotQ4, name = Name_Variable()[4], marker = list(color = couleur()[4]), line = list(color = couleur()[4], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~TotQ4, name = Name_Variable()[4], type = 'scatter', mode = 'lines+markers', marker = list(color = couleur()[4]), line = list(color = couleur()[4], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[5])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~TotQ5, name = Name_Variable()[5], marker = list(color = couleur()[5]), line = list(color = couleur()[5], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~TotQ5, name = Name_Variable()[5], type = 'scatter', mode = 'lines+markers', marker = list(color = couleur()[5]), line = list(color = couleur()[5], shape = "spline"))}
      }
      if (exists("fig")){
        if (sum(input$quest_ser==Question_OuiNon)==1){fig <- fig %>% layout(title = paste(strwrap(titre(), width = 100), collapse = " \n "), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal"),margin = margin_scatter)}
        else{fig <- fig %>% layout(title = paste(paste(strwrap(titre(), width = 100), collapse = " \n "),"\n",input$rep), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_scatter)}
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#Fin niv Vie
    
    else if (input$vari==7){#CS
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), x = ~A, y = ~Totcs1, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[1], marker = list(color = couleur()[1]), line = list(color = couleur()[1], shape = "spline"))}
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totcs2, name = Name_Variable()[2], marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totcs2, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[2], marker = list(color = couleur()[2]), line = list(color = couleur()[2], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[3])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totcs3, name = Name_Variable()[3], marker = list(color = couleur()[3]), line = list(color = couleur()[3], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totcs3, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[3], marker = list(color = couleur()[3]), line = list(color = couleur()[3], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[4])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totcs4, name = Name_Variable()[4], marker = list(color = couleur()[4]), line = list(color = couleur()[4], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totcs4, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[4], marker = list(color = couleur()[4]), line = list(color = couleur()[4], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[5])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totcs5, name = Name_Variable()[5], marker = list(color = couleur()[5]), line = list(color = couleur()[5], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totcs5, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[5], marker = list(color = couleur()[5]), line = list(color = couleur()[5], shape = "spline"))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[6])==1){
        if (exists("fig")){fig <- fig %>% add_trace(y = ~Totcs6, name = Name_Variable()[6], marker = list(color = couleur()[6]), line = list(color = couleur()[6], shape = "spline"))}
        else{fig <- plot_ly(data = Table(), x = ~A, y = ~Totcs6, type = 'scatter', mode = 'lines+markers', name = Name_Variable()[6], marker = list(color = couleur()[6]), line = list(color = couleur()[6], shape = "spline"))}
      }
      if (exists("fig")){
        if (sum(input$quest_ser==Question_OuiNon)==1){fig <- fig %>% layout(title = paste(strwrap(titre(), width = 100), collapse = " \n "), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal"),margin = margin_scatter)}
        else{fig <- fig %>% layout(title = paste(paste(strwrap(titre(), width = 100), collapse = " \n "),"\n",input$rep), yaxis =list(title = "Proportion (%)", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)), xaxis = list(title=""),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_scatter)}
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#Fin CS
    
  }#fin pour la serie
  
  else if ((variable_choix()==1) & exists("Table")){#graphique pour l'annee en cours
    
    if (input$vari==1) { #synthese
      if (exists("Table")){
        fig <- plot_ly(data = Table(), y = ~X, x = ~Tot, type = 'bar', orientation = 'h',marker = list(color = couleur()[1]))
        fig <- fig %>% layout(title = paste(strwrap(titre_ann(), width = 100), collapse = " \n "), yaxis =list(title = ""), xaxis = list(title="", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)),showlegend = FALSE, margin = margin_bar)
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#fin synthese
    
    else if (input$vari==2){ #Genre
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), x = ~TotHom, y = ~X, type = 'bar', name = Name_Variable()[1], orientation = 'h',marker = list(color = couleur()[1]))} 
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~TotFem, name = Name_Variable()[2],marker = list(color = couleur()[2]))}
        else{fig <- plot_ly(data = Table(), x = ~TotFem, y = ~X, type = 'bar', name = Name_Variable()[2], orientation = 'h',marker = list(color = couleur()[2]))}
      }
      if (exists("fig")){
        fig <- fig %>% layout(title = paste(strwrap(titre_ann(), width = 100), collapse = " \n "), yaxis =list(title = ""), xaxis = list(title="", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_bar)
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#fin Genre
    
    else if (input$vari==3){#Age
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), y = ~X, x = ~Totjeune, type = 'bar', orientation = 'h', name = Name_Variable()[1],marker = list(color = couleur()[1]))}
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totmoyen, name = Name_Variable()[2],marker = list(color = couleur()[2]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totmoyen, type = 'bar', orientation = 'h', name = Name_Variable()[2],marker = list(color = couleur()[2]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[3])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totvieux, name = Name_Variable()[3],marker = list(color = couleur()[3]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totvieux, type = 'bar', orientation = 'h', name = Name_Variable()[3],marker = list(color = couleur()[3]))}
      }
      if (exists("fig")){
        fig <- fig %>% layout(title = paste(strwrap(titre_ann(), width = 100), collapse = " \n "), yaxis =list(title = ""), xaxis = list(title="", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_bar)
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#fin age
    
    else if (input$vari==4){#TU
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), y = ~X, x = ~Totparis, type = 'bar', orientation = 'h', name = Name_Variable()[1],marker = list(color = couleur()[1]))}
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totplus, name = Name_Variable()[2],marker = list(color = couleur()[2]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totplus, name = Name_Variable()[2], type = 'bar', orientation = 'h',marker = list(color = couleur()[2]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[3])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totmoins, name = Name_Variable()[3],marker = list(color = couleur()[3]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totmoins, name = Name_Variable()[3], type = 'bar', orientation = 'h',marker = list(color = couleur()[3]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[4])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totrural, name = Name_Variable()[4],marker = list(color = couleur()[4]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totrural, name = Name_Variable()[4], type = 'bar', orientation = 'h',marker = list(color = couleur()[4]))}
      }
      if (exists("fig")){
        fig <- fig %>% layout(title = paste(strwrap(titre_ann(), width = 100), collapse = " \n "), yaxis =list(title = ""), xaxis = list(title="", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_bar)
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#fin TU
    
    else if (input$vari==5){#Niv Etude
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), y = ~X, x = ~Totprimaire, name = Name_Variable()[2], type = 'bar', orientation = 'h',marker = list(color = couleur()[1]))}
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totcollege, name = Name_Variable()[2],marker = list(color = couleur()[2]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totcollege, name = Name_Variable()[2], type = 'bar', orientation = 'h',marker = list(color = couleur()[2]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[3])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totbac, name = Name_Variable()[3],marker = list(color = couleur()[3]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totbac, name = Name_Variable()[3], type = 'bar', orientation = 'h',marker = list(color = couleur()[3]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[4])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totsuperieur, name = Name_Variable()[4],marker = list(color = couleur()[4]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totsuperieur, name = Name_Variable()[4], type = 'bar', orientation = 'h',marker = list(color = couleur()[4]))}
      }
      if (exists("fig")){
        fig <- fig %>% layout(title = paste(strwrap(titre_ann(), width = 100), collapse = " \n "), yaxis =list(title = ""), xaxis = list(title="", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_bar)
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#Fin niv Etude
    
    else if (input$vari==6){#Niv Vie
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), y = ~X, x = ~TotQ1, type = 'bar', orientation = 'h', name = Name_Variable()[1],marker = list(color = couleur()[1]))}
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~TotQ2, name = Name_Variable()[2],marker = list(color = couleur()[2]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~TotQ2, name = Name_Variable()[2], type = 'bar', orientation = 'h',marker = list(color = couleur()[2]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[3])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~TotQ3, name = Name_Variable()[3],marker = list(color = couleur()[3]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~TotQ3, name = Name_Variable()[3], type = 'bar', orientation = 'h',marker = list(color = couleur()[3]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[4])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~TotQ4, name = Name_Variable()[4],marker = list(color = couleur()[4]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~TotQ4, name = Name_Variable()[4], type = 'bar', orientation = 'h',marker = list(color = couleur()[4]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[5])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~TotQ5, name = Name_Variable()[5],marker = list(color = couleur()[5]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~TotQ5, name = Name_Variable()[5], type = 'bar', orientation = 'h',marker = list(color = couleur()[5]))}
      }
      if (exists("fig")){
        fig <- fig %>% layout(title = paste(strwrap(titre_ann(), width = 100), collapse = " \n "), yaxis =list(title = ""), xaxis = list(title="", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_bar)
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#Fin niv Vie
    
    else if (input$vari==7){#CS
      if (sum(choix_vari_affichage()==Name_Variable()[1])==1){fig <- plot_ly(data = Table(), y = ~X, x = ~Totcs1, type = 'bar', orientation = 'h', name = Name_Variable()[1],marker = list(color = couleur()[1]))}
      if (sum(choix_vari_affichage()==Name_Variable()[2])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totcs2, name = Name_Variable()[2],marker = list(color = couleur()[2]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totcs2, name = Name_Variable()[2], type = 'bar', orientation = 'h',marker = list(color = couleur()[2]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[3])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totcs3, name = Name_Variable()[3],marker = list(color = couleur()[3]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totcs3, name = Name_Variable()[3], type = 'bar', orientation = 'h',marker = list(color = couleur()[3]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[4])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totcs4, name = Name_Variable()[4],marker = list(color = couleur()[4]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totcs4, name = Name_Variable()[4], type = 'bar', orientation = 'h',marker = list(color = couleur()[4]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[5])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totcs5, name = Name_Variable()[5],marker = list(color = couleur()[5]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totcs5, name = Name_Variable()[5], type = 'bar', orientation = 'h',marker = list(color = couleur()[5]))}
      }
      if (sum(choix_vari_affichage()==Name_Variable()[6])==1){
        if (exists("fig")){fig <- fig %>% add_trace(x = ~Totcs6, name = Name_Variable()[6],marker = list(color = couleur()[6]))}
        else{fig <- plot_ly(data = Table(), y = ~X, x = ~Totcs6, name = Name_Variable()[6], type = 'bar', orientation = 'h',marker = list(color = couleur()[6]))}
      }
      if (exists("fig")){
        fig <- fig %>% layout(title = paste(strwrap(titre_ann(), width = 100), collapse = " \n "), yaxis =list(title = ""), xaxis = list(title="", range=c(0,max(Table()[2:length(Table())],na.rm = TRUE)+5)),legend = list(orientation = "h",x = 0, y = -0.2,traceorder="normal",itemclick = FALSE,itemdoubleclick = FALSE),margin = margin_bar)
        fig <- fig %>% plotly::config(displaylogo = F, modeBarButtonsToRemove = plotlyRemove, displayModeBar = TRUE, showTips = FALSE)
        fig <- fig %>% add_annotations(x=0, y=-0.2, text=leg(), font = list(color = "#3F3F4E",size = 10),showarrow=F,align="left",yref='paper', xref="paper")
        fig
      }
    }#Fin CS
    
  }#fin pour l'annee en cours
  
})#fin creation graphique

###Cretaion de la table
output$table_out <- DT::renderDataTable(
  datatable({
    table_disp=Table()
    #changement des nom de colonne pour afficher la table
    if (sum(req(input$quest_ser)==Question_OuiNon)|sum(input$quest_ann==Question_OuiNon)){
      if (input$vari==1){colnames(table_disp)=c("Année","Oui")}
      else{colnames(table_disp)=c("Année",Name_Variable())}
    }
    else {
      if (input$choice_1==2){
        if (input$rep==posib_reponse()[1]){colnames(table_disp)=c("Année",posib_reponse()[-1])}
        else {if (input$vari==1){colnames(table_disp)=c("Année","%")}
          else{colnames(table_disp)=c("Année",Name_Variable())}
        }
      }
      else {
        if (input$vari==1){colnames(table_disp)=c("Année","%")}
        else{colnames(table_disp)=c("Année",Name_Variable())}
      }
    }
    table_disp
  },rownames= FALSE ,extensions = 'Buttons'
  , options = list( 
    dom = "Blfrtip",
    lengthMenu = list(c(10, 50, -1), c('10', '50', 'Toutes')),
    pageLength = -1,
    language = list(lengthMenu = "Afficher _MENU_ lignes",search = 'Rechercher:',info = '_START_ à _END_ sur _TOTAL_ lignes',
                    paginate = list(previous = 'Précédent', `next` = 'Suivant'))
    , buttons = 
      list(
        list(
          extend = "collection"
          , buttons = list(list(extend = 'excel', title =if(input$choice_1==2){titre()}else{titre_ann()}), 
                           list(extend = 'pdf', title =if(input$choice_1==2){titre()}else{titre_ann()}))
          , text = "Télécharger"
        )
      )
  )
  )
)#fin creation de la table

