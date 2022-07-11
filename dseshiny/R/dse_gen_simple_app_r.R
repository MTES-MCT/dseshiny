#' generateur d une application shiny simple au format app.R
#' dans un repertoire
#'
#' @param chemin une chaine de caracteres qui indique ou construire l application
#'
#' @return la fonction construit un repertoire qui contient l'application après avoir été dézippée
#' @import stringr zip
#' @export

library(stringr)
fichier <- "C:/Travail/package3/dseshiny/dseshiny/shiny_default_app/shiny_default_app.zip" #chemin du fichier zip shiny_default_app.zip à définir manuellement par l'utilisateur

dse_gen_simple_app_r <- function(chemin){
  if (dir.exists(chemin)) {
    print("Le chemin fournit en parametre de la fonction existe deja, veuillez fournir un chemin qui n existe pas deja")
  } else {
    dir.create(chemin)
    destination <- str_c(chemin, "/shiny_default_app.zip")
    file.copy(fichier, destination)
    unzip(destination, exdir = chemin)


  }

}

