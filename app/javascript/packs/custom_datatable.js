window.custom_datatable = function(table){
  let dataTable;
  if($.fn.dataTable.isDataTable('#'+table.attr('id'))) {
    dataTable = table.DataTable();
  } else {
    dataTable = table.DataTable({
      dom: 't<"dataTable-bottom flex-wrap mb-3"lp>',
      language: {
        paginate: {
          previous: "< Back",
          next: "Next >"
        },
        lengthMenu: "_MENU_ Result per page"
      },
      columnDefs: [ {
        // Remove `orderable` from `Action` column of our tables
        targets: [table.find('th').length - 1],
        orderable: false
      }],
      pageLength: 10,
      order: [],
    });
  }
  $('.search_btn').on('click', function(){
    dataTable.search($('#searchbox').val()).draw();
  })
}