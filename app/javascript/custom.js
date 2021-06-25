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

window.show_more_less_venue_contacts = () => {
  $(".venue_contacts_card").find(".venue_contact_row").not(":eq(0)").not(":eq(0)").not(":eq(0)").not(":eq(0)").not(":eq(0)").hide();
  if($(".venue_contacts_card").find(".venue_contact_row").length <= 5){
    $('.load_more_venue_contacts').removeClass('d-flex')
    $('.load_more_venue_contacts').hide();
  } else {
    $('.load_more_venue_contacts').addClass('d-flex')
    $('.load_more_venue_contacts').show();
  }
  $('.load_more_venue_contacts').on('click', function(){
    if($('.venue_contacts_card').hasClass('venue_contacts_more')){
      $(".venue_contacts_card").find(".venue_contact_row").not(":eq(0)").not(":eq(0)").not(":eq(0)").not(":eq(0)").not(":eq(0)").hide();
      $('.venue_contacts_card').removeClass('venue_contacts_more')
      $('.venue_contact_show_lable').text('See More...');
    } else {
      $('.venue_contacts_card').addClass('venue_contacts_more')
      $(".venue_contacts_card").find(".venue_contact_row").show();
      $('.venue_contact_show_lable').text('See Less...');
    }
  })
}

document.addEventListener("turbolinks:load", function () {
  $input = $("[data-behavior='autocomplete']")
  var options = {
    getValue: "name",
    url: function (phrase) {
      return "/homes/search.json?search=" + phrase;
    },
    categories: [{
        listLocation: "businesses",
        header: "<div class='search-option-header'>Businesses</div>",
      },
      {
        listLocation: "venues",
        header: "<div class='search-option-header'>Venues</div>",
      }
    ],
    list: {
      onChooseEvent: function (e) {
        var url = $input.first().getSelectedItemData().url
        if(url == undefined){
          url = $input.last().getSelectedItemData().url
        }
        $input.val("")
        Turbolinks.visit(url)
        console.log(url)
      }
    },
    template: {
      type: "iconLeft",
      fields: {
        iconSrc: "icon"
      }
    }
  }
  $input.easyAutocomplete(options)
});
