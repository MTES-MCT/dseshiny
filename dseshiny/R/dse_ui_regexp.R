#' traduction grille bootstrap vers dsfr
#'
#' @param ui une liste ui générée par shiny::fluidpage
#' @import rrapply
#' @return la fonction retourne une ui interprétable par dsfr
#' @export
dse_ui_regexp<-function(ui){
  res<-rapply(ui,function(attribut){gsub(x=attribut,pattern="col-sm",replacement="fr-col")},how="replace",classes = "character")
  res<-rapply(res,function(attribut){gsub(x=attribut,pattern="container-fluid",replacement="fr-container")},how="replace",classes = "character")
  res<-rrapply(res,condition = function(x, .xname) .xname %in% c("class"),
          function(attribut){gsub(x=attribut,pattern='^row$',replacement='fr-grid-row')},how="replace",classes = "character")
  return(res)
}
