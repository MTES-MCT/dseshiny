#' generateur d une application shiny simple au format app.R
#' dans un repertoire
#'
#' @param chemin une chaine de caracteres qui indique ou construire l application
#'
#' @return la fonction construit un repertoire qui contient l'application après avoir été dézippée
#' @import stringr zip
#' @export

library(stringr)

dse_gen_simple_app_r <- function(chemin){
  if (dir.exists(chemin)) {
    print("Le chemin fournit en parametre de la fonction existe deja, veuillez fournir un chemin qui n existe pas deja")
  } else {
    dir.create(chemin)
    download.file("https://github.com/virgilecs/shiny_app/archive/refs/heads/main.zip", destfile = "shiny_app_main.zip")
    unzip("shiny_app_main.zip", exdir = chemin)


  }

}

