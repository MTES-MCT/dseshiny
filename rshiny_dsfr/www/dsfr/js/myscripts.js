function uniqueid(){
    // always start with a letter (for DOM friendlyness)
    var idstr=String.fromCharCode(Math.floor((Math.random()*25)+65));
    do {
        // between numbers and characters (48 is 0 and 90 is Z (42-48 = 90)
        var ascicode=Math.floor((Math.random()*42)+48);
        if (ascicode<58 || ascicode>64){
            // exclude all chars between : (58) and @ (64)
            idstr+=String.fromCharCode(ascicode);
        }
    } while (idstr.length<32);

    return (idstr);
}


class Typeliaison_ressources {
    constructor() {
      var uniqid = (new Date()).getTime();
      $("html").removeAttr("class");
      $("html").attr("dir", "ltr");
      $("html").attr("xmlns", "http://www.w3.org/1999/xhtml");
      $("html").attr("xml:lang", "fr");
      $("html").attr("data-fr-scheme", "light");
      $("html").attr("data-fr-js", "true");
      $("html").attr("data-fr-theme", "light");
      $("html").attr("lang", "fr");


      $( "button.fr-btn--display.fr-btn" ).on( "click", function() {
        $("#fr-theme-modal").addClass("fr-modal--opened");
        console.log("fr-modal--opened ajouté ");
      });
      $( "button.fr-btn--display" ).on( "click", function() {
        $("#fr-theme-modal").addClass("fr-modal--opened");
        console.log("fr-modal--opened ajouté ");
      });
      $("button.fr-link--close.fr-link").on( "click", function() {
        $("#fr-theme-modal").removeClass("fr-modal--opened");
        console.log("fr-modal--opened supprimé ");
      });
      $("#btn_rechercher").attr("for", "search-399-input");
      $("#container nav").attr("aria-label", "vous êtes ici :");
      $("#container nav").attr("data-fr-js-breadcrumb", "true");
      $("#container button").attr("aria-expanded", "false");
      $("#container button").attr("aria-controls", "breadcrumb-1");
      $("#container button").attr("data-fr-js-collapse-button","true");
      $("#breadcrumb-1").attr("data-fr-js-collapse","true");
      
      var btn = $('#topbtn');
        
      $(window).scroll(function() {
        if ($(window).scrollTop() > 100) {
          btn.addClass('show');
        } else {
          btn.removeClass('show');
        }
      });
      
      btn.on('click', function(e) {
        e.preventDefault();
        $('html, body').animate({scrollTop:0}, '100');
      });

}}

(function() {
    "use strict";

    class Init {
        constructor() {
            const html = document.querySelector('html');
            new Typeliaison_ressources();
            

        }
    }

    const _init = new Init();
}());



