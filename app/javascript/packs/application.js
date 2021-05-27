// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"


require('jquery')
require("bootstrap")
require("@fortawesome/fontawesome-free/css/all.css")
require("chartkick")
require("chart.js")
require("parsleyjs")
// require("packs/app.min.js")
require("packs/custom_datatable.js")
require("packs/custom_ckeditor.js")
require("packs/bootstrap-datetimepicker.min")
require('timepicker')
import 'timepicker/jquery.timepicker.css';
import 'stylesheets/application'
import 'chartjs-plugin-datalabels'
import 'custom';
import 'simulation';
require("packs/jquery-ui.js")
require("packs/crm.js")
// import "../stylesheets/application";
document.addEventListener("turbolinks:load", function() {
    $(function () {
      // Todo: Temporary fix. Put outside and check the issue. 
      require("packs/custom_multi_select.js")
      $('[data-toggle="tooltip"]').tooltip()
      $('[data-toggle="popover"]').popover()
    })
})
const images = require.context('../images', true)
window.jQuery = $;
window.$ = $;

require("datatables.net")
require('datatables.net-bs4')
require("datatables.net-bs4/css/dataTables.bootstrap4.min.css")

const dataTables = [];

Crm.events.onLoaded(function() {
  $('.timepicker').timepicker({timeFormat: 'h:i A'});
  $('.timepicker').attr('autocomplete', 'nope')
  $('.timeend, .timestart').attr('autocomplete', 'off')
  
  // $('.datepicker').datepicker({format: 'mm/dd/yyyy', todayHighlight: true, autoclose: true});
  // $('.timepicker').timepicker({timeFormat: 'h:i A'});
  // $('.timepicker').datetimepicker({
  //   format: "h:i A",
  //   icons: {
  //     date: "fa fa-calendar",
  //     up: "fa fa-arrow-up",
  //     down: "fa fa-arrow-down",
  //     previous: "fa fa-chevron-left",
  //     next: "fa fa-chevron-right",
  //     today: "fa fa-clock-o",
  //     clear: "fa fa-trash-o"
  //   }
  // });
  $('.datepicker').datetimepicker({
    format: "MM/DD/YYYY",
    icons: {
      date: "fa fa-calendar",
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-chevron-left",
      next: "fa fa-chevron-right",
      today: "fa fa-clock-o",
      clear: "fa fa-trash-o"
    }
  })
  $('.datetimepicker').datetimepicker({
    icons: {
      date: "fa fa-calendar",
      up: "fa fa-arrow-up",
      down: "fa fa-arrow-down",
      previous: "fa fa-chevron-left",
      next: "fa fa-chevron-right",
      today: "fa fa-clock-o",
      clear: "fa fa-trash-o"
    }
  })
  $('.datetimepicker').on('dp.change', function(e){ 
    // debugger;
    // console.log(e.date); 
  })
});

document.addEventListener("turbolinks:load", () => {
  $('form').parsley();
  if (dataTables.length === 0 && $('.data-table').length !== 0) {
    $('.data-table').each((_, element) => {
      dataTables.push($(element).DataTable({
        pageLength: 50
      }));
    });
  }
});

document.addEventListener("turbolinks:before-cache", () => {
  while (dataTables.length !== 0) {
    dataTables.pop().destroy();
  }
});

Rails.start()
Turbolinks.start()
ActiveStorage.start()
