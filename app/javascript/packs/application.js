// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import 'stylesheets/application'

require('jquery')
require("bootstrap")
require("@fortawesome/fontawesome-free/css/all.css")
require("chartkick")
require("chart.js")
require("parsleyjs")
// require("packs/app.min.js")
require("packs/custom_datatable.js")

// import "../stylesheets/application";
document.addEventListener("turbolinks:load", function() {
    $(function () {
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
