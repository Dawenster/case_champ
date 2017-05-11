$(document).ready(function(){
  checkToTriggerNonBlank();

  $("#competition_category").change(function() {
    checkToTriggerNonBlank();
  })

  function checkToTriggerNonBlank() {
    var selectedText = $("#competition_category option:selected").val()
    if (selectedText == "") {
      $("#competition_category").css("color", "#999999")
    } else {
      $("#competition_category").css("color", "black")
    }
  }
})