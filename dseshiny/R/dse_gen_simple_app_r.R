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
    file.copy(from=system.file("shiny_default_app","shiny_default_app.zip"  ,package = "dseshiny"),to=str_c(chemin,"/shiny_default_app.zip"))
    unzip(str_c(chemin,"/","shiny_default_app.zip"), exdir = chemin)
  }

}

