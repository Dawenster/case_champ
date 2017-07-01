$(document).ready(function(){
  $('.datepicker').datepicker({
    format: 'M d, yyyy'
  });

  checkToTriggerNonBlank();

  $(".competition_category:visible").change(function() {
    checkToTriggerNonBlank();
  })

  function checkToTriggerNonBlank() {
    var selectedText = $(".competition_category:visible option:selected").val()
    if (selectedText == "") {
      $(".competition_category:visible").css("color", "#999999")
      $(".competition_category:visible").val("")
    } else {
      $(".competition_category:visible").css("color", "black")
      $(".competition_category:hidden").val("&nbsp;&nbsp;&nbsp;" + selectedText).change()
    }
  }

  $(document).on('nested:fieldAdded', function(event){
    var field = event.field;
    var input = field.find("input");
    if (input.hasClass("prize-field")) {
      var count = $(".prize-field").length;
      input.attr("placeholder", ordinal_suffix_of(count) + " Place Prize");
      input.siblings(".rank-field").val(count);
      input.removeAttr("required")
    } else if (input.hasClass("date-field")) {
      $('.datepicker').datepicker({
        format: 'M d, yyyy'
      });

      input.removeAttr("required")

      for (var i = input.length - 1; i >= 0; i--) {
        var existingPlaceholder = $(input[i]).attr("placeholder")
        $(input[i]).attr("placeholder", existingPlaceholder.substring(0, existingPlaceholder.length - 1));
      }
    }
  })
});
