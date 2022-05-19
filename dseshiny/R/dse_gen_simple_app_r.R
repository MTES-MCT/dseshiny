#' generateur d une application shiny simple au format app.R
#' dans un repertoire
#'
#' @param chemin une chaine de caracteres qui indique ou construire l application
#'
#' @return la fonction construit un repertoire qui contient l'application
#' @examples
#' dse_gen_simple_app_r("C:/mesapplis/shiny/dse")
#' @import stringr
#' @export
dse_gen_simple_app_r <- function(chemin){
  if (dir.exists(chemin)) {
    print("Le chemin fournit en parametre de la fonction existe deja, veuillez fournir un chemin qui n existe pas deja")
  } else {
    dir.create(chemin)
    dir.create(str_c(chemin,"/www"))
    dir.create(str_c(chemin,"/www","/css"))
    dir.create(str_c(chemin,"/www","/favicons"))
    dir.create(str_c(chemin,"/www","/fonts"))
    dir.create(str_c(chemin,"/www","/img"))
    dir.create(str_c(chemin,"/www","/js"))
    file.copy(from=system.file("dse_gen_simple_app_r","app.R"                        ,package = "dseshiny"),to=chemin)
    file.copy(from=system.file("dse_gen_simple_app_r","dse_gen_simple_app_r.Rproj"   ,package = "dseshiny"),to=chemin)
    file.copy(from=system.file("header"              ,"header.html"                  ,package = "dseshiny"),to=str_c(chemin,"/www"))
    file.copy(from=system.file("footer"              ,"footer.html"                  ,package = "dseshiny"),to=str_c(chemin,"/www"))
    file.copy(from=system.file("dse"                 ,"dsfr.css"                     ,package = "dseshiny"),to=str_c(chemin,"/www/css"))
    file.copy(from=system.file("fonts"               ,"Marianne-Bold.woff"           ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Bold_Italic.woff"    ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Light.woff"          ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Light_Italic.woff"   ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Regular.woff"        ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Regular_Italic.woff" ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Bold.woff2"          ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Bold_Italic.woff2"   ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Light.woff2"         ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Light_Italic.woff2"  ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Regular.woff2"       ,package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("fonts"               ,"Marianne-Regular_Italic.woff2",package = "dseshiny"),to=str_c(chemin,"/www/fonts"))
    file.copy(from=system.file("favicons"            ,"android-chrome-192x192.png"   ,package = "dseshiny"),to=str_c(chemin,"/www/favicons"))
    file.copy(from=system.file("favicons"            ,"android-chrome-512x512.png"   ,package = "dseshiny"),to=str_c(chemin,"/www/favicons"))
    file.copy(from=system.file("favicons"            ,"apple-touch-icon.png"         ,package = "dseshiny"),to=str_c(chemin,"/www/favicons"))
    file.copy(from=system.file("favicons"            ,"favicon.ico"                  ,package = "dseshiny"),to=str_c(chemin,"/www/favicons"))
    file.copy(from=system.file("favicons"            ,"manifest.webmanifest"         ,package = "dseshiny"),to=str_c(chemin,"/www/favicons"))
    file.copy(from=system.file("favicons"            ,"favicon.svg"                  ,package = "dseshiny"),to=str_c(chemin,"/www/favicons"))
    file.copy(from=system.file("img"                 ,"logo-ssp.png"                 ,package = "dseshiny"),to=str_c(chemin,"/www/img"))
    file.copy(from=system.file("js"                  ,"dsfr.module.js"               ,package = "dseshiny"),to=str_c(chemin,"/www/js"))
    file.copy(from=system.file("js"                  ,"dsfr.module.js.map"           ,package = "dseshiny"),to=str_c(chemin,"/www/js"))
  }

}
