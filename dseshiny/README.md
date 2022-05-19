# dseshiny : pour générer une application R shiny conforme au DSE (Design Système de l'Etat)

[lien vers le design système état](https://www.systeme-de-design.gouv.fr/)

## Installer le package


```
# Installation depuis gitlab MTE
library(devtools) 
devtools::install_gitlab( 
  repo="olivier.chantrel/dseshiny", 
  host="https://gitlab-forge.din.developpement-durable.gouv.fr") 
```

## Générer une appli RShiny

Construit localement une appli dans un répertoire qui n'existe pas
```
library(dseshiny)
dse_gen_simple_app_r("c:/monapplishinydsecompliant")
```

![](inst/img/README.md.nouveauprojet.PNG)


### Un fichier .Rproj est généré dans le répertoire de l'appli

![](inst/img/README.md.nouveauprojet-2.PNG)

### Il suffit de l'ouvrir avec Rstudio

![](inst/img/README.md.nouveauprojet-3.PNG)

### Puis lancer le app.R pour voir à quoi ça ressemble

![](inst/img/README.md.nouveauprojet-4.PNG)

### il n'y a plus qu'à s'occuper du contenu
