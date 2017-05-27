$(document).ready(function(){
  $("body").on("click", ".search-icon", function() {
    var headerLinks = $(".header-to-hide-when-searching");
    if (headerLinks.hasClass("hide")) {
      $(".header-to-hide-when-searching").removeClass("hide")
      $(".search-input-form").addClass("hide")
    } else {
      $(".header-to-hide-when-searching").addClass("hide")
      $(".search-input-form").removeClass("hide")
    }
  })
});