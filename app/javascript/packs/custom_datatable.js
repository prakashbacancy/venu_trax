window.custom_datatable = function(table){
  let dataTable;
  if($.fn.dataTable.isDataTable('#'+table.attr('id'))) {
    dataTable = table.DataTable();
  } else {
    dataTable = table.DataTable({
      dom: 't<"dataTable-bottom flex-md-row flex-column"lp>',
      language: {
        paginate: {
          previous: "< Back",
          next: "Next >"
        },
        lengthMenu: "_MENU_ Result per page"
      },
      pageLength: 10
    });
  }
  $('.search_btn').on('click', function(){
    dataTable.search($('#searchbox').val()).draw();
  })

}