$(document).on('keyup keypress', '.phone-number', function(e){
  phone_number = /^(1\s?)?((\([0-9]{3}\)-)|[0-9]{3})[\s\-]?[\0-9]{3}-[\s\-]?[0-9]{4}$/
  space_regex = /\(?\d{3}\)?[ ]\d{3}?[ ]\d{4}/
  dash_regex = /^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}$/
  var curchr = this.value.length;
  var curval = $(this).val();
  if (curchr == 3 && curval.indexOf("(") <= -1) {
    if (e.which != 8){
      $(this).val("(" + curval + ")" + " ");
    }
  } else if (curchr == 4 && curval.indexOf("(") > -1) {
    if (e.which != 8){
      $(this).val(curval + ")-");
    }
  } else if (curchr == 5 && curval.indexOf(")") > -1) {
    if (e.which != 8){
      $(this).val(curval + "-");
    }
  } else if (curchr == 9) {
    if (e.which != 8){
      $(this).val(curval + "-");
    }
    $(this).attr('maxlength', '14');
  }
});