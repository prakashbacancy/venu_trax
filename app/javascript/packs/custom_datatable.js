window.custom_datatable = function(table){
  let dataTable = table.DataTable({
    dom: 't<"dataTable-bottom"lp>',
    language: {
      paginate: {
        previous: "< Back",
        next: "Next >"
      },
      lengthMenu: "_MENU_ Result per page"
    },
    pageLength: 10
  });
  $('.search_btn').on('click', function(){
    dataTable.search($('#searchbox').val()).draw();
  })
}