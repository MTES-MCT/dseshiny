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
Ouvrir le fichier dse_gen_simple_app_r.R (dans le répertoire R) et renseigner la variable "fichier", étant le chemin du fichier zip shiny_default_app.zip 
```
library(dseshiny)
dse_gen_simple_app_r("c:/monapplishinydsecompliant")
```

![](inst/README.md.newproject.png)
![](inst/README.md.newproject2.png)


### Un répertoire "shiny_default_app est généré dans le répertoire de l'appli

L'ouvrir

![](inst/README.md.newproject3.png)

### Il suffit d'ouvrir le fichier rdsfr.Rproj avec Rstudio

![](inst/README.md.newproject4.png)

### Puis lancer run app dans le app.R pour voir à quoi ça ressemble

![](inst/README.md.newproject5.png)
![](inst/README.md.newproject6.png)


### il n'y a plus qu'à s'occuper du contenu
