class Typeliaison_ressources_home {
    constructor() {
    $('a[data-value="Graphiques"]').click(function(event) {
        console.log("click Graphiques");
        $("#graphique").css("display", "block");
        $("#table_out").css("display", "none");
        $("#BoxReponse").css("display", "block");
      
    });
    $('a[data-value="Tableaux"]').click(function(event) {
        console.log("click Tableaux");
        $("#graphique").css("display", "none");
        $("#table_out").css("display", "block");
        $("#BoxReponse").css("display", "none");
    });
    $(document).ready(function(){
      $('a[data-value="Graphiques"]').addClass('fr-btn fr-icon-line-chart-line fr-btn--icon-left');
      $('a[data-value="Tableaux"]').addClass('fr-btn fr-icon-window-line fr-btn--icon-right');
    })
}}

(function() {
    "use strict";

    class Init_home {
        constructor() {
            const html_home = document.querySelector('html');
            new Typeliaison_ressources_home();
            

        }
    }

    const _init = new Init_home();
}());



