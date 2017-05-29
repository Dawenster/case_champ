function ordinal_suffix_of(i) {
  var j = i % 10,
      k = i % 100;

  if (j == 1 && k != 11) {
    return i + "st";
  }

  if (j == 2 && k != 12) {
    return i + "nd";
  }

  if (j == 3 && k != 13) {
    return i + "rd";
  }
  
  return i + "th";
}

function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#targetImageLocation').css('background-image', 'url(' + e.target.result + ')');
      $("#targetImageLocation").removeClass("hide")
    }

    reader.readAsDataURL(input.files[0]);
  }
}

function displayFilename(input) {
  if (input.files && input.files[0]) {
    var filename = input.value.replace(/.*[\/\\]/, '');
    $(".display-filename").html(filename);
  }
}

$(document).ready(function(){
  $("#image-fileupload").change(function(){
    readURL(this);
  });
});

$(document).ready(function(){
  $("#fileupload").change(function(){
    displayFilename(this);
  });
});