$(document).ready(function(){
  $('.datepicker').datepicker({
    format: 'M d, yyyy'
  });

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

  $(document).on('nested:fieldAdded', function(event){
    var field = event.field; 
    var input = field.find("input");
    if (input.hasClass("prize-field")) {
      var count = $(".prize-field").length;
      input.attr("placeholder", ordinal_suffix_of(count) + " Place Prize");
      input.siblings(".rank-field").val(count);
    } else {
      $('.datepicker').datepicker({
        format: 'M d, yyyy'
      });
    }
  })
});