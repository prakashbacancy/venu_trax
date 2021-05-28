$(document).on('turbolinks:load', function(){
  setupPercentageField()
})
function setupPercentageField() {
  $('input.percentageField').each(function(){
    if ($(this).val() != ""){
      $(this).val('$' + $(this).val().replace('$', ''));
    }
  });
  $(document).on('focusin', '.percentageField', function() {
    $(this).val($(this).val().replace('$', '').replace(' ', ''));
  });

  $(document).on('focusout', '.percentageField', function() {
    if ($(this).val() != '') {
      $(this).val('$' + $(this).val().replace('$', ''));
    }
  });

  $(document).on('keypress', '.percentageField', function(event) {
    var key = event.keyCode;
    return (key >= 48 && key <= 57) || ((!$(this).val().includes('.')) && key == 46)
  });
}
