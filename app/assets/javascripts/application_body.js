//= require jquery
//= require jquery_ujs
//= require foundation
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.foundation

$(function(){ $(document).foundation(); });

$('.datatable').dataTable({
    "sPaginationType": "foundation",
    "paging": false
});
